*
* read disk file test example - craig allsop 2026
*        
                org     $4000
start:

* open file for read
                ldx     #FILENAME
                ldy     #$0100
                lda     #'I'
                ldb     #FILE_NO
                jsr     DOPEN
                bne     error

* read a bunch of data
                ldx     #$400
loop:                
                ldb     #FILE_NO
                jsr     DGET
                bne     error
                sta     ,x+

* test eof
                ldb     #FILE_NO
                jsr     DEOF
                beq     loop

* close file
                ldb     #FILE_NO
                jsr     CLOSE

                rts
error:
                stb     $400
                rts

FILENAME        fcc     "MYFILE.DAT:0"
                fcb     0

                
FILE_NO         equ     1
DOS             equ     1
                include DISKIO.ASM

                end     start