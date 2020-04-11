GROM_F_45_SE   	QEQU    $74 * 8
GROM_F_45_SW   	QEQU    $75 * 8
GROM_F_45_NE   	QEQU    $76 * 8
GROM_F_45_NW   	QEQU    $77 * 8

GROM_F_1_2_NW_A QEQU    $6F * 8
GROM_F_1_2_NW_B QEQU    $73 * 8

GROM_F_1_2_SW_A QEQU    $6D * 8
GROM_F_1_2_SW_B QEQU    $71 * 8

GROM_F_1_4_SW_A QEQU    $95 * 8
GROM_F_1_4_SW_B QEQU    $97 * 8

GROM_F_1_2_SE_A QEQU    $6C * 8
GROM_F_1_2_SE_B QEQU    $70 * 8

GROM_F_1_2_NE_A QEQU    $6E * 8
GROM_F_1_2_NE_B QEQU    $72 * 8

GROM_F   		QEQU    $5F * 8
LEFT_WALL:	PROC

        PSHR  R5

        MVII    #$0,        R1 ; X
        MVII    #$8,        R2 ; height
        MVII    #$0,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$1,        R1 ; X
        MVII    #$8,        R2 ; height
        MVII    #$0,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$2,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$3,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #GROM_F_1_2_SW_B + C_DGR, R0
        MVO     R0,         $200 + 2

        MVII    #GROM_F_1_2_SW_A + C_DGR, R0
        MVO     R0,         $200 + 3

        MVII    #GROM_F_1_2_NW_B + C_DGR, R0
        MVO     R0,         $200 + 0 + ($14 * 8)

        MVII    #GROM_F_1_2_NW_A + C_DGR, R0
        MVO     R0,         $200 + 1 + ($14 * 8)

        ;; GRAY FLOOR STARTS HERE!
        MVII    #GROM_F_1_2_NW_B + C_DGR + cs_advance, R0
        MVO     R0,         $200 + 2 + ($14 * 7)

        MVII    #GROM_F_1_2_NW_A + C_DGR, R0
        MVO     R0,         $200 + 3 + ($14 * 7)

        PULR  R5

		    JR		R5

		    ENDP

FORWARD_DOOR:	PROC

        PSHR  R5

        MVII    #$8,        R1 ; X
        MVII    #$4,        R2 ; height
        MVII    #$3,        R3 ; offset
        MVII    #C_BLU,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$9,        R1 ; X
        MVII    #$4,        R2 ; height
        MVII    #$3,        R3 ; offset
        MVII    #C_BLU,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$A,        R1 ; X
        MVII    #$4,        R2 ; height
        MVII    #$3,        R3 ; offset
        MVII    #C_BLU,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$B,        R1 ; X
        MVII    #$4,        R2 ; height
        MVII    #$3,        R3 ; offset
        MVII    #C_BLU,     R4 ; color
        CALL    FILL_COLUMN

        PULR  R5

		    JR		R5
		    ENDP

LEFT_DOOR:	PROC

        PSHR  R5

        MVII    #$0,        R1 ; X
        MVII    #$5,        R2 ; height
        MVII    #$3,        R3 ; offset
        MVII    #C_BLU,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$1,        R1 ; X
        MVII    #$5,        R2 ; height
        MVII    #$3,        R3 ; offset
        MVII    #C_BLU,     R4 ; color
        CALL    FILL_COLUMN

        ; Do these need GRAM to do properly (1:6 slope)
        MVII    #GROM_F_1_4_SW_B + C_BLU + cs_advance, R0
        MVO     R0,         $200 + 0 + ($14 * 2)

        MVII    #GROM_F_1_4_SW_A + C_BLU, R0
        MVO     R0,         $200 + 1 + ($14 * 2)

        MVII    #GROM_F_1_2_NW_B + C_BLU, R0
        MVO     R0,         $200 + 0 + ($14 * 8)

        MVII    #GROM_F_1_2_NW_A + C_BLU, R0
        MVO     R0,         $200 + 1 + ($14 * 8)

        PULR  R5

		    JR		R5
		    ENDP

RIGHT_WALL:	PROC

        PSHR  R5

        MVII    #$13,       R1 ; X
        MVII    #$8,        R2 ; height
        MVII    #$0,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$12,       R1 ; X
        MVII    #$8,        R2 ; height
        MVII    #$0,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$11,       R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$10,       R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_DGR,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #GROM_F_1_2_SE_B + C_DGR, R0
        MVO     R0,         $200 + $11  

        MVII    #GROM_F_1_2_SE_A + C_DGR, R0
        MVO     R0,         $200 + $10

        MVII    #GROM_F_1_2_NE_B + C_DGR, R0
        MVO     R0,         $200 + $13 + ($14 * 8)

        MVII    #GROM_F_1_2_NE_A + C_DGR, R0
        MVO     R0,         $200 + $12 + ($14 * 8)

        MVII    #GROM_F_1_2_NE_B + C_DGR, R0
        MVO     R0,         $200 + $11 + ($14 * 7)

        MVII    #GROM_F_1_2_NE_A + C_DGR, R0
        MVO     R0,         $200 + $10 + ($14 * 7)

        PULR  R5

		    JR		R5
		    ENDP

FORWARD_WALL:	PROC

        PSHR    R5

        MVII    #$4,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$5,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$6,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$7,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$8,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$9,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$A,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$B,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$C,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$D,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$E,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN

        MVII    #$F,        R1 ; X
        MVII    #$6,        R2 ; height
        MVII    #$1,        R3 ; offset
        MVII    #C_GRN,     R4 ; color
        CALL    FILL_COLUMN


        PULR    R5
        JR      R5
        ENDP

;; ======================================================================== ;;
;; Draw a 1xN filled column at column X
;; ======================================================================== ;;

FILL_COLUMN:	PROC

        ; Let   R1 = column number (X)
        ; Let   R2 = column height (N)
        ; Let   R3 = column offset
        ; Let   R4 = color

        ADDI    #$200,      R1

        ; if R3 = 0, skip offset

        TSTR    R3
        BEQ    @@fill_loop

@@offset_loop

        ; apply offset from top

        ADDI	#$14, 	    R1

        DECR    R3
        BNEQ    @@offset_loop

@@fill_loop:

        ; Put to backtab

        MVII	#GROM_F,	R0
        ADDR    R4, 	    R0 ; R4 = color
        MVO@    R0,     	R1

        ; R1 = R1 + 20

        ADDI	#$14, 	    R1

        ; N = N - 1
        ; If N != 0, loop

        DECR    R2
        BNEQ    @@fill_loop

        JR 		R5

        ENDP
