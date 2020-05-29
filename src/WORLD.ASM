ROWOFF dta $50,$20,$F0,$C0,$90,$60,$30,$00


DRAWNEXTROW
	ldx NEXTROW

DRAWROW
	pha
	lda ROWOFF,X
	tay
	pla
	cpx #2
	bcc jeden
	sta (SCREENI),Y
	rts

jeden
	sta (TMP),Y
	rts



;;------------------------------------------------------------------------------
;; WORLD GENERATION PROCEDURE
;;------------------------------------------------------------------------------
;
;;------------------------------------------------------------------------------
;; PROCEDURE DRAWS ROCKETS
;;------------------------------------------------------------------------------


;PROC DRAWROCKET=*()
;  SHIPTYPE=(RANDOM%1) & 31
;  IF SHIPTYPE>7 THEN RET FI
;  POKEADDR=SCREENI-$30 ELMPOKE(SHIPTYPE) SHIPTYPE==+1
;  POKEADDR=SCREENI-$60 ELMPOKE(SHIPTYPE)
;RET
;


DRAWROCKET

    lda RANDOM
    ora #1
    and #7
	tay
	iny
	sty SHIPTYPE
ROCKETBODY
	ldx ROW
	inx
	jsr DRAWROW
ROCKETHEAD
	lda SHIPTYPE
	ldx ROW
	inx
	inx
	jmp DRAWROW
dr1
    rts




;;------------------------------------------------------------------------------
;; PROCEDURE DRAWS ION CANNON STRUCTURE
;;------------------------------------------------------------------------------
;PROC DRAWCANNON=*()
;  POKEADDR=SCREENI-$32 ELMPOKEC($0A09)
;  POKEADDR=SCREENI-$62 ELMPOKEC(0)
;  POKEADDR=SCREENI-$30 ELMPOKE(11)
;  POKEADDR=SCREENI-$60 ELMPOKE(12)
;RET
;


DRAWCANNON

	lda TMP
	cmp #2
	bcc dc1

	inx
	lda #11
	jsr DRAWROW

	dec TMP
	dec SCREENI

	lda #10
	jsr DRAWROW

	dec TMP
	dec SCREENI
	lda #09
	jsr DRAWROW

	inx

	lda #0
	jsr DRAWROW

	inc TMP
	inc SCREENI

	lda #0
	jsr DRAWROW

	inc TMP
	inc SCREENI

	lda #12
	jsr DRAWROW

dc1
	rts


;;------------------------------------------------------------------------------
;; TERRAIN GENERATION PROCEDURE
;;------------------------------------------------------------------------------

;PROC TERRAIN=*()



TERRAIN

;  SCREEN(SCREENI+$150)=0
;  SCREEN(SCREENI+$120)=0
;  SCREEN(SCREENI+$F0)=0
;  SCREEN(SCREENI+$C0)=0
;  SCREEN(SCREENI+$90)=0
;  SCREEN(SCREENI+$60)=0
;  SCREEN(SCREENI+$30)=0
;  SCREEN(SCREENI)=0



    ldx #6
t1
    lda ROWOFF+1,X
    tay
    lda #0
    sta (SCREENI),Y
    dex
    bne t1
    lda #0
    ldy #$20
    sta (TMP),Y
    ldy #$50
    sta (TMP),Y




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
    cmp #>(TERRAINEND)
    bcc wo1
	lda LMS
	cmp #<(TERRAINEND)
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
	    jmp DRAWROW

nie_tile_3
	lda #RFILL
;	ldx #5
	dex
	stx NEXTROW
	jsr DRAWROW
	lda #RSLOPE
	ldx #6
	jmp DRAWROW
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
;	    ldx #0
	    jmp DRAWROW

nie_tile_m_2
	lda #LFILL
;	ldx #0
	jsr DRAWROW
	lda #LSLOPE
	ldx #1
	stx NEXTROW
	jmp DRAWROW

nie0





;  IF TILE=2 THEN
;    ISCANONN=0 ROW==-1
;    TERPOKE(RSLOPE) SCREENI==+$30 TERPOKE(RFILL)
;    RET
;  ELSEIF TILE=3 THEN
;    ISCANONN=0 ROW==+1
;    TERPOKE(LFILL) SCREENI==-$30 TERPOKE(LSLOPE)
;    RET
;  FI

;  TERPOKE(GLADE)

 ; IF ROW<5 THEN
    ; SETS UP BUILDINGS AND VEHICLES
;    ISCANONN==+1
;    IF ISCANONN>2 THEN
;      IF (RANDOM&3)=0 THEN
;        DRAWCANNON() ISCANONN=0
;        RET
;      FI
;    FI
;    DRAWROCKET()
 ; FI



    cpy #2
    bne  tile_n_2
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

    lda #GLADE
    jsr DRAWROW

    cpx #5
    bcs row_w_5
	inc ISCANNON
	lda ISCANNON
	cmp #3
	bcc ic_m_2
	    lda RANDOM
	    and #3
	    bne ic_m_2
	        lda #0
	        sta ISCANNON
	        jmp DRAWCANNON
ic_m_2
	jmp DRAWROCKET

row_w_5

    rts














;;------------------------------------------------------------------------------
;; PROCEDURE DRAWS LOOP LINE
;;------------------------------------------------------------------------------
;PROC DRAWLINE=*()
;  SETBLOCK(STARTSCREEN+STARTROW+$120,$30,GLADE)
;RET

DRAWLINE
	lda #<(STARTPLAIN)
	sta TMP
	lda #>(STARTPLAIN)
	sta TMP+1
	ldy #$30
	ldx #$0
	lda #GLADE
	jsr SETBLOCK
    rts
