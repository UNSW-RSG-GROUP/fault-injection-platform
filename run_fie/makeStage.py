#!/usr/bin/python
import sys
import getopt
import os
import tempfile
import shutil
import stat
import multiprocessing
import subprocess
import re
import time
import distutils

def onerror(func, path, exc_info):
    if not os.access(path, os.W_OK):
        os.chmod(path, stat.S_IWUSR)
        func(path)

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

def make_stage_fie(dut_name):
    build_path = "./build/" + dut_name

    shutil.copy(build_path + "/fie/fie.runs/impl_1/fie.bit",
                build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/system.bit")
    shutil.copy(build_path + "/fie/fie.runs/impl_1/fie.ebd",
                build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/download.ebd")
    shutil.copy(build_path + "/fie/fie.sdk/SDK/SDK_Export/hw/fie_bd.bmm",
                build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/system_bd.bmm")
    if os.path.exists(build_path + "/fie/fie.sdk/SDK/SDK_Export/fip/src"):
        shutil.rmtree(build_path + "/fie/fie.sdk/SDK/SDK_Export/fip/src")
    shutil.copytree("./base/fie.sdk/SDK/SDK_Export/fip/src", build_path + "/fie/fie.sdk/SDK/SDK_Export/fip/src")

    time.sleep(5)
    os.system("./build_bit.bat " + dut_name)
    time.sleep(5)
    staging_path = "E:/run_inject/staging/" + dut_name
    if os.path.exists(staging_path):
        shutil.rmtree(staging_path, onerror=onerror)
    # Create build path
    os.mkdir(staging_path)

    shutil.copy(build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/download.bit",
                staging_path + "/download.bit")
    shutil.copy(build_path + "/fie/fie.sdk/SDK/SDK_Export/mb_sys_hw_platform/download.ebd",
                staging_path + "/download.ebd")
    shutil.copy("./dut/" + dut_name + "/info.txt", staging_path + "/info.txt")
    shutil.copy("./base/conf_flash.bat", staging_path + "/config_flash.bat")
    shutil.copy("./base/conf_flash.cmd", staging_path + "/config_flash.cmd")
    replace(staging_path + "/config_flash.cmd",
            "addConfigDevice  -name \"download\" -path \"E:/run_inject/staging/dummy\"   ",
            "addConfigDevice  -name \"download\" -path \"E:/run_inject/staging/" + dut_name + "\"")
    replace(staging_path + "/config_flash.cmd",
            "addDevice -p 1 -file \"E:/run_inject/staging/dummy/download.bit\"  ",
            "addDevice -p 1 -file \"E:/run_inject/staging/" + dut_name + "/download.bit\"  ")
    replace(staging_path + "/config_flash.cmd",
            "assignfiletoattachedflash -position 2 -file \"E:/run_inject/staging/dummy/download.mcs\"   ",
            "assignfiletoattachedflash -position 2 -file \"E:/run_inject/staging/" + dut_name + "/download.mcs\"   ")
    time.sleep(3)
    file = open(build_path + "/done.txt", 'w+')
    now = time.strftime("%c")
    file.write("Implentation done\r\n" + dut_name + "\r\nFinished: " + now)
    file.close()
    shutil.copy(build_path + "/done.txt", "./dut/" + dut_name + "/done.txt")
    time.sleep(2)


def main(argv):
   inputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["ifile="])
   except getopt.GetoptError:
      print('test.py -i <inputfile>')
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print('test.py -i <inputfile> -o <outputfile>')
         sys.exit()
      elif opt in ("-i", "--ifile"):
         inputfile = arg
   print("Creating stage and updating new bitstream for dut: " + inputfile)
   make_stage_fie(inputfile)

if __name__ == "__main__":
   main(sys.argv[1:])