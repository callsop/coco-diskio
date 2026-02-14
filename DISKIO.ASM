*************************
* M/L DISK I/O ROUTINES *
*************************
ZFCBV1  EQU     $928
ZFCBDFL EQU     23
SPEED   FCB     $00
ZSAVE   FCB     $00
        FCB     $00
        FCB     $00
        FCB     $00
        FCB     $00
        FCB     $00
ZSTACK  FCB     $00
        FCB     $00
FILES   LBSR    ZBEGIN
        PSHS    B
        JSR     [JMP1]
        PULS    B
        STB     $95B
        LDU     #$928
        LDX     #$989
DIO001  CLR     ,X
        STX     ,U++
        LEAX    $119,X
        DECB
        BHI     DIO001
        LBRA    ZDONE
DOPEN   LBSR    ZBEGIN
        STY     $957
        PSHS    D
        LBSR    FNAME
        PULS    D
        JSR     [JMP2]
        LBRA    ZDONE
CLOSE   LBSR    ZBEGIN
        STB     $6F
        JSR     [JMP3]
        LBRA    ZDONE
DPUT    LBSR    ZBEGIN
        STB     $6F
        JSR     $A282
        LBRA    ZDONE
DGET    LBSR    ZBEGIN
        STB     $6F
        JSR     $A176
        STA     ,S
        LBRA    ZDONE
DKILL   LBSR    ZBEGIN
        LBSR    FNAME
        JSR     [JMP4]
        LBRA    ZDONE
VERIFY  LBSR    ZBEGIN
        STB     $987
        LBSR    ZDONE
DEOF    PSHS    X
        LDX     #ZFCBV1-2
        ASLB
        LDX     B,X
        LDB     ZFCBDFL,X
        PULS    X,PC
*************************
* INTERNAL SUB-PROGRAMS *
*************************
FNAME   LDB     #$FF
DIO002  INCB
        LDA     B,X
        CMPA    #$20
        BCC     DIO002
        CLR     ,-S
        LDA     $95A
        STA     $EB
        LDU     #$94C
        LDA     #$20
DIO003  STA     ,U+
        CMPU    #$957
        BNE     DIO003
        JMP     [JMP5]
ZBEGIN  PSHS    X,Y,U,DP,A
        CLR     65494
        CLR     65496
        CLRA
        TFR     A,DP
        LDA     $18E
        LDU     $18F
        STA     ZSAVE,PCR
        STU     ZSAVE+1,PCR
        LDA     $191
        LDU     $192
        STA     ZSAVE+3,PCR
        STU     ZSAVE+4,PCR
        LDA     #$7E
        LEAU    ZERROR,PCR
        STA     $18E
        STU     $18F
        STA     $191
        STU     $192
        LDA     ,S
        STS     ZSTACK,PCR
        JMP     [8,S]
ZERROR  LSRB
        INCB
        BRA     ZEXIT
ZDONE   CLRB
        BRA     ZEXIT
ZEXIT   LDA     ZSAVE,PCR
        LDU     ZSAVE+1,PCR
        STA     $18E
        STU     $18F
        LDA     ZSAVE+3,PCR
        LDU     ZSAVE+4,PCR
        STA     $191
        STU     $192
        LDA     SPEED
        LSLA
        LDU     #65495
        CLR     A,U
        LDS     ZSTACK,PCR
        PULS    A,DP,U,Y,X
        LEAS    2,S
        TSTB
        RTS
***   DSK 1.0 JUMPS   ***
        IFNE    DOS-1
JMP1    FDB     $CA3B
JMP2    FDB     $C468
JMP3    FDB     $CA53
JMP4    FDB     $C6C5
JMP5    FDB     $C8A4
        ENDC
***   DSK 1.1 JUMPS   ***
        IFNE    DOS
JMP1    FDB     $CAE9
JMP2    FDB     $C48D
JMP3    FDB     $CB01
JMP4    FDB     $C6F2
JMP5    FDB     $C952
        ENDC
*************************
*
******************************************
*INSTRUCTIONS   -->>
*
*CMND   ENTRY REGS.             EXIT REGS.
*
*FILES  B=NUMBER OF BUFFERS     NONE.
*
*DOPEN  X=ADD. OF FILENAME      (FILE OPEN)
*       Y=FILETYPE MSB=0-BASIC
*                      1-DATA
*                      2-M/L
*                      3-TEXT
*                  LSB=0-BINARY
*                     $FF-ASCII
*       A=FILEMODE "O"-OUTPUT
*                  "I"-INPUT
*       B=DEVICE NUMBER
*
*       (FILENAME IN THE FORMAT
*        "FILENAME.EXT:D",$00)
*
*CLOSE  B=DEVICE NUMBER
*
*DPUT   A=CHARACTER
*       B=DEVICE NUMBER
*
*DGET   B=DEVICE NUMBER         A=CHARACTER
*
*DEOF   B=DEVICE NUMBER         B:0=MORE,$FF=EOF
*
*DKILL  X=ADD OF FILENAME
*
*VERIFY B=1-ON
*         0-OFF
*
*********************************************
