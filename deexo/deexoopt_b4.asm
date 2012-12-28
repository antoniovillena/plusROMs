; mapbase low byte must $00

        xor     a
        ld      a, 128
        ld      iyl, 240
        ld      b, 52
        push    de
init    ld      c, 16
        jr      nz, get4
        ld      de, 1
        ld      ixl, c
        defb    218
gb4     ld      a, (hl)
        dec     hl
get4    adc     a, a
        jr      z, gb4
        rl      c
        jr      nc, get4
        ld      iyh, mapbase/256
        ex      af, af'
        ld      a, c
        cp      8
        jr      c, get5
        xor     136
get5    inc     a
        ld      (iy+0), a
        push    hl
        ld      hl, 1
        ex      af, af'
        defb    210
setbit  add     hl, hl
        dec     c
        jr      nz, setbit
        inc     iyh
        ld      (iy+0), e
        inc     iyh
        ld      (iy+0), d
        add     hl, de
        ex      de, hl
        inc     iyl
        pop     hl
        dec     ixl
        djnz    init
        pop     de
litcop  ldd
mloop   add     a, a
        jr      z, gbm
        jr      c, litcop
gbmc    ld      bc, mapbase+240
        add     a, a
        jr      z, gbi2
        jr      nc, gbic
getind  add     a, a
        jr      z, gbi
geti2   inc     c
        jr      c, getind
        ret     z
gbic    push    de
        ex      af, af'
        ld      a, (bc)
        ld      b, a
        ex      af, af'
        ld      de, 0
        dec     b
        call    nz, getbits
        ex      af, af'
        ld      b, (mapbase/256)+1
        ld      a, (bc)
        inc     b
        add     a, e
        ld      e, a
        ld      a, (bc)
        adc     a, d
        ld      d, a
        push    de
        ld      bc, 512+32
        dec     e
        jr      z, goit
        dec     e
        ld      bc, 1024+16
        jr      z, goit
        ld      c, 0
        ld      e, c
goit    ld      d, e
        ex      af, af'
        call    lee8
        ex      af, af'
        ld      a, e
        add     a, c
        ld      c, a
        ld      e, d
        ld      b, mapbase/256
        ld      a, (bc)
        ld      b, a
        ex      af, af'
        dec     b
        call    nz, getbits
        ex      af, af'
        ld      b, (mapbase/256)+1
        ld      a, (bc)
        inc     b
        add     a, e
        ld      e, a
        ld      a, (bc)
        adc     a, d
        ld      d, a
        ex      af, af'
        pop     bc
        ex      (sp), hl
        ex      de, hl
        add     hl, de
        lddr
        pop     hl
        jp      mloop

gbi     ld      a, (hl)
        dec     hl
        adc     a, a
        jr      c, geti2
        inc     c
        jp      nz, gbic
        ret
gbi2    ld      a, (hl)
        dec     hl
        adc     a, a
        jr      c, getind
        jp      gbic
gbm     ld      a, (hl)
        dec     hl
        adc     a, a
        jr      nc, gbmc
        jp      litcop

getbits jp      p, lee8
        ld      e, (hl)
        dec     hl
        rl      b
        ret     z
        srl     b
        defb    $fa
xopy    ld      a, (hl)
        dec     hl
lee16   adc     a, a
        jr      z, xopy
        rl      d
        djnz    lee16
        ret

copy    ld      a, (hl)
        dec     hl
lee8    adc     a, a
        jr      z, copy
        rl      e
        djnz    lee8
        ret