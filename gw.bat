@call setuppaths.bat
call makeblank.bat
lwasm.exe --6809 --list=WRITE.LST --symbols --6800compat --output=WRITE.BIN --format=decb write.asm
xroar.exe -m coco3p -tv-type ntsc -load-fd0 blank.dsk -run WRITE.BIN