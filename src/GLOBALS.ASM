;
; DEFINE
;

RFILL  = 14
LFILL  = 15
LSLOPE = 70
RSLOPE = 71
GLADE  = 77


SCREEN   equ $6000
LOOP     equ $0200
STARTROW equ SCREEN+$300



COLOR0  equ $D016
COLOR1  equ $D017
COLOR2  equ $D018
COLOR3  equ $D019
COLOR4  equ $D01A

KBCODE  equ $D01F

RANDOM  equ $D20A

DMACTL  equ $D400
DLPTR   equ $D402 
HSCROL	equ $D404
CHBAS   equ $D409
WSYNC   equ $D40A
NMIEN   equ $D40E




;
; ZEROPAGE
;

.zpvar = $080

.zpvar DLI 			.word
.zpvar VBI 			.word
.zpvar _zp_a,_zp_x,_zp_y 	.byte

.zpvar SCREENI	.word
.zpvar TMP	.word
.zpvar TIMER	.byte
.zpvar HSCROLI	.byte

.zpvar TILE .byte
.zpvar ROW .byte
.zpvar NEXTROW .byte

.zpvar dli_kolor1 .byte
.zpvar dli_kolor2 .byte


