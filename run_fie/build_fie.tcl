set DUT_NAME [lindex $argv 0]

create_project fie "./build/$DUT_NAME/fie" -part xc6vlx240tff1156-1

set_property board ml605 [current_project]

import_files -flat -fileset sources_1 "./base/fie.vhd"
import_files -flat -fileset sources_1 "./base/fip.vhd"
import_files -flat -fileset sources_1 "./base/mb_sys_stub.v"
import_files -flat -fileset sources_1 "./dut/$DUT_NAME/top.v"
import_files -flat -fileset sources_1 "./base/div_signed.v"
import_files -flat -fileset sources_1 "./base/div_unsigned.v"
import_files -flat -fileset sources_1 [glob "./dut/$DUT_NAME/*.mif"]
import_files -flat -fileset constrs_1 "./base/io.ucf"
import_files -flat -fileset constrs_1 "./base/floorplan.ucf"
add_files -fileset sources_1 "./build/$DUT_NAME/mb_sys/mb_sys.xmp"

set_property -name {steps.bitgen.args.More Options} -value {-f E:/run_fie/base/fie.ut} -objects [get_runs impl_1]

set_property -name {steps.xst.args.More Options} -value {-ifn E:/run_fie/base/config.xst} -objects [get_runs synth_1]
launch_runs synth_1
if {[catch {wait_on_run synth_1}]} {
    puts "--SYNTHESIS FAILED!"
    exit
}
if {[get_property STATUS [get_runs synth_1]] == {XST Complete!}} {
    puts "--SYNTHESIS SUCCEEDED!"
} else {
    puts "--SYNTHESIS FAILED!"
    exit
}
launch_runs impl_1
wait_on_run impl_1
if {[get_property STATUS [get_runs impl_1]] == {PAR Complete!}} {
    set d [get_property DIRECTORY [get_runs impl_1]]
    set f [glob $d/*routed.par]
    set chan [open $f]
    while {[gets $chan line] >= 0} {
    if {[string match "Timing Score*" $line]} {set score [lindex $line 2] }
    }
    close $chan
    if {$score == 0} {
        puts "--IMPLEMENTATION SUCCEEDED!"
    } else {
        puts "--IMPLEMENTATION SUCCEEDED!"
        exit
    }
    puts "--IMPLEMENTATION SUCCEEDED!"
} else {
    puts "--IMPLEMENTATION FAILED!"
    exit
}

launch_runs impl_1 -to_step Bitgen
wait_on_run impl_1
if {[get_property STATUS [get_runs impl_1]] == {Bitgen Complete!}} {
    puts "--BITGEN SUCCEEDED!"
} else {
    puts "--BITGEN FAILED!"
    exit
}

open_run impl_1

export_hardware [get_files "./build/$DUT_NAME/mb_sys/mb_sys.xmp"] [get_runs impl_1] -bitstream

exit