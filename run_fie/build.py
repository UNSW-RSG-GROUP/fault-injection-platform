import os
import tempfile
import shutil
import stat
import multiprocessing
import subprocess
import re
import time
import math
import smtplib
from email.mime.text import MIMEText

RATION = 0.9

def round_down(n, nearest):
    return int(math.floor(n / 10.0)) * 10


def onerror(func, path, exc_info):
    if not os.access(path, os.W_OK):
        os.chmod(path, stat.S_IWUSR)
        func(path)

def send_email(message):
    fromx = 'agiakatsikas@gmail.com'
    to = 'agiakatsikas@gmail.com'
    msg = MIMEText('Done')
    msg['Subject'] = message
    msg['From'] = fromx
    msg['To'] = to

    server = smtplib.SMTP('smtp.gmail.com:587')
    server.starttls()
    server.ehlo()
    server.login('agiakatsikas@gmail.com', '!Avrinside2016!')
    server.sendmail(fromx, to, msg.as_string())
    server.quit()


def get_dut_info(dut_name, field):
    try:
        with open("./dut/" + dut_name + "/info.txt") as f:
            for line in f:
                if field in line:
                    m = re.search(field + " = (.*)\n", line)
                    return m.group(1)
    except IOError:
        pass
    else:
        return None


def replace(file_path, pattern, subst):
    # Create temp file
    fh, abs_path = tempfile.mkstemp()
    with open(abs_path,'w') as new_file:
        with open(file_path) as old_file:
            for line in old_file:
                new_file.write(line.replace(pattern, subst))
    os.close(fh)
    # Remove original file
    os.remove(file_path)
    # Move new file
    shutil.move(abs_path, file_path)


def build_fie_init(q):
    build_fie.q = q


