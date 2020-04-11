;;==========================================================================;;
;; TODO                                                                     ;;
;;==========================================================================;;

    CFGVAR  "name" = "WOLFENSTEIN 3D"
    CFGVAR  "short_name" = "WOLFENSTEIN 3D"
    CFGVAR  "author" = "Steve Jahns"
    CFGVAR  "year" = 2020
    CFGVAR  "license" = "CC0 v1.0"
    CFGVAR  "description" = "Port of Wolfenstein 3D to the Intellivision"
    CFGVAR  "publisher" = "SDK-1600"

    ROMW    16              ; Use 16-bit ROM
    ORG     $5000           ; Use default memory map

;------------------------------------------------------------------------------
; Include system information
;------------------------------------------------------------------------------
            INCLUDE "../library/gimini.asm"

;------------------------------------------------------------------------------
; EXEC-friendly ROM header.
;------------------------------------------------------------------------------
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
        INCLUDE "walls.asm"

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

        CALL    CLRSCR          ; Clear the screen

        CALL	  TEST_1X1

@@loop:


        B       @@loop

        ENDP

;; ======================================================================== ;;
;;  ISR   -- A simple ISR to keep the screen enabled.                       ;;
;; ======================================================================== ;;

ISR     PROC

        MVO     R0,     STIC.viden     ; STIC handshake to keep display enabled

        CLRR	  R0
        MVO    	R0,     STIC.bord     ; Set border to black

        ; Init color stack

        MVII    #C_BRN, 	R0
        MVO    	R0,     STIC.cs0

        MVII    #C_DGR, 	R0
        MVO    	R0,     STIC.cs1

        ;MVII    #C_GRN, 	R0
        MVII    #C_GRY, 	R0
        MVO    	R0,     STIC.cs2

        MVII    #C_GRY, 	R0
        MVO    	R0,     STIC.cs3

        MVI    	STIC.mode, R0		; Set Color Stack Mode (read from $0021)

        JR      R5              ; Return
        ENDP

;; ======================================================================== ;;
;; TEST 1: Draw a 1x1 Room                                                  ;;
;; ======================================================================== ;;

TEST_1X1	PROC
        
        BEGIN

        CALL  LEFT_WALL
        CALL  LEFT_DOOR

        DRAW_FORWARD_WALL C_GRN

        CALL  FORWARD_DOOR
        CALL  RIGHT_WALL
        CALL  RIGHT_DOOR
  
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
