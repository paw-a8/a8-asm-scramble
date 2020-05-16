
ship1	dta	02,03,02,04,03
ship2	dta	12,11,11,13,13

terrain

    ldy #0
    ldx #9
t1
    jsr set_tmp
    tya
    sta(TMP),Y
    dex
    bpl t1


    lda RANDOM
    and #3
    sta TILE
    tay

    ldx NEXTROW
    stx ROW

    cpx #6
    bne nie6
	cpy #3
	bne nie_tile_3
	    lda #GLADE
	    jmp zapisz_tile

nie_tile_3
	lda #RFILL
	ldx #5
	stx NEXTROW
	jsr zapisz_tile
	lda #RSLOPE
	ldx #6
	jmp zapisz_tile
nie6


    cpx #0
    bne nie0

	cpy #1
	bcs nie_tile_m_2
	    lda #GLADE
	    ldx #0
	    jmp zapisz_tile

nie_tile_m_2
	lda #LFILL
	ldx #0
	jsr zapisz_tile
	lda #LSLOPE
	ldx #1
	stx NEXTROW
	jmp zapisz_tile

nie0



    cpy #2
    bcs tile_w_2

	lda #GLADE
	jsr zapisz_tile
	cpx #5
	bcc shi1
	rts

shi1
	lda RANDOM
	and #15
	sta TILE
	cmp #4
	bcc shi2
	rts

shi2
	tay
	inx
	lda ship1,Y
	jsr zapisz_tile
	inx
	ldy TILE
	lda ship2,Y
	jmp zapisz_tile

tile_w_2

    bne tilew3

	dec NEXTROW
	ldx NEXTROW
	lda #RFILL
	jsr zapisz_tile
	ldx ROW
	lda #RSLOPE
	jmp zapisz_tile


tilew3

	inc NEXTROW
	ldx ROW
	lda #LFILL
	jsr zapisz_tile
	ldx NEXTROW
	lda #LSLOPE
	jmp zapisz_tile

