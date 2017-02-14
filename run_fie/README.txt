hardcoded inside the build_fie.tcl file
set_property -name {steps.bitgen.args.More Options} -value {-f E:/run_fie/base/fie.ut} -objects [get_runs impl_1]

hardcoded inside the build_fie.tcl file build_bit.bat
set XILINX_EDK=E:\Xilinx\14.7\ISE_DS\EDK\
set XILINX=E:\Xilinx\14.7\ISE_DS\ISE\
add_files -fileset sources_1 "E:/run_fie/build/$DUT_NAME/mb_sys/mb_sys.xmp"

hardcoded inside the build_bit.bat
set XILINX_EDK=E:\Xilinx\14.7\ISE_DS\EDK\
set XILINX=E:\Xilinx\14.7\ISE_DS\ISE\
set ECLIPSE=%XILINX_EDK%eclipse\nt64\eclipse\eclipsec.exe
set VM=%XILINX%java6\nt64\jre\bin\


Set in PATH
C:\Xilinx\14.7\ISE_DS\EDK\bin\nt64
C:\Xilinx\14.7\ISE_DS\PlanAhead\bin
C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64