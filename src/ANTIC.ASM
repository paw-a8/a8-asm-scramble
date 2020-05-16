DL
    dta    $70
    dta    $42,a(TEXT1)
    dta    $D2
LMS
    dta    a(SCREEN)
    dta    $92,$92,$92,$92,$92,$12,$12,$12,$12,$12,$12
    dta    $12,$12,$12,$12,$92,$92,$92,$92,$92,$92,$92,$02
    dta    $70,$70
    dta    $42,a(TEXT2)
    dta    $41,a(DL)



dli_colors dta $8a,$88,$86,$84,$82,$00,$0c,$0a,$08,$06,$04,$02,$0e


DLIA
	ldy dli_color
	inc dli_color
	lda dli_colors,Y

	ldx #0

	cpy #6
	bcs DLIB

	inx

DLIB
	sta WSYNC
	sta COLOR1,X
	jmp EXITDLI

