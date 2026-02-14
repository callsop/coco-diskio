
# About #

An example of writing to a file with assembly using DISKIO.ASM. No idea who authored this assembly file, it was given to me in 1985, I've only added the DEOF function. The files, write.asm and read.asm will show how to write some data to a blank disk and read it back. Only DISKIO.ASM is required to use in your own programs.

### Notes ###

Set SPEED as 0 (normal) or 1 (high) as this will restore the clock speed after I/O functions are done. The I/O functions run at normal speed.

It should go without saying but reading/writing a byte at a time isn't fast, if you want that then access the sectors directly with $DSKCON.

### Example Requirements ###

- [Toolshed 2.4](https://github.com/nitros9project/toolshed)
- [Lwtools 4.24](http://www.lwtools.ca)
- [XRoar 1.8](https://www.6809.org.uk/xroar/)

Note: Replace paths in setuppaths.bat with yours.

### Example ###

Run write.asm (writes 'A BUNCH OF DATA' to MYFILE.DAT):
```
> gw.bat
```

See result:
```
> show.bat
c:\Programs\toolshed-2.4\decb.exe dump blank.dsk,MYFILE.DAT


  Addr     0 1  2 3  4 5  6 7  8 9  A B  C D  E F 0 2 4 6 8 A C E
--------  ---- ---- ---- ---- ---- ---- ---- ---- ----------------
00000000  4120 4255 4e43 4820 4f46 2044 4154 41   A BUNCH OF DATA
```

Run read.asm (shows contents of MYFILE to screen):
```
> gr.bat
```

