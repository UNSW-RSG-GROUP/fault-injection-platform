setMode -bs
setCable -port auto
Identify -inferir
identifyMPM
assignFile -p 2 -file "./staging/aes_1/download.bit"
setCable -port usb21 -baud 12000000
Program -p 2
exit
