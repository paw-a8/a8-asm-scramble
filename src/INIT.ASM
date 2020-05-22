;;------------------------------------------------------------------------------
;; INITIALIZING THE PROGRAM VARIABLES
;;------------------------------------------------------------------------------
;
;PROC INIT=*()
;  CARD POINTER ADDR
;
;  WAIT(1)           ; FRAME SYNCHRONIZATION
;  SDMCTL=0          ; TURN ON ANTIC
;  NMIEN=0           ; TURN OFF NON MASKABLE INTERRUPT
;
;  RESETVARS()
;  TILE=0 HSCROLI=$F
;
;  SETBLOCK(TEXT,$30,0)
;  SETBLOCK(STARTSCREEN,$800,0)
;
;  POKE(COLOR1,$E)   ; WHITE CHAR / TERRAIN
;  POKE(COLOR2,$8C)  ; BACKGROUND / SKY
;  POKE(COLOR4,0)    ; BORDER
;  DLICOLOR=$8A
;
;  ADDR=CHARSET
;  CHBAS=PEEK(@ADDR+1)
;
;  SDLSTL=DLADDR
;  VDSLST=DLIAADDR
;
;  ADDR=VBLANKD
;  LSB=PEEK(@ADDR) MSB=PEEK(@ADDR+1)
;  OLDVBL=VVBLKD SETVBLK(7,MSB,LSB)
;
;  NMIEN=$C0         ; TURN ON NON MASKABLE INTERRUPT %110XXXXX
;  SDMCTL=$2E        ; TURN ON ANTIC %XX101110
;RET


INIT
;    lda #1
;    jsr wait

	lda #$0
	sta DMACTL

ROMOFF
	lda #0
	sta NMIEN   ; wylaczamy NMI 
	sei         ; oraz IRQ
	lda #$fe    ; oraz podlaczamy RAM pod ROMem,$0wylaczajac OS
	sta $d301
; poniewaz nie mamy juz systemu nalezy zadbac o wlasna obsluge przerwan NMI
	lda #<NMI
	sta $FFFA
	lda #>NMI
	sta $FFFB


	jsr RESETVARS
	lda #0
	sta TILE
	lda #$F
	sta HSCROLI

	lda <TEXT
	sta TMP
	lda >TEXT
	sta TMP+1
	lda #$0
	ldy #$30
	ldx #$0
	jsr SETBLOCK

	lda <STARTSCREEN
	sta TMP
	lda >STARTSCREEN
	sta TMP+1
	lda #$0
	ldy #$0
	ldx #$8
	jsr SETBLOCK


	lda #$E
	sta COLOR1
	lda #$8C
	sta COLOR2
	lda #$0
	sta COLOR4

	lda #$8A
	sta DLICOLOR

	lda >CHARSET
	sta CHBAS

	lda <DLADDR
	sta DLPTR
	lda >DLADDR
	sta DLPTR+1

	lda <DLIAADDR
	sta DLI
	lda >DLIAADDR
	sta DLI+1

	lda <VBLANKD
	sta VBI
	lda >VBLANKD
	sta VBI+1


	lda #$C0
	sta NMIEN

	lda #$2E
	sta DMACTL
	rts

