; ---------------------------------------------------------------------------
; Sprite mappings - signpost
; ---------------------------------------------------------------------------
Map_Sign_internal:
		dc.w @eggman-Map_Sign_internal
		dc.w @spin1-Map_Sign_internal
		dc.w @spin2-Map_Sign_internal
		dc.w @spin3-Map_Sign_internal
		dc.w @sonic-Map_Sign_internal
@eggman:	dc.b 3
		dc.b $F0, $B, 8, 0, 0
		dc.b $10, 1, 0, $44, $FC
		dc.b $F0, $B, 0, $C, $E8
@spin1:		dc.b 2
		dc.b $F0, $F, 0, $18, $F0
		dc.b $10, 1, 0,	$44, $FC
@spin2:		dc.b 2
		dc.b $F0, 3, 0,	$28, $FC
		dc.b $10, 1, 8,	$44, $FC
@spin3:		dc.b 2
		dc.b $F0, $F, 8, $18, $F0
		dc.b $10, 1, 8,	$44, $FC
@sonic:		dc.b 3
		dc.b $F0, $B, 0, $2C, $E8
		dc.b $F0, $B, 0, $38, 0
		dc.b $10, 1, 0,	$44, $FC
		even