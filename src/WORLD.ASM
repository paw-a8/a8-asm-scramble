;;------------------------------------------------------------------------------
;; WORLD GENERATION PROCEDURE
;;------------------------------------------------------------------------------
;
;;------------------------------------------------------------------------------
;; PROCEDURE DRAWS ROCKETS
;;------------------------------------------------------------------------------
;PROC DRAWROCKET=*()
;  SHIPTYPE=RANDOM & 30
;  IF SHIPTYPE>8 THEN RET FI
;  ROCKETBODY=SHIPSTABLE(SHIPTYPE)
;  ROCKETHEAD=SHIPSTABLE(SHIPTYPE+1)
;RET
;

SHIPSTABLE_BODY	dta 1,1,3,3,5
SHIPSTABLE_HEAD	dta 2,4,4,6,6


DRAWROCKET
    lda RANDOM
    and #30
    cmp #5
    bcs dr1
	sta SHIPTYPE
	tay
ROCKETBODY
	lda SHIPSTABLE_BODY,Y
	ldx ROW
	inx
	jsr zapisz_tile
ROCKETHEAD
	ldy SHIPTYPE
	lda SHIPSTABLE_HEAD,Y
	ldx ROW
	inx
	inx
	jmp zapisz_tile
dr1
    rts

;;------------------------------------------------------------------------------
;; PROCEDURE DRAWS ION CANNON STRUCTURE
;;------------------------------------------------------------------------------
;PROC DRAWCANNON=*()
;  CTMP0=SCREENI+ROWOFFSET(ROW+1)
;  CTMP1=SCREENI+ROWOFFSET(ROW+2)
;
;  SCREEN(CTMP0-2)=27
;  SCREEN(CTMP1-2)=0
;  SCREEN(CTMP0-1)=28
;  SCREEN(CTMP1-1)=0
;  SCREEN(CTMP0)=29
;  SCREEN(CTMP1)=30
;RET
;

DRAWCANNONTABLE	
    dta $ff-$30-$02,27
    dta $ff-$60-$02,0
    dta $ff-$30-$01,28
    dta $ff-$60-$01,0
    dta $ff-$30,29
    dta $ff-$60,30

DRAWCANNON

	ldx ROW
	jsr set_tmp
	dec TMP+1

	ldx #0
drc1
	lda DRAWCANNONTABLE,X
	tay
	inx
	lda DRAWCANNONTABLE,X
	sta (TMP),Y
	inx
	cpx #12
	bne drc1
	rts


;;------------------------------------------------------------------------------
;; TERRAIN GENERATION PROCEDURE
;;------------------------------------------------------------------------------

;PROC TERRAIN=*()


ship1	dta	02,03,02,04,03
ship2	dta	12,11,11,13,13

ROWOFFSET_h dta $01,$01,$00,$00,$00,$00,$00,$00,$01
ROWOFFSET_l dta $50,$20,$F0,$C0,$90,$60,$30,$00,$80


TERRAIN

;  SCREEN(SCREENI+$150)=0
;  SCREEN(SCREENI+$120)=0
;  SCREEN(SCREENI+$F0)=0
;  SCREEN(SCREENI+$C0)=0
;  SCREEN(SCREENI+$90)=0
;  SCREEN(SCREENI+$60)=0
;  SCREEN(SCREENI+$30)=0
;  SCREEN(SCREENI)=0


    ldy #0
    ldx #8
t1
    jsr set_tmp
    tya
    sta(TMP),Y
    dex
    bpl t1


;
;  ROW=NEXTROW
;

    ldx NEXTROW
    stx ROW



;  IF LMS>STARTSCREEN+LOOP-$30 THEN
;    IF ROW>0 THEN
;      NEXTROW==-1
;      DRAWROW=RSLOPE DRAWNEXTROW=RFILL
;      RET
;    ELSE
;      DRAWROW=GLADE RET
;    FI
;  FI
;


    lda LMS+1
    cmp #>(STARTSCREEN+LOOP-$30)
    bcc wo1
	lda LMS
	cmp #<(STARTSCREEN+LOOP-$30)
	bcc wo1
	    ldx ROW
	    beq r0
		dec NEXTROW
		lda #RSLOPE
		jsr DRAWROW
		lda #RFILL
		jmp DRAWNEXTROW
r0
	    lda #GLADE
	    jmp DRAWROW
wo1


;  TILE=RANDOM & 3

    lda RANDOM
    and #3
    sta TILE
    tay



;
;  IF ROW=6 THEN
;    IF TILE=3 THEN
;      DRAWROW=GLADE RET
;    ELSE
;      NEXTROW=5
;      DRAWROW=RSLOPE DRAWNEXTROW=RFILL
;      RET
;    FI
;  FI
;RET
;

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


;  IF ROW=0 THEN
;    IF TILE<2 THEN
;      DRAWROW=GLADE RET
;    ELSE
;      NEXTROW=1
;      DRAWROW=LFILL DRAWNEXTROW=LSLOPE
;      RET
;    FI
;  FI

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




;  IF (ROW>0) AND (ROW<6) THEN
;    IF TILE<2 THEN
;      DRAWROW=GLADE
;      IF ROW<5 THEN
;        ISCANONN==+1
;        IF ISCANONN>2 THEN
;          IF (RANDOM&3)=0 THEN
;            DRAWCANNON() ISCANONN=0 RET
;          FI
;        FI
;        DRAWROCKET() RET
;      FI
;    ELSEIF TILE=2 THEN
;      ISCANONN=0 NEXTROW==-1
;      DRAWROW=RSLOPE DRAWNEXTROW=RFILL
;      RET
;    ELSEIF TILE=3 THEN
;      ISCANONN=0 NEXTROW==+1
;      DRAWROW=LFILL DRAWNEXTROW=LSLOPE
;      RET
;    FI
;  FI
;

;row 1-5
    cpy #2
    bcs tile_w_2
	lda #GLADE
	jsr DRAWROW
	cpx #5
	bcs r_w_5
	    inc ISCANNON
	    lda ISCANNON
	    cmp #3
	    bcc ic_m_2
		lda RANDOM
		and #3
		bne ic_m_2
		    jsr DRAWCANNON
		    lda #0
		    sta ISCANNON
		    rts
ic_m_2
	    jmp DRAWROCKET
r_w_5
tile_w_2
    cpy #2
    bne tile_n_2
	lda #0
	sta ISCANNON
	dec NEXTROW
	lda #RSLOPE
	jsr DRAWROW
	lda #RFILL
	jmp DRAWNEXTROW
tile_n_2

    cpy #3
    bne tile_n_3
	lda #0
	sta ISCANNON
	inc NEXTROW
	lda #LFILL
	jsr DRAWROW
	lda #LSLOPE
	jmp DRAWNEXTROW

tile_n_3
    rts














;;------------------------------------------------------------------------------
;; PROCEDURE DRAWS LOOP LINE
;;------------------------------------------------------------------------------
;PROC DRAWLINE=*()
;  SETBLOCK(STARTSCREEN+STARTROW+$120,$30,GLADE)
;RET

DRAWLINE
	lda #<(STARTSCREEN+STARTROW+$120)
	sta TMP
	lda #>(STARTSCREEN+STARTROW+$120)
	sta TMP+1
	ldy #$30
	ldx #$0
	lda #GLADE
	jsr SETBLOCK
    rts
