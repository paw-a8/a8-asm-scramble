
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


