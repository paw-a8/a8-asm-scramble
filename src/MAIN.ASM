

    ICL 'GLOBALS.ASM'


    org $2000

font
    INS 'SCRAMBLE.FNT'

TEXT1	dta "                                        "
TEXT2	dta "score                         fuel      "


    ICL 'ANTIC.ASM'
    ICL 'VBI.ASM'
    ICL 'LOOP.ASM'
    ICL 'TERRAIN.ASM'
    ICL 'TOOLS.ASM'


ROWOFFSET_h dta $01,$01,$00,$00,$00,$00,$00,$00,$01
ROWOFFSET_l dta $50,$20,$F0,$C0,$90,$60,$30,$00,$80




main		equ *



    jsr init
    jsr mainloop

    rts


init


    ldx >SCREEN
    stx sb2+2

    lda #$0
    ldy #0
sb2
    sta SCREEN,Y
    iny
    bne sb2
    inx
    stx sb2+2
    cpx #(>SCREEN+$20)
    bcc sb2



    lda <_vbi
    sta VBI
    lda >_vbi
    sta VBI+1



    lda >font
    sta CHBAS


    lda >SCREEN
    sta LMS+1
    lda <SCREEN
    sta LMS
    sta SCREENI

    lda >SCREEN
    clc
    adc #$03
    sta SCREENI+1


    ldx #0
    stx NEXTROW
    stx ROW

    ldx #1
    jsr set_tmp


    ldy #00
    lda #GLADE
for_io
    sta (TMP),Y
    iny
    cpy #$2F+1
    bcc for_io



    lda #$e
    sta COLOR1

    lda #0
    sta COLOR2

    lda #2
    sta COLOR4



	lda <DL
	sta DLPTR
	lda >DL
	sta DLPTR+1

	lda <DLIA
	sta DLI
	lda >DLIA
	sta DLI+1

	jsr ROMOFF

	lda #$22
	sta DMACTL

	lda #3
	sta HSCROLI
	sta HSCROL










set_tmp			;(x-row)
    lda SCREENI
set_tmp_a
    clc
    adc ROWOFFSET_l,X
    sta TMP
    lda SCREENI+1
    adc ROWOFFSET_h,X
    sta TMP+1
    rts


zapisz_tile		;(a-tile, x-row)
	tay
	jsr set_tmp
	tya
	ldy #0
	sta (TMP),Y
	rts



    run main
