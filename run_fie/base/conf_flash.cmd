setMode -pff                                                                                                           
addConfigDevice  -name "download" -path "E:/run_inject/staging/dummy"                                                                
setSubmode -pffbpi                                                                                                     
setAttribute -configdevice -attr multibootBpiType -value "TYPE_BPI"                                                    
setAttribute -configdevice -attr multibootBpiDevice -value "VIRTEX6"                                                   
setAttribute -configdevice -attr multibootBpichainType -value "PARALLEL"                                               
addDesign -version 0 -name "0"                                                                                         
setMode -pff                                                                                                           
addDeviceChain -index 0                                                                                                
setMode -pff                                                                                                           
addDeviceChain -index 0                                                                                                
setAttribute -configdevice -attr compressed -value "FALSE"                                                             
setAttribute -configdevice -attr compressed -value "FALSE"                                                             
setAttribute -configdevice -attr autoSize -value "FALSE"                                                               
setAttribute -configdevice -attr fileFormat -value "mcs"                                                               
setAttribute -configdevice -attr fillValue -value "FF"                                                                 
setAttribute -configdevice -attr swapBit -value "FALSE"                                                                
setAttribute -configdevice -attr dir -value "UP"                                                                       
setAttribute -configdevice -attr multiboot -value "FALSE"                                                              
setAttribute -configdevice -attr multiboot -value "FALSE"                                                              
setAttribute -configdevice -attr spiSelected -value "FALSE"                                                            
setAttribute -configdevice -attr spiSelected -value "FALSE"                                                            
setAttribute -configdevice -attr ironhorsename -value "1"                                                              
setAttribute -configdevice -attr flashDataWidth -value "16"                                                            
setCurrentDesign -version 0                                                                                            
setAttribute -design -attr RSPin -value ""                                                                             
setCurrentDesign -version 0                                                                                            
addPromDevice -p 1 -size 32768 -name 32M                                                                               
setMode -pff                                                                                                           
setMode -pff                                                                                                           
setMode -pff                                                                                                           
setMode -pff                                                                                                           
addDeviceChain -index 0                                                                                                
setMode -pff                                                                                                           
addDeviceChain -index 0                                                                                                
setMode -pff                                                                                                           
setSubmode -pffbpi                                                                                                     
setMode -pff                                                                                                           
setAttribute -design -attr RSPin -value "00"                                                                           
addDevice -p 1 -file "E:/run_inject/staging/dummy/download.bit"               
setAttribute -design -attr RSPinMsb -value "1"                                                                         
setAttribute -design -attr name -value "0"                                                                             
setAttribute -design -attr RSPin -value "00"                                                                           
setAttribute -design -attr endAddress -value "8ce03b"                                                                  
setAttribute -design -attr endAddress -value "8ce03b"                                                                  
setMode -pff                                                                                                           
setSubmode -pffbpi                                                                                                     
generate                                                                                                               
setCurrentDesign -version 0                                                                                            
setMode -bs                                                                                                            
setCable -p auto                                                                                                       
identify                                                                                                               
identifyMPM                                                                                                            
attachflash -position 2 -bpi "28F256P30"                                                                               
assignfiletoattachedflash -position 2 -file "E:/run_inject/staging/dummy/download.mcs"                                                                
Program -p 2 -dataWidth 16 -rs1 NONE -rs0 NONE -bpionly -e -loadfpga                                                
closeCable                                                                                                             
quit                                                                                                                                                                                                                                          