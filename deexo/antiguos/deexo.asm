;Exomizer 2 Z80 decoder
; by Metalbrain 
;
; optimized by Antonio Villena and Urusergi (180 bytes)
;
; compression algorithm by Magnus Lind

;input:         hl=compressed data start
;               de=uncompressed destination start
;
;               you may change exo_mapbasebits to point to any free buffer

deexo:          ld      iy, exo_mapbasebits+11
                ld      a, (hl)
                inc     hl
                ld      b, 52
                push    de
                cp      a
exo_initbits:   ld      c, 16
                jr      nz, exo_get4bits
                ld      ixl, c
                ld      de, 1           ;DE=b2
exo_get4bits:   srl     a               ;get one bit
                call    z, exo_getbit
                rl      c
                jr      nc, exo_get4bits
                inc     c
                push    hl
                ld      hl, 1
                ld      (iy+41), c      ;bits[i]=b1 (and opcode 41 == add hl,hl)
exo_setbit:     dec     c
                jr      nz, exo_setbit-1 ;jump to add hl,hl instruction
                ld      (iy-11), e
                ld      (iy+93), d      ;base[i]=b2
                add     hl, de
                ex      de, hl
                pop     hl
                inc     iy
                dec     ixl
                djnz    exo_initbits
                pop     de
                jr      exo_mainloop
gbg:            ld      a, (hl)
                inc     hl
exo_getbits:    rr      a               ;get one bit
                jr      z, gbg
exo_res_carry:  rl      e
                rl      d
                djnz    exo_getbits
                ret     nc
                ld      b, d
                ld      c, e
                pop     de
exo_literalcopy:ldir
exo_mainloop:   inc     c
                srl     a               ;get one bit
                call    z, exo_getbit   ;literal?
                jr      c, exo_literalcopy
                ld      c, 239
exo_getindex:   srl     a               ;get one bit
                call    z, exo_getbit
                inc     c
                jr      nc,exo_getindex
                jp      m, exo_continue
                ret     z
                push    de
                ld      d, b
                ld      e, b
                ld      b, 17
                defb    24
exo_continue:   push    de
                ld      d, b
                ld      iy, exo_mapbasebits-229
                call    exo_getpair
                push    de
                dec     d
                jp      p, exo_dontgo
                dec     e
                ld      bc, 512+32      ;2 bits, 48 offset
                jr      z, exo_goforit
                dec     e               ;2?
exo_dontgo:     ld      bc, 1024+16     ;4 bits, 32 offset
                jr      z, exo_goforit
                ld      c, 0            ;16 offset
                ld      e, c
exo_goforit:    ld      d, e            ;get D bits in BC
                call    exo_getbits
                ld      iy, exo_mapbasebits+27
                add     iy, de
                call    exo_getpair
                pop     bc
                ex      (sp), hl
                push    hl
                sbc     hl, de
                pop     de
                ldir
                pop     hl
                jr      exo_mainloop    ;Next!

exo_getpair:    add     iy, bc
                ld      e, d
                ld      b, (iy+41)
                dec     b
                call    nz, exo_getbits
                ex      de, hl
                ld      c, (iy-11)
                ld      b, (iy+93)
                add     hl, bc          ;Always clear C flag
                ex      de, hl
                ret

exo_getbit:     ld      a, (hl)
                inc     hl
                rra
                ret

exo_mapbasebits:defs    156             ;tables for bits, baseL, baseH