def build_fie(dut_name):
    if not os.path.isfile("./dut/" + dut_name + "/done.txt"):
        print(dut_name)
        build_path = "./build/" + dut_name
        # Check if build path already exists, delete it if it does.
        if os.path.exists(build_path):
            shutil.rmtree(build_path, onerror=onerror)
        # Create build path
        os.mkdir(build_path)

        # Create status file
        startTime = time.strftime("%c")
        file = open(build_path + "/status.txt", 'w+')
        file.write("Start time: " + startTime + "\r\n")
        file.close()

        # Copy the base microblaze system to build path
        shutil.copytree("./base/mb_sys", build_path + "/mb_sys")
        # Copy the script for building the microblaze system to build path
        shutil.copy("./build_mb_sys.tcl", build_path + "/mb_sys")
        # Inject DUT name to tcl script (required since Xilinx XPS does not accept TCL arguments)
        replace(build_path + "/mb_sys/build_mb_sys.tcl", "set DUT_NAME \"dummy\"", "set DUT_NAME \"" + dut_name + "\"")
        build_fie.q.put((dut_name, 1))
        # Update Frequency
        fmax = int(float(get_dut_info(dut_name, "maxFreq")))
        file = open(build_path + "/status.txt", 'a+')
        file.write("Max init freq: " + str(fmax) + " MHz\r\n")
        file.close()
        if fmax:
            fmax = round_down(fmax * RATION, 10) * 1000000
            file = open(build_path + "/status.txt", 'a+')
            file.write("Used Max freq: " + str(fmax) + "\r\n")
            file.close()
        else:
            build_fie.q.put((dut_name, -6))
            shutil.rmtree(build_path, onerror=onerror)
            return

        replace(build_path + "/mb_sys/mb_sys.mhs",
                " PORT clk_dut = clock_generator_0_CLKOUT1, DIR = O, SIGIS = CLK, CLK_FREQ = 100000000",
                " PORT clk_dut = clock_generator_0_CLKOUT1, DIR = O, SIGIS = CLK, CLK_FREQ = " + str(fmax))
        replace(build_path + "/mb_sys/mb_sys.mhs",
                " PARAMETER C_CLKOUT1_FREQ = 100000000",
                " PARAMETER C_CLKOUT1_FREQ = " + str(fmax))

        p = subprocess.Popen("xps -nw -scr " + build_path + "/mb_sys/build_mb_sys.tcl", stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
        time.sleep(2)
        p.wait()
        os.mkdir(build_path + "/fie")
        shutil.copytree("./base/fie.sdk", build_path + "/fie/fie.sdk")
        build_fie.q.put((dut_name, 2))
        file = open(build_path + "/status.txt", 'a+')
        file.write("MB UPDATED!\r\n")
        file.close() #-mode batch
        #shutil.copy("./base/dummy.mif", ".dut/" + dut_name + "/")

        p = subprocess.Popen("planahead -nolog -nojournal -mode batch -source build_fie.tcl -tclargs " + dut_name, stdout = subprocess.PIPE, stderr = subprocess.STDOUT, shell = True, universal_newlines=True)
        for line in p.stdout:
            if line == "--SYNTHESIS SUCCEEDED!\n":
                build_fie.q.put((dut_name, 3))
                file = open(build_path + "/status.txt", 'a+')
                file.write("SYNTHESIS SUCCEEDED!\r\n")
                file.close()
            elif line == "--SYNTHESIS FAILED!\n":
                build_fie.q.put((dut_name, -3))
                file = open(build_path + "/status.txt", 'a+')
                file.write("SYNTHESIS FAILED!\r\n")
                file.close()
                #send_email('Benchmark: ' + dut_name + ' SYNTHESIS FAILED!')
                time.sleep(1)
                return
            elif line == "--IMPLEMENTATION SUCCEEDED!\n":
                build_fie.q.put((dut_name, 4))
                file = open(build_path + "/status.txt", 'a+')
                file.write("IMPLEMENTATION SUCCEEDED!\r\n")
                file.close()
            elif line == "--IMPLEMENTATION FAILED!\n":
                build_fie.q.put((dut_name, -4))
                file = open(build_path + "/status.txt", 'a+')
                file.write("IMPLEMENTATION FAILED!\r\n")
                file.close()
                #send_email('Benchmark: ' + dut_name + ' IMPLEMENTATION FAILED!')
                time.sleep(1)
                return
            elif line == "--BITGEN SUCCEEDED!\n":
                build_fie.q.put((dut_name, 5))
                file = open(build_path + "/status.txt", 'a+')
                file.write("BITGEN SUCCEEDED!\r\n")
                file.close()
                #send_email('Benchmark: ' + dut_name + ' BITGEN SUCCEEDED!')
                time.sleep(1)
            elif line == "--BITGEN FAILED!\n":
                build_fie.q.put((dut_name, -5))
                file = open(build_path + "/status.txt", 'a+')
                file.write("BITGEN FAILED!\r\n")
                file.close()
                #send_email('Benchmark: ' + dut_name + ' BITGEN FAILED!')
                time.sleep(1)
                return

        p.wait()
        time.sleep(5)
        # shutil.copy(build_path + "/fie/fie.runs/impl_1/fie.bit", build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/system.bit")
        # shutil.copy(build_path + "/fie/fie.runs/impl_1/fie.ebd", build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/download.ebd")
        # shutil.copy(build_path + "/fie/fie.sdk/SDK/SDK_Export/hw/fie_bd.bmm", build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/system_bd.bmm")
        # shutil.copy(build_path + "/fie/fie.sdk/SDK/SDK_Export/hw/mb_sys.xml", build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/system.xml")
        # time.sleep(1)
        #p = subprocess.Popen("build_bit.bat " + dut_name, stdout=subprocess.DEVNULL,
        #                     stderr=subprocess.STDOUT)
        #p = subprocess.Popen("python ./makeStage.py -i " + dut_name, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
        #p.wait()
        # time.sleep(2)
        # staging_path = "./staging/" + dut_name
        # if os.path.exists(staging_path):
        #     shutil.rmtree(staging_path, onerror=onerror)
        # # Create build path
        # os.mkdir(staging_path)
        #
        # shutil.copy(build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/download.bit",
        #             staging_path + "/download.bit")
        # shutil.copy(build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/download.ebd",
        #             staging_path + "/download.ebd")
        # shutil.copy("./dut/" + dut_name + "/info.txt", staging_path + "/info.txt")
        #
        # #shutil.copy("./base/conf_flash.bat", staging_path + "/config_flash.bat")
        # shutil.copy("./base/conf_flash.cmd", staging_path + "/config_flash.cmd")
        # replace(staging_path + "/config_flash.cmd",
        #         "addConfigDevice  -name \"download\" -path \"E:/run_fie/staging/dummy\"   ",
        #         "addConfigDevice  -name \"download\" -path \"E:/run_inject/staging/" + dut_name + "\"")
        # replace(staging_path + "/config_flash.cmd",
        #         "addDevice -p 1 -file \"E:/run_fie/staging/dummy/download.bit\"  ",
        #         "addDevice -p 1 -file \"E:/run_inject/staging/" + dut_name + "/download.bit\"  ")
        # replace(staging_path + "/config_flash.cmd",
        #         "assignfiletoattachedflash -position 2 -file \"E:/run_fie/staging/dummy/download.mcs\"   ",
        #         "assignfiletoattachedflash -position 2 -file \"E:/run_inject/staging/" + dut_name + "/download.mcs\"   ")

        #build_fie.q.put((dut_name, 6))
        now = time.strftime("%c")
        #file = open(build_path + "/status.txt", 'a+')
        #file.write("BITGEN SOURCE UPDATED!\r\n")
        #file.write("Finished time: " + now + "\r\n")
        #file.close()
        file = open("./dut/" + dut_name + "/done.txt", 'w+')
        file.write("Start time: " + startTime + "\r\n")
        file.write("Finished time: " + now + "\r\n")
        file.close()
        #if (dut_name == "bellmanford_5"):

def print_status(status):
    os.system('cls' if os.name == 'nt' else 'clear')
    for k in status.keys():
        print('{0:<20}: ['.format(k), end="")
        if status[k] == 0:
            print("      ] : NOT STARTED!")
        elif status[k] == 1:
            print("+     ] : STARTED!")
        elif status[k] == 2:
            print("++    ] : MB UPDATED!")
        elif status[k] == 3:
            print("+++   ] : SYNTHESIS SUCCEEDED!")
        elif status[k] == -3:
            print("++-   ] : SYNTHESIS FAILED!")
        elif status[k] == 4:
            print("++++  ] : IMPLEMENTATION SUCCEEDED!")
        elif status[k] == -4:
            print("+++-  ] : IMPLEMENTATION FAILED!")
        elif status[k] == 5:
            print("+++++ ] : BITGEN SUCCEEDED!")
        elif status[k] == -5:
            print("++++- ] : BITGEN FAILED!")
        elif status[k] == -6:
            print("-     ] : NO INFO FILE!")
        elif status[k] == 6:
            print("++++++] : SOFTWARE COMPILED AND UPDATED BITSTREAM!")


def main():
    if os.path.exists("./base/config.xst"):
        os.remove("./base/config.xst")
    shutil.copy("./dut/config.xst","./base/")
    dut_names = [f for f in os.listdir("./dut") if os.path.isdir(os.path.join("./dut", f))]
    update_queue = multiprocessing.Queue()
    status = dict((k, 0) for k in dut_names)
    pool = multiprocessing.Pool(processes=1, initializer=build_fie_init, initargs=[update_queue])

    # Set chunksize=1
    job = pool.map_async(build_fie, dut_names, chunksize=1)
    print_status(status)
    while not job.ready():
        report = update_queue.get(block=True)
        status[report[0]] = report[1]
        print_status(status)

if __name__ == '__main__':
    main()

