_vbi

    lda #$e
    sta COLOR1
    sta dli_kolor1

    lda #$8c
    sta COLOR2
    sta dli_kolor2

	lda <DLIA
	sta DLI
	lda >DLIA
	sta DLI+1


    ldx TIMER
    beq potimer
	dec TIMER
potimer



EXITVBI

	pla
	tax
	pla
	tay
	pla
	rti

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
	lda #192    ;wlaczamy NMI (VBL+DLI)
	sta NMIEN
	rts



EXITDLI
	lda _zp_a
	ldx _zp_x
	ldy _zp_y
	rti

NMI


	bit $d40f ; sprawdzamy czy przerwanie to VBL czy DLI 
	bpl _no
	sta _zp_a
	stx _zp_x
	sty _zp_y
	jmp (DLI) 
_no	sta $d40f
	pha
	tya
	pha
	txa
	pha
	jmp (VBI)







