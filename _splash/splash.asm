; ===========================================================================

SplashScreens:
		lea	(SplGameTap_VDP).l,a0			; load VDP register data
		lea	(SplGameTap_VRAM).l,a1			; load VRAM palette data
		lea	(SplGameTap_CRAM).l,a2			; load CRAM palette data
		moveq	#$FFFFFF84,d7
		bsr.s	@DoSplash
		lea	(SplClown_VDP).l,a0			; load VDP register data
		lea	(SplClown_VRAM).l,a1			; load VRAM palette data
		lea	(SplClown_CRAM).l,a2			; load CRAM palette data
		moveq	#0,d7
		bsr.s	@DoSplash
		lea	(SplPresents_VDP).l,a0			; load VDP register data
		lea	(SplPresents_VRAM).l,a1			; load VRAM palette data
		lea	(SplPresents_CRAM).l,a2			; load CRAM palette data
		moveq	#$FFFFFF86,d7
		bsr.s	@DoSplash
		move.b	#4,$FFFFF600.w
		rts

@DoSplash:
		movem.l	d7/a0-a2,-(sp)
		sfx	bgm_Stop,0,0,1 ; stop music
		jsr	ClearPLC
		jsr	PaletteFadeOut
		jsr	ClearScreen
		movem.l	(sp)+,a0-a2/d7

		lea	$C00004,a6
		lea	-4(a6),a5

		move	#$2700,sr
		move.w	#$8000,d2				; prepare starting register
		moveq	#$12-1,d3				; set to write 12 registers (80 - 92)

BMD_WriteVDP:
		move.b	(a0)+,d2				; load VDP register data
		move.w	d2,(a6)					; save register value to VDP
		add.w	d1,d2					; advance to next register
		dbf	d3,BMD_WriteVDP				; repeat for 12 registers

	; --- Loading VRAM data into VRAM ---

		move.l	#$40000000,(a6)				; set VDP to VRAM write mode
		move.w	#(($10000/$04)/$04)-1,d3		; size of VRAM data to copy

BMD_WriteVRAM:
		move.l	(a1)+,(a5)				; copy data into VRAM
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		move.l	(a1)+,(a5)				; ''
		dbf	d3,BMD_WriteVRAM			; repeat until all data has been copied

	; --- Loading palette data into CRAM ---

		lea	$FFFFFB80.w,a1
		moveq	#(($80/$04)/$04)-1,d3			; size of palette to copy

BMD_WriteCRAM:
		move.l	(a2)+,(a1)+				; copy colours into CRAM
		move.l	(a2)+,(a1)+				; ''
		move.l	(a2)+,(a1)+				; ''
		move.l	(a2)+,(a1)+				; ''
		dbf	d3,BMD_WriteCRAM			; repeat until all colours have been copied
		move.w	#$8174,(a6)
		jsr	PaletteFadeIn

		move.b	d7,d0
		jsr	PlaySample

		move.w	#60*3,d7

	; --- Finish (loop endlessly) ---

BMD_Loop:
		move.b	#2,(v_vbla_routine).w
		jsr	WaitForVBla
		subq.w	#1,d7
		bpl.s	BMD_Loop
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Including Bitmap MD data
; ---------------------------------------------------------------------------
SplGameTap_VDP:	incbin	"_splash/gametap/VDP.bin"
		even
SplGameTap_CRAM:incbin	"_splash/gametap/CRAM.bin"
		even
SplGameTap_VRAM:incbin	"_splash/gametap/VRAM.bin"
		even
SplClown_VDP:	incbin	"_splash/clown/VDP.bin"
		even
SplClown_CRAM:	incbin	"_splash/clown/CRAM.bin"
		even
SplClown_VRAM:	incbin	"_splash/clown/VRAM.bin"
		even
SplPresents_VDP:incbin	"_splash/presents/VDP.bin"
		even
SplPresents_CRAM:incbin	"_splash/presents/CRAM.bin"
		even
SplPresents_VRAM:incbin	"_splash/presents/VRAM.bin"
		even
; ===========================================================================