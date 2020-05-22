;;------------------------------------------------------------------------------
;; GLOBAL VARIABLES
;;------------------------------------------------------------------------------
;
;SET $E=CODEBASE
;
;BYTE ARRAY
;  SCREEN=STARTSCREEN,
;  TEXT(48),
;  SHIPSTABLE=[TANK NUKE SQID BFR DOOM]
;
;; THIS ARRAY REPRESENTING THE ENTIRE MEMORY
;BYTE ARRAY MATRIX=0
;
;; ROWOFFSET=ROW+4
;CARD ARRAY ROWOFFSET=[$150 $120 $F0 $C0 $90 $60 $30]
;
;; MEMORY MAP
;BYTE
;  RTCLOK=$14,SDMCTL=$22F,CHBAS=$2F4,CH=$2FC,
;  COLPF0=$D016,COLPF1=$D017,COLPF2=$D018,COLPF3=$D019,COLBK=$D01A,
;  RANDOM=$D20A,HSCROL=$D404,VCOUNT=$D40B,NMIEN=$D40E
;
;; CUSTOM
;BYTE
;  HSCROLI=$55,    ; REUSED COLCRS LSB
;  DLICOLOR=$56,   ; REUSED COLCRS MSB
;  NEXTROW=$5B,    ; REUSED OLDCOL LSB
;  TILE=$5C,       ; REUSED OLDCOL MSB
;  ROW=$5D,        ; REUSED OLDCHR
;  SHIPTYPE=$60,   ; REUSED NEWROW
;  ISCANONN=$80,
;  BI0=$CA,BI1=$CB
;
;; MEMORY MAP
;CARD
;  VDSLST=$200,
;  SDLSTL=$230,
;  VVBLKD=$224
;
;; CUSTOM
;CARD
;  OLDVBL,LSB,MSB,
;  LMS=LMSADDR,
;  SCREENI=$5E,    ; REUSED OLDADR
;  CTMP0=$61,      ; REUSED NEWCOL
;  CTMP1=$CC






COLOR0  equ $D016
COLOR1  equ $D017
COLOR2  equ $D018
COLOR3  equ $D019
COLOR4  equ $D01A

KBCODE  equ $D209

RANDOM  equ $D20A

DMACTL  equ $D400
DLPTR   equ $D402 
HSCROL	equ $D404
CHBAS   equ $D409
WSYNC   equ $D40A
VCOUNT	equ $D40b
NMIEN   equ $D40E


.zpvar = $080

.zpvar DLI 			.word
.zpvar VBI 			.word
.zpvar _zp_a,_zp_x,_zp_y 	.byte

.zpvar SCREENI	.word
.zpvar TMP	.word
.zpvar RTCLOK	.byte
.zpvar HSCROLI	.byte

.zpvar TILE .byte
.zpvar ROW .byte
.zpvar NEXTROW .byte

.zpvar SHIPTYPE .byte
.zpvar ISCANNON .byte

.zpvar DLICOLOR .byte


