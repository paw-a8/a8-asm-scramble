;;------------------------------------------------------------------------------
;; VBLANK PROCEDURE CALLED ONCE PER FRAME
;;------------------------------------------------------------------------------
;
;PROC VBLANKD=*()
;  [PUSHAXYONSTACK]
;  IF HSCROLI=$B THEN
;    IF LMS=STARTSCREEN+LOOP+4 THEN
;      DRAWLINE() RESETVARS()
;    ELSE
;      LMS==+1 SCREENI==+1
;    FI
;    HSCROLI=$F
;  FI
;  HSCROL=HSCROLI HSCROLI==-1
;  [PULLAXYFROMSTACK]
;[JMPI OLDVBL]





VBLANKD

    lda #0
    sta DLICOLOR
    lda $E
    sta COLOR1

    inc RTCLOK

	lda HSCROLI
	cmp #$B
	bne vb1
	    lda LMS+1
	    cmp #>(STARTSCREEN+LOOP+4)
	    bne vb2
	    lda LMS
	    cmp #<(STARTSCREEN+LOOP+4)
	    bne vb2
		jsr DRAWLINE
		jsr RESETVARS
vb2
		clc
		lda LMS
		adc #1
		sta LMS
		lda LMS+1
		adc #0
		sta LMS+1

		clc
		lda SCREENI
		adc #1
		sta SCREENI
		lda SCREENI+1
		adc #0
		sta SCREENI+1

		clc
		lda SCREENI
		sta TMP
		lda SCREENI+1
		adc #1
		sta TMP+1


	    lda #$F
	    sta HSCROLI
vb1
	lda HSCROLI
	sta HSCROL
	dec HSCROLI


EXITVBI

	pla
	tax
	pla
	tay
	pla
	rti




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







