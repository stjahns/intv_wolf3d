;;==========================================================================;;
;; TODO                                                                     ;;
;;  [ ] Deliberate y tilt/scaling effect
;;  [ ] VFX for firing, hits
;;  [ ] SFX
;;  [ ] VOICES?
;;==========================================================================;;

    CFGVAR  "name" = "WOLFENSTEIN 3D"
    CFGVAR  "short_name" = "WOLFENSTEIN 3D"
    CFGVAR  "author" = "Steve Jahns"
    CFGVAR  "year" = 2020
    CFGVAR  "license" = "CC0 v1.0"
    CFGVAR  "description" = "Port of Wolfenstein 3D to the Intellivision"
    CFGVAR  "publisher" = "SDK-1600"

;------------------------------------------------------------------------------
; Include system information
;------------------------------------------------------------------------------
            INCLUDE "../library/gimini.asm"


;------------------------------------------------------------------------------
; SCRATCH memory
;------------------------------------------------------------------------------

SCRATCH     ORG     $100, $100, "-RWBN"
ISRVEC      RMB     2               ; Always at $100 / $101

P_HEADING   RMB     1
AIM_X       RMB     1

FIRE_TIMER  RMB     1
AIM_Y       RMB     1

_SCRATCH    EQU     $               ; end of scratch area



;------------------------------------------------------------------------------
; EXEC-friendly ROM header.
;------------------------------------------------------------------------------

    ORG     $5000           ; Use default memory map

ROMHDR: BIDECLE ZERO            ; MOB picture base   (points to NULL list)
        BIDECLE ZERO            ; Process table      (points to NULL list)
        BIDECLE MAIN            ; Program start address
        BIDECLE ZERO            ; Bkgnd picture base (points to NULL list)
        BIDECLE ONES            ; GRAM pictures      (points to NULL list)
        BIDECLE TITLE           ; Cartridge title/date
        DECLE   $03C0           ; No ECS title, run code after title,
                                ; ... no clicks
ZERO:   DECLE   $0000           ; Screen border control
        DECLE   $0000           ; 0 = color stack, 1 = f/b mode
ONES:   DECLE   C_WHT, C_WHT    ; Initial color stack 0 and 1: Green
        DECLE   C_WHT, C_WHT    ; Initial color stack 2 and 3: Green
        DECLE   C_WHT           ; Initial border color: Green
;------------------------------------------------------------------------------

;; ======================================================================== ;;
;; INCLUDES
;; ======================================================================== ;;

        INCLUDE "../macro/gfx.mac"
        INCLUDE "../macro/stic.mac"

        INCLUDE "gfx_data.asm"
        INCLUDE "walls.asm"
        INCLUDE "sfx.asm"

;; ======================================================================== ;;
;;  TITLE  -- Display our modified title screen & copyright date.           ;;
;; ======================================================================== ;;
TITLE:  PROC
        BYTE    108, 'Wolfenstein 3D', 0

;; ======================================================================== ;;
;;  MAIN   -- Where our program starts (immediately after title string).    ;;
;; ======================================================================== ;;
MAIN:
        MVII    #ISR,   R0
        MVO     R0,     $100
        SWAP    R0
        MVO     R0,     $101
        EIS

        MVII    #80,    R0
        MVO     R0,     AIM_X

        MVII    #0,     R0
        MVO     R0,     AIM_Y

        MVII    #0,     R0
        MVO     R0,     FIRE_TIMER

        CALL    CLRSCR          ; Clear the screen

        ;MVII    #gen_cstk_card(GFX.pistol, GRAM, Black, NoAdv), R0
        ;MVO     R0,         $200 + $A + ($14 * $A)

        ;MVII    #gen_cstk_card(GFX.pistol_hand, GRAM, Tan, NoAdv), R0
        ;MVO     R0,         $200 + $A + ($14 * $B)

        CALL	  TEST_1X1

@@loop:
        ;CALL    CONTROL_GUN
        B       @@loop

        ENDP

;;==========================================================================;;
CONTROL_GUN PROC
        BEGIN

        CALL    GET_CONTROL

        MOVR    R0, R3
        ANDI    #CONTROL.d_right, R3
        BNEQ    @@aim_right

        MOVR    R0, R3
        ANDI    #CONTROL.d_left, R3
        BNEQ    @@aim_left

        B       @@aim_done

@@aim_right


        MVII    #AIM_X, R4
        MVI@    R4,     R1
        INCR    R1
        MVO     R1,     AIM_X
        B       @@aim_done

@@aim_left

        MVII    #AIM_X, R4
        MVI@    R4,     R1
        DECR    R1
        MVO     R1,     AIM_X
        B       @@aim_done

@@aim_done

        MOVR    R0, R3
        ANDI    #CONTROL.d_up, R3
        BEQ    @@fire_done

        ;; Can't fire while FIRE_TIMER > 0

        MVII    #FIRE_TIMER,  R4
        MVI@    R4,     R0
        TSTR    R0

        BNEQ    @@fire_done

		CALL	PLAY_SFX_FIRE

        MVII    #-8,     R0
        MVO     R0,     FIRE_TIMER

        ;; TODO -- how do we shoot the doods?
        ;; 1. iterate over active mobs, check dx
        ;; 2. use invisible mobs + check collisions?

@@fire_done

        MVII    #FIRE_TIMER,  R4
        MVI@    R4,     R0
        TSTR    R0
        BEQ     @@recoil_done

        INCR    R0
        MVO     R0,     FIRE_TIMER

@@recoil_done


        RETURN
        ENDP

;;==========================================================================;;

CONTROL PROC
@@right   QEQU  $1FE
@@left    QEQU  $1FF

