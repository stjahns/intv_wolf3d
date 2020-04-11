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
GROM_F_1_4_SW_C QEQU    $99 * 8
GROM_F_1_4_SW_D QEQU    $9B * 8

GROM_F_1_4_SE_A QEQU    $94 * 8
GROM_F_1_4_SE_B QEQU    $96 * 8
GROM_F_1_4_SE_C QEQU    $98 * 8
GROM_F_1_4_SE_D QEQU    $9A * 8

GROM_F_1_2_SE_A QEQU    $6C * 8
GROM_F_1_2_SE_B QEQU    $70 * 8

GROM_F_1_2_NE_A QEQU    $6E * 8
GROM_F_1_2_NE_B QEQU    $72 * 8

GROM_F   		QEQU    $5F * 8

MACRO FILL_AREA x, y, w, h, c

        MVII    #%x%,        R1 ; X
        MVII    #%h%,       R2 ; height
        MVII    #%y%,        R3 ; offset
        MVII    #%c%,     R4 ; color
        CALL    FILL_COLUMN

        IF %w% > 1 
          FILL_AREA %x%+1, %y%, %w%-1, %h%, %c%
        ENDI

ENDM


LEFT_WALL PROC

        BEGIN

        FILL_AREA $0, 0, 2, 8, C_DGR
        FILL_AREA $2, 1, 2, 6, C_DGR

        MVII    #GROM_F_1_2_SW_B + C_DGR, R0
        MVO     R0,         $200 + 2

        MVII    #GROM_F_1_2_SW_A + C_DGR, R0
        MVO     R0,         $200 + 3

        MVII    #GROM_F_1_2_NW_B + C_DGR, R0
        MVO     R0,         $200 + 0 + ($14 * 8)

        MVII    #GROM_F_1_2_NW_A + C_DGR, R0
        MVO     R0,         $200 + 1 + ($14 * 8)

        ;; GRAY FLOOR STARTS HERE!
        MVII    #GROM_F_1_2_NW_B + C_DGR + STIC.cs_advance, R0
        MVO     R0,         $200 + 2 + ($14 * 7)

        MVII    #GROM_F_1_2_NW_A + C_DGR, R0
        MVO     R0,         $200 + 3 + ($14 * 7)

        RETURN
		    ENDP

FORWARD_DOOR PROC
        BEGIN
        FILL_AREA $8, 3, 4, 4, C_BLU
        RETURN
		    ENDP

LEFT_DOOR	PROC
        
        BEGIN

        FILL_AREA $0, 3, 2, 5, C_BLU

        ; Do these need GRAM to do properly (1:6 slope)
        MVII    #GROM_F_1_4_SW_B + C_BLU + STIC.cs_advance, R0
        MVO     R0,         $200 + 0 + ($14 * 2)

        MVII    #GROM_F_1_4_SW_A + C_BLU, R0
        MVO     R0,         $200 + 1 + ($14 * 2)

        MVII    #GROM_F_1_2_NW_B + C_BLU, R0
        MVO     R0,         $200 + 0 + ($14 * 8)

        MVII    #GROM_F_1_2_NW_A + C_BLU, R0
        MVO     R0,         $200 + 1 + ($14 * 8)

        RETURN

		    ENDP

RIGHT_DOOR	PROC
        
        BEGIN

        FILL_AREA $12, 3, 2, 5, C_BLU

        ; Do these need GRAM to do properly (1:6 slope)
        MVII    #GROM_F_1_4_SE_A + C_BLU, R0
        MVO     R0,         $200 + $12 + ($14 * 2)

        MVII    #GROM_F_1_4_SE_B + C_BLU, R0
        MVO     R0,         $200 + $13 + ($14 * 2)

        MVII    #GROM_F_1_2_NE_B + C_BLU, R0
        MVO     R0,         $200 + $13 + ($14 * 8)

        MVII    #GROM_F_1_2_NE_A + C_BLU, R0
        MVO     R0,         $200 + $12 + ($14 * 8)

        RETURN

		    ENDP

RIGHT_WALL PROC
      
        BEGIN

        FILL_AREA $10, 1, 2, 6, C_DGR
        FILL_AREA $12, 0, 2, 8, C_DGR

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
  
        RETURN

		    ENDP

MACRO DRAW_FORWARD_WALL c
        FILL_AREA 4, 1, 12, 6, %c%
ENDM

FORWARD_WALL PROC
        BEGIN
        FILL_AREA 4, 1, 12, 6, C_GRN
        RETURN
        ENDP

;; ======================================================================== ;;
;; Draw a 1xN filled column at column X
;; ======================================================================== ;;

FILL_COLUMN PROC

        BEGIN

        ; Let   R1 = column number (X)
        ; Let   R2 = column height (N)
        ; Let   R3 = column offset
        ; Let   R4 = color

        ADDI    #MEMMAP.backtab,      R1

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

        RETURN

        ENDP
