PLAY_SFX_FIRE PROC
	BEGIN

        MVII    #1111b, 		R0
        MVO		R0,				PSG0.chn_a_hi

        MVII    #$FF, 			R0
        MVO		R0,				PSG0.chn_a_lo

        MVII    #01111b, 		R0
        MVO		R0,				PSG0.noise

        MVII    #$0F, 			R0
        MVO		R0,				PSG0.envlp_hi

        MVII    #$00, 			R0
        MVO		R0,				PSG0.envlp_lo

        MVII    #PSG.vol_envl,	R0
        MVO		R0,				PSG0.chn_a_vol

        MVII    #PSG.envl_cont + PSG.envl_hold, R0
        MVO		R0,				PSG0.envelope

        MVII    #PSG.noise_a_on + PSG.tone_a_off, R0
        MVO		R0,				PSG0.chan_enable

	RETURN
	ENDP

STOP_SFX PROC
	BEGIN

        MVII    #PSG.vol_0,		R0
        MVO		R0,				PSG0.chn_a_vol
        MVO		R0,				PSG0.chn_b_vol
        MVO		R0,				PSG0.chn_c_vol

	RETURN
	ENDP
