INIT
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
	sta COARSEI

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

;	lda #0
	sta DLICOLOR

	lda >CHARSET1
	sta CHBAS
	sta CHTMP

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

