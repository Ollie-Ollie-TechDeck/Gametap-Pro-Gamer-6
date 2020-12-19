; ---------------------------------------------------------------------------
; Subroutine to	play a music track

; input:
;	d0 = track to play
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PlaySound:
		move.b	d0,(v_snddriver_ram+v_soundqueue0).w
		rts	
; End of function PlaySound

; ---------------------------------------------------------------------------
; Subroutine to	play a sound effect
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


PlaySound_Special:
		move.b	d0,(v_snddriver_ram+v_soundqueue1).w
		rts	
; End of function PlaySound_Special

; ===========================================================================
; ---------------------------------------------------------------------------
; Unused sound/music subroutine
; ---------------------------------------------------------------------------

PlaySound_Unused:
		move.b	d0,(v_snddriver_ram+v_soundqueue2).w
		rts	
; ---------------------------------------------------------------------------
; Subroutine to play a DAC sample
; ---------------------------------------------------------------------------

PlaySample:
        move.w  #$100,($A11100).l       ; stop the Z80
@0      btst    #0,($A11100).l
        bne.s   @0
        move.b  d0,$A01FFF
        move.w  #0,($A11100).l
        rts