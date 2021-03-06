;;------------------------------------------------------------------------------
;; Action! 3.6 by OSS   https://atariwiki.org/wiki/Wiki.jsp?page=Action
;;------------------------------------------------------------------------------
;; ATARI MEMORY MAP     https://www.atariarchives.org/mapping/memorymap.php
;;------------------------------------------------------------------------------
;; Atari800             https://atari800.github.io
;; Graph2Font           http://g2f.atari8.info/instrukcja.html
;; Atari FontMaker      https://sourceforge.net/projects/atari-fontmaker
;; Sprite Editor XL     http://bocianu.atari.pl/blog/spriteXL
;; Exomizer             https://bitbucket.org/magli143/exomizer/wiki/Home
;;------------------------------------------------------------------------------
;; Sublime Text 3       https://www.sublimetext.com/3
;; Syntax highliting scheme for Action! ATARI language
;; https://github.com/michalkolodziejski/ST3-action-syntax-highlighting
;;------------------------------------------------------------------------------
;
;;------------------------------------------------------------------------------
;; CONSTANT-LIKE DEFINITIONS AMD CODE SNIPPETS
;;------------------------------------------------------------------------------
;
;DEFINE
;  CODEBASE="$E0A",MAINADDR="$9000",
;  DLADDR="$8C00",LMSADDR="$8C05",DLIAADDR="$8C50",DLIBADDR="$8CA0",
;  STARTSCREEN="$8000",CHARSET="$8800",
;  STARTROW="$38E",LOOP="$300"

STARTSCREEN 	= $8000
SCREEN 	= STARTSCREEN
STARTROW	= $390
LOOP		= $300

LOOPEND=STARTSCREEN+LOOP+4
TERRAINEND=STARTSCREEN+LOOP-$30
STARTPLAIN=STARTSCREEN+STARTROW+$120

STARTTERRAIN=STARTSCREEN+STARTROW ;+$150

;
;; ML OPCODES AND SNIPPETS
;DEFINE
;  SLC="$18",SEC="$38",RTI="$40",PHA="$48",RTS="$60",PLA="$68",ADCI="$69",JMPI="$6C",
;  STAZ="$85",STA="$8D",LDAI="$A9",LDAZ="$A5",LDA="$AD",
;  CMPI="$C9",DECZ="$C6",DEC="$CE",BNE="$D0",SBCI="$E9",INC="$EE",
;  PUSHAXYONSTACK="$48$8A$48$98$48",PULLAXYFROMSTACK="$68$A8$68$AA$68",
;  RASTERBARON="$A9$E$8D$0A$D4$8D$1A$D0",RASTERBAROFF="$A9$0$8D$1A$D0",
;  WSYNC="$8D$0A$D4"
;
;; MEMORY MAP
;DEFINE
;  COLOR0="$2C4",COLOR1="$2C5",COLOR2="$2C6",COLOR3="$2C7",COLOR4="$2C8",
;  SETVBV="$E45C"
;
;; HELPERS
;DEFINE

;  LSLOPE="27",LFILL="28",GLADE="29",RFILL="30",RSLOPE="31",

LSLOPE=27
LFILL =28
GLADE =29
RFILL =30
RSLOPE=31

;  TANK="1 2",SQID="1 4",NUKE="3 4",BFR="3 6",DOOM="5 6",
;  ROCKETBODY="SCREEN(SCREENI+ROWOFFSET(ROW+1))",
;  ROCKETHEAD="SCREEN(SCREENI+ROWOFFSET(ROW+2))",
;  DRAWROW="SCREEN(SCREENI+ROWOFFSET(ROW))",
;  DRAWNEXTROW="SCREEN(SCREENI+ROWOFFSET(NEXTROW))",
;  RET="[96]"
;
;;------------------------------------------------------------------------------
;; MODULE CODE START HERE
;;------------------------------------------------------------------------------
;
;MODULE
;
;;------------------------------------------------------------------------------
;; GLOBAL VARIABLES
;;------------------------------------------------------------------------------
;
;INCLUDE "H6:ASSETS.ACT"
;INCLUDE "H6:GLOBALS.ACT"
;
;;------------------------------------------------------------------------------
;; PROCEDURES AND FUNCTIONS
;;------------------------------------------------------------------------------
;
;INCLUDE "H6:TOOLS.ACT"
;INCLUDE "H6:WORLD.ACT"
;INCLUDE "H6:LOOP.ACT"
;INCLUDE "H6:ANTIC.ACT"
;INCLUDE "H6:VBLANKD.ACT"
;INCLUDE "H6:INIT.ACT"


    ICL "GLOBALS.ASM"

;    org $2000
    ICL "ASSETS.ASM"


TEXT	dta "                                                "

    org $3000

    ICL "ANTIC.ASM"
    ICL "TOOLS.ASM"
    ICL "WORLD.ASM"
    ICL "LOOP.ASM"
    ICL "VBLANKD.ASM"
    ICL "INIT.ASM"

;
;;------------------------------------------------------------------------------
;; LAUNCH PROCEDURE
;;------------------------------------------------------------------------------
;
;SET $E=MAINADDR
;PROC MAIN=*()
;  INIT()
;  DRAWLINE()
;  MAINLOOP()
;RET


main		equ *

    jsr INIT
    jsr DRAWLINE
    jsr MAINLOOP
    rts

    run main
