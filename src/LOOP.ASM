;;------------------------------------------------------------------------------
;; MAIN LOOP
;;------------------------------------------------------------------------------
;
;PROC MAINLOOP=*()
;  DO
;    RSYNC(8)
;    [RASTERBARON]
;    IF HSCROLI=$B THEN TERRAIN() FI
;    [RASTERBAROFF]
;  OD
;RET


MAINLOOP

    lda #8
    jsr RSYNC

	sta WSYNC
	lda #$8C
	sta COLOR2

    jsr RASTERBARON
    lda HSCROLI
    cmp #$B
    bne ml1
	jsr TERRAIN

;      COARSEI==+1
;      IF COARSEI=8 THEN CHBAS==+4
;      ELSEIF COARSEI=9 THEN CHBAS==+4
;      ELSEIF COARSEI=10 THEN CHBAS==+4
;      ELSEIF COARSEI=18 THEN CHBAS==-4
;      ELSEIF COARSEI=19 THEN CHBAS==-4
;      ELSEIF COARSEI=20 THEN CHBAS==-4
;      COARSEI=0 FI

	ldx CHTMP
	inc COARSEI
	lda COARSEI
	cmp #8
	beq chplus4
	cmp #9
	beq chplus4
	cmp #10
	beq chplus4
	cmp #18
	beq chminus4
	cmp #19
	beq chminus4
	lda #0
	sta COARSEI
chminus4
	dex
	dex
	dex
	dex
	bne chend
chplus4
	inx
	inx
	inx
	inx
chend
;	stx CHBAS
;	stx CHTMP
;	stx TEXT
ml1
    jsr RASTERBAROFF
    jmp MAINLOOP
