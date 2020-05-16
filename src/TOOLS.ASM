
wait
	lda #1
	sta TIMER
czekaj
	lda TIMER
	bne czekaj
	rts
