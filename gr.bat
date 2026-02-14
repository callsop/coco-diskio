@call setuppaths.bat
lwasm.exe --6809 --list=READ.LST --symbols --6800compat --output=READ.BIN --format=decb read.asm
xroar.exe -m coco3p -tv-type ntsc -load-fd0 blank.dsk -run READ.BIN