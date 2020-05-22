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
ml1
    jsr RASTERBAROFF
    jmp MAINLOOP
