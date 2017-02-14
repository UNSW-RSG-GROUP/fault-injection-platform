#!/bin/bash  
rsync -av --include=*/ /cygdrive/e/run_fie/build /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/ 
rsync -av --include=*/ /cygdrive/e/run_fie/dut /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/
cp /cygdrive/e/run_fie/dut/README.txt /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/
cp /cygdrive/e/run_fie/dut/config.xst /cygdrive/e/PhDLocal/Papers/TLegup/ready/$1/