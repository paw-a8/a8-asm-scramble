mainloop

	lda HSCROLI
	cmp #$ff
	bne dalej

	    jsr terrain

	    lda LMS+1
	    cmp #(>SCREEN+$02)
	    bne dalej0

		ldy #0
		sty NEXTROW

		lda #>SCREEN
		sta LMS+1
		lda #<SCREEN
		sta LMS

		sta SCREENI
		lda #>SCREEN
		clc
		adc #$03
		sta SCREENI+1

		ldx #1
		jsr set_tmp
		ldy #0
		lda #GLADE
for_io2
		sta (TMP),Y
		iny
		cpy #$2F+1
		bcc for_io2


dalej0
	    clc
	    lda LMS
	    adc #1
	    sta LMS
	    sta SCREENI
	    lda LMS+1
	    adc #0
	    sta LMS+1
	    adc #$3
	    sta SCREENI+1

	    lda #3
	    sta HSCROLI

	    jmp mainloop
dalej

	lda HSCROLI
	dec HSCROLI
	sta HSCROL

    jsr wait

    jmp mainloop
