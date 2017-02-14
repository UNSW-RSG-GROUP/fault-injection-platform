#!/bin/bash
rsync -av --include=*/ /cygdrive/e/run_fie/staging /cygdrive/e/run_inject
cp /cygdrive/e/run_fie/dut/README.txt /cygdrive/e/run_inject/staging