@@d_up    QEQU  $4
@@d_down  QEQU  $1
@@d_left  QEQU  $8
@@d_right QEQU  $2
        ENDP

GET_CONTROL PROC
        MVII    #CONTROL.right,  R4
        MVI@    R4,     R0
        XOR@    R4,     R0
        JR      R5
        ENDP

;; ======================================================================== ;;
;;  ISR   -- A simple ISR to keep the screen enabled.                       ;;
;; ======================================================================== ;;

ISR     PROC
        BEGIN

        MVO     R0,     STIC.viden     ; STIC handshake to keep display enabled

        CLRR	  R0
        MVO    	R0,     STIC.bord     ; Set border to black

        ; Init color stack

        MVII    #C_BRN, 	R0
        MVO    	R0,     STIC.cs0

        MVI     P_HEADING, R0
        ANDI    #$1, R0
        BNEQ    @@heading_EW

@@heading_NS:

        MVII    #C_GRN, 	R0
        MVO    	R0,     STIC.cs1
        J       @@heading_end

@@heading_EW:

        MVII    #C_DGR, 	R0
        MVO    	R0,     STIC.cs1

@@heading_end:

        MVII    #C_GRY, 	R0
        MVO    	R0,     STIC.cs2

        MVII    #C_GRY, 	R0
        MVO    	R0,     STIC.cs3

        MVI    	STIC.mode, R0		; Set Color Stack Mode (read from $0021)

@@update_gram:

        ;; copy *R4 -> *R5
        MVII    #GFX_DATA, R4
        MVII    #MEMMAP.gram, R5

        REPEAT 24 
        MVI@   R4, R0 ; get next two rows
        MVO@   R0, R5 ; write even # row
        SWAP   R0
        MVO@   R0, R5 ; write odd # row
        ENDR

        CALL    CONTROL_GUN

@@update_mobs:

@@pistol_mob_x  QEQU STIC.mobx_visb + STIC.mobx_xsize
@@pistol_mob_y  QEQU 88 + STIC.moby_ysize4
@@hand_mob_y    QEQU 92 + STIC.moby_ysize4
@@pistol_mob_a  QEQU C_BLK + GFX.pistol * 8 + STIC.moba_gram
@@hand_mob_a    QEQU C_TAN + GFX.pistol_hand * 8 + STIC.moba_gram

        MVII    #AIM_X, R4
        MVI@    R4,     R0
        ADDI    #@@pistol_mob_x, R0

        MVO     R0, STIC.mob0_x    
        MVO     R0, STIC.mob1_x    

        MVII    #FIRE_TIMER, R4
        MVI@    R4,     R0
        ADDI    #@@pistol_mob_y, R0
        MVO     R0, STIC.mob0_y    

        MVII    #FIRE_TIMER, R4
        MVI@    R4,     R0
        ADDI    #@@hand_mob_y, R0
        MVO     R0, STIC.mob1_y    

        MVII    #@@pistol_mob_a, R0
        MVO     R0, STIC.mob0_a    

        MVII    #@@hand_mob_a, R0
        MVO     R0, STIC.mob1_a    

        ;; TODO -- if we JUST fired, show a red flash?

@@st_mob_x  QEQU 40 + STIC.mobx_visb + STIC.mobx_xsize
@@st_mob_y  QEQU 48 + STIC.moby_ysize4 + STIC.moby_yres

@@st_mob_1_a  QEQU C_TAN + GFX.stormtrooper_tan * 8 + STIC.moba_gram
@@st_mob_2_a  QEQU C_BLK + GFX.stormtrooper_black * 8 + STIC.moba_gram

        MVII    #@@st_mob_x, R0
        MVO     R0, STIC.mob2_x    
        MVO     R0, STIC.mob3_x    

        MVII    #@@st_mob_y, R0
        MVO     R0, STIC.mob2_y    
        MVO     R0, STIC.mob3_y    

        MVII    #@@st_mob_1_a, R0
        MVO     R0, STIC.mob3_a

        MVII    #@@st_mob_2_a, R0
        MVO     R0, STIC.mob2_a    

        RETURN
        ENDP

;; ======================================================================== ;;
;; TEST 1: Draw a 1x1 Room                                                  ;;
;; ======================================================================== ;;

TEST_1X1	PROC
        
        BEGIN

        ; If heading is even/odd ..
        MVI     P_HEADING, R0  
        ANDI    #$1, R0
        BNEQ    @@heading_EW

@@heading_NS:

        DRAW_LEFT_WALL C_GRN
        DRAW_FORWARD_WALL C_DGR
        DRAW_RIGHT_WALL C_GRN

        j @@heading_end
        
@@heading_EW:

        DRAW_LEFT_WALL C_DGR
        DRAW_FORWARD_WALL C_GRN
        DRAW_RIGHT_WALL C_DGR

@@heading_end:

        CALL LEFT_DOOR
        CALL FORWARD_DOOR
        CALL RIGHT_DOOR

        RETURN
		    ENDP

STATUS_BAR PROC
        BEGIN

        FILL_AREA $0, $A, $9, $2, C_BLU 

        FILL_AREA $B, $A, $9, $2, C_BLU

        RETURN
        ENDP


;; ======================================================================== ;;
;;  LIBRARY INCLUDES                                                        ;;
;; ======================================================================== ;;
        INCLUDE "../library/print.asm"     ; PRINT.xxx routines
        INCLUDE "../library/prnum32.asm"   ; PRNUM32.x routines (include before PRNUM16)
        INCLUDE "../library/prnum16.asm"   ; PRNUM16.x routines
        INCLUDE "../library/wnk.asm"       ; WAITKEY routine
        INCLUDE "../library/fillmem.asm"   ; CLRSCR/FILLZERO/FILLMEM
