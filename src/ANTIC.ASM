DL
    dta    $70
    dta    $42,a(TEXT1)
    dta    $D2
LMS
    dta    a(SCREEN)

    dta    $12,$92,$12,$92,$12,$92,$12,$92,$12,$92,$12
    dta    $12,$12,$12,$12,$92,$92,$92,$92,$92,$92,$92,$02
    dta    $70
    dta    $41,a(DL)



DLIA
    lda dli_kolor2
    tax
    dex
    dex
    cpx #$80
    bne DLIA1
    ldx #0
DLIA1
    stx WSYNC
    stx COLOR2
    sta WSYNC
    sta COLOR2
    stx WSYNC
    stx COLOR2
    stx dli_kolor2
    cpx #$0
    bne DLIA2

    lda <DLIB
    sta DLI
    lda >DLIB
    sta DLI+1
DLIA2
    jmp EXITDLI


DLIB
    ldx dli_kolor1
    stx WSYNC
    stx COLOR1
    dex
    dex
    stx dli_kolor1
    jmp EXITDLI
