set DUT_NAME "dummy"

xload xmp "./build/$DUT_NAME/mb_sys/mb_sys.xmp"
xset parallel_synthesis no
run resync
run netlist
exit