        ld      de, map
        ld      hl, fin-1
        ld      bc, 0
desc1:  sbc     hl, bc
        ex      de, hl
        ld      c, (hl)
        ex      de, hl
        inc     de
        dec     a
        jp      p, desc1
        ld      de, DMAP_BUFFER+12*8-1  ; scrw*scrh-1
        ld      b, $80          ; marker bit
desc2:  ld      a, 256 >> DMAP_BITSYMB
desc3:  call    gbit3           ; load DMAP_BITSYMB bits (literal)
        jr      nc, desc3
      IF DMAP_BITHALF=1
        rrca                    ; half bit implementation (ie 48 tiles)
        call    c, gbit1
      ELSE
        and     a
      ENDIF
        ld      (de), a         ; write literal
desc4:  dec     e               ; test end of file (map is always 150 bytes)
        ret     z
        call    gbit3           ; read one bit
        rra
        jr      nc, desc2       ; test if literal or sequence
        push    de              ; if sequence put de in stack
        ld      a, 1            ; determine number of bits used for length
desc5:  call    nc, gbit3       ; (Elias gamma coding)
        and     a
        call    gbit3
        rra
        jr      nc, desc5       ; check end marker
        inc     a               ; adjust length
        ld      c, a            ; save lenth to c
        xor     a
        ld      de, 12          ; initially point to 15 (scrw)
        call    gbit3           ; get two bits
        call    gbit3
        jr      z, desc8        ; 00 = 1
        dec     a
        call    gbit3
        jr      z, desc9        ; 010 = 12
        bit     2, a
        jr      nz, desc7
        call    gbit3           ; [011, 100, 101] xx = from 2 to 11 and from 13 to 14
        call    gbit3
        cp      14
        sbc     a, 2
        jr      desc8
desc7:  call    gbit3           ; [110, 111] xxxxxx = from 15 to 142
        jr      nc, desc7
        add     a, 14
desc8:  inc     a
        ld      e, a
desc9:  ld      a, b            ; save b (byte reading) on a
        ld      b, d            ; b= 0 because lddr moves bc bytes
        ex      (sp), hl        ; store source, restore destination
        ex      de, hl          ; HL = destination + offset + 1
        add     hl, de          ; DE = destination
        lddr
        pop     hl              ; restore source address (compressed data)
        ld      b, a            ; restore b register
        inc     e               ; prepare test of end of file
        jr      desc4           ; jump to main loop
      IF DMAP_BITHALF=1
gbit1:  sub     $80 - (1 << DMAP_BITSYMB - 2)
        defb    $da             ; second part of half bit implementation
      ENDIF
gbit2:  ld      b, (hl)         ; load another group of 8 bits
        dec     hl
gbit3:  rl      b               ; get next bit
        jr      z, gbit2        ; no more bits left?
        adc     a, a            ; put bit in a
        ret