GFX_DATA    PROC

@@pistol:   
            gfx_start   ;01234567;
            gfx_row     "........"
            gfx_row     "...@@..."
            gfx_row     "..@@@@.."
            gfx_row     "..@@@@.."
            gfx_row     "..@@@@.."
            gfx_row     "...@@..."
            gfx_row     "........"
            gfx_row     "........"
            gfx_flush

@@pistol_hand:   
            gfx_start   ;01234567;
            gfx_row     "........"
            gfx_row     "........"
            gfx_row     ".@....@."
            gfx_row     "@@@..@@."
            gfx_row     "@@@@@@@@"
            gfx_row     "@@@@@@@@"
            gfx_row     ".@@@@@@."
            gfx_row     "..@@@@@."
            gfx_flush

@@stormtrooper_tan:   
            gfx_start   ;01234567;
            gfx_row     "........"
            gfx_row     "........"
            gfx_row     "...@@..."
            gfx_row     "..@@@@.."
            gfx_row     "..@@@@.."
            gfx_row     "...@@..."
            gfx_row     ".@@@@@@."
            gfx_row     "@.@@@@.@"
            gfx_row     "@.@@@@.@"
            gfx_row     "@.@@@@.@"
            gfx_row     "@.@@@@.@"
            gfx_row     "@.@@@@.@"
            gfx_row     "..@..@.."
            gfx_row     "..@..@.."
            gfx_row     "..@..@.."
            gfx_row     ".@@..@@."
            gfx_flush

@@stormtrooper_black:   
            gfx_start   ;01234567;
            gfx_row     "..@@@@.."
            gfx_row     ".@@@@@@."
            gfx_row     ".@....@."
            gfx_row     ".@....@."
            gfx_row     "........"
            gfx_row     "........"
            gfx_row     "..@....."
            gfx_row     "...@...."
            gfx_row     "....@..."
            gfx_row     ".....@.."
            gfx_row     "@......."
            gfx_row     "@.@@@@.."
            gfx_row     "........"
            gfx_row     "........"
            gfx_row     "..@..@.."
            gfx_row     ".@@..@@."
            gfx_flush
            ENDP
            
;; ======================================================================== ;;
;;  GFX:  Short-hand names for referring to individual pictures in above.   ;;
;;        These labels are integer picture numbers that fit in 8-bit mem.   ;;
;; ======================================================================== ;;
GFX         PROC
@@pistol                  EQU     (GFX_DATA.pistol - GFX_DATA) / 4
@@pistol_hand             EQU     (GFX_DATA.pistol_hand - GFX_DATA) / 4
@@stormtrooper_tan        EQU     (GFX_DATA.stormtrooper_tan - GFX_DATA) / 4
@@stormtrooper_black      EQU     (GFX_DATA.stormtrooper_black - GFX_DATA) / 4
            ENDP
