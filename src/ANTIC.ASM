DLADDR
DL
    dta    $70
    dta    $42,a(TEXT)
    dta    $D2
LMS
    dta    a(SCREEN)
    dta    $12,$92,$12,$92,$12,$92,$12,$92,$12,$92,$12,$12,$12
    dta    $12,$12,$12,$12,$12,$92,$92,$92,$92,$92,$92,$92
    dta    $41,a(DL)




DLI_COLORS dta $8C,$8A,$88,$86,$84,$82,$0,$C,$A,$8,$6,$4,$2



DLIAADDR
DLIA
    ldy DLICOLOR
    lda DLI_COLORS+1,Y

    cpy #6
    bcs DLIB

	tax
	lda DLI_COLORS,Y

	sta WSYNC
	sta COLOR2


	sta WSYNC
	sta COLOR2

	sta WSYNC
	stx COLOR2

	cpy #5
	bne DLIC
	stx COLOR2
	lda #$E

DLIB
    sta COLOR1
DLIC
    inc DLICOLOR
    jmp EXITDLI


