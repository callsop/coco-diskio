*
* write disk file test example - craig allsop 2026
*        
                org     $4000
start:

* open file for write
                ldx     #FILENAME
                ldy     #$0100
                lda     #'O'
                ldb     #FILE_NO
                jsr     DOPEN
                bne     error

* write a bunch of data
                lda     #DATA_LEN
                pshs    a
                ldx     #DATA
loop:                
                ldb     #FILE_NO
                lda     ,x+
                jsr     DPUT
                bne     error
                dec     ,s
                bne     loop
                puls    a

* close file
                ldb     #FILE_NO
                jsr     CLOSE
                rts
error:
                stb     $400
                rts

FILENAME        fcc     "MYFILE.DAT:0"
                fcb     0

DATA            fcc     "A BUNCH OF DATA"
DATA_LEN        equ     *-DATA
FILE_NO         equ     1
DOS             equ     1
                include DISKIO.ASM

                end     start