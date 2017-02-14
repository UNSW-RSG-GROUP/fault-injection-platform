#!/bin/bash  
#rsync -av --include=*/ /cygdrive/e/run_fie/build /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/ 
#rsync -av --include=*/ /cygdrive/e/run_fie/dut /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/
#cp /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/dut/README.txt /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/
#cp /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/dut/config.xst /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/
# tar -cvzf /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1.tar /cygdrive/e/run_fie/dut /cygdrive/e/run_fie/build /cygdrive/e/run_fie/staging
rm -r -f /cygdrive/e/run_fie/dut
rm -r -f /cygdrive/e/run_fie/build
rm -r -f /cygdrive/e/run_fie/staging
mkdir dut
mkdir build
mkdir staging