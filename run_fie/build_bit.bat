set XILINX_EDK=E:\Xilinx\14.7\ISE_DS\EDK\
set XILINX=E:\Xilinx\14.7\ISE_DS\ISE\
set ECLIPSE=%XILINX_EDK%eclipse\nt64\eclipse\eclipsec.exe
set VM=%XILINX%java6\nt64\jre\bin\

set WSPACE=.\build\%1\fie\fie.sdk\SDK\SDK_Export
set HW=%WSPACE%\mb_sys_hw_platform\
set BSP=%WSPACE%\fip_bsp\
set BSPNAME=fip_bsp
set APP=%WSPACE%\fip\
set APPNAME=fip

set PATH=%PATH%;%XILINX_EDK%\gnuwin\bin;%XILINX_EDK%\gnu\microblaze\nt\bin

START /WAIT xsdk -wait -bit .\build\%1\fie\fie.sdk\SDK\SDK_Export\hw\fie.bit -bmm .\build\%1\fie\fie.sdk\SDK\SDK_Export\hw\fie_bd.bmm -workspace .\build\%1\fie\fie.sdk\SDK\SDK_Export -hwspec .\build\%1\fie\fie.sdk\SDK\SDK_Export\hw\mb_sys.xml -eclipseargs --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -cleanBuild all -data %WSPACE%

SLEEP 2

START /WAIT data2mem -bm .\build\%1\fie\fie.sdk\SDK\SDK_Export\mb_sys_hw_platform\system_bd.bmm -bt .\build\%1\fie\fie.sdk\SDK\SDK_Export\mb_sys_hw_platform\system.bit -bd .\build\%1\fie\fie.sdk\SDK\SDK_Export\fip\Debug\fip.elf tag fip_inst_mb_sys_inst_mb_sys_i_microblaze_0 -o b .\build\%1\fie\fie.sdk\SDK\SDK_Export\mb_sys_hw_platform\download.bit