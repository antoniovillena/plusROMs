; Original code by Metalbrain
; Optimizations by Antonio Villena and Urusergi
; normal:   exomizer raw <input_file> -c -o <intermediate_file>
;           exoopt <intermediate_file> <output_file>
; reverse:  exomizer raw <input_file> -b -r -c -o <intermediate_file>
;           exoopt <intermediate_file> <output_file> -r
; SIZE  speed 0   speed 1   speed 2   speed 3
; forw      148       150       166       203
; back      146       148       164       201
;        output  deexoopt.bin
;        define  mapbase  $5b00
;        define  speed    3
;        define  back     0
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      iy, 256+mapbase/256*256
      ELSE
        ld      iy, (mapbase+16)/256*256+112
      ENDIF
        ld      a, 128
        ld      b, 52
        push    de
        cp      a
exinit  ld      c, 16
        jr      nz, exget4
        ld      de, 1
        ld      ixl, c
      IF  speed=0
exget4: call    exgetb
      ENDIF
      IF  speed=1
exget4: add     a, a
        call    z, exgetb
      ENDIF
      IF  speed=2 OR speed=3
        defb    218
exgb4:  ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
exget4: adc     a, a
        jr      z, exgb4
      ENDIF
        rl      c
        jr      nc, exget4
    IF  speed=0 OR speed=1
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      (iy-256+mapbase-mapbase/256*256), c
      ELSE
        ld      (iy-112+mapbase-(mapbase+16)/256*256), c
      ENDIF
        push    hl
        ld      hl, 1
        defb    210
    ENDIF
    IF  speed=2
        inc     c
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      (iy-256+mapbase-mapbase/256*256), c
      ELSE
        ld      (iy-112+mapbase-(mapbase+16)/256*256), c
      ENDIF
        push    hl
        ld      hl, 1
        defb    48
    ENDIF
    IF  speed=3
        ex      af, af'
        ld      a, c
        cp      8
        jr      c, exget5
        xor     136
exget5: inc     a
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      (iy-256+mapbase-mapbase/256*256), a
      ELSE
        ld      (iy-112+mapbase-(mapbase+16)/256*256), a
      ENDIF
        push    hl
        ld      hl, 1
        ex      af, af'
        defb    210
    ENDIF
exsetb: add     hl, hl
        dec     c
        jr      nz, exsetb
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      (iy-204+mapbase-mapbase/256*256), e
        ld      (iy-152+mapbase-mapbase/256*256), d
      ELSE
        ld      (iy-60+mapbase-(mapbase+16)/256*256), e
        ld      (iy-8+mapbase-(mapbase+16)/256*256), d
      ENDIF
        add     hl, de
        ex      de, hl
        inc     iyl
        pop     hl
        dec     ixl
        djnz    exinit
        pop     de
  
      IF  back=1
exlit:  ldd
      ELSE
exlit:  ldi
      ENDIF
    IF  speed=0
exloop: call    exgetb
        jr      c, exlit
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      c, 256-1
      ELSE
        ld      c, 112-1
      ENDIF
exgeti: call    exgetb
    ENDIF
    IF  speed=1
exloop: add     a, a
        call    z, exgetb
        jr      c, exlit
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      c, 256-1
      ELSE
        ld      c, 112-1
      ENDIF
exgeti: add     a, a
        call    z, exgetb
    ENDIF
    IF  speed=2 OR speed=3
exloop: add     a, a
        jr      z, exgbm
        jr      c, exlit
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
exgbmc: ld      c, 256-1
      ELSE
exgbmc: ld      c, 112-1
      ENDIF
exgeti: add     a, a
        jr      z, exgbi
    ENDIF
exgbic: inc     c
        jr      c, exgeti
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        bit     4, c
        ret     nz
      ELSE
        ret     m
      ENDIF
        push    de
        ld      iyl, c
    IF  speed=2 OR speed=3
        ld      de, 0
    ENDIF
    IF  speed=3
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      b, (iy-256+mapbase-mapbase/256*256)
      ELSE
        ld      b, (iy-112+mapbase-(mapbase+16)/256*256)
      ENDIF
        dec     b
        call    nz, exgbts
        ex      de, hl
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      c, (iy-204+mapbase-mapbase/256*256)
        ld      b, (iy-152+mapbase-mapbase/256*256)
      ELSE
        ld      c, (iy-60+mapbase-(mapbase+16)/256*256)
        ld      b, (iy-8+mapbase-(mapbase+16)/256*256)
      ENDIF
        add     hl, bc
        ex      de, hl
    ELSE
        call    expair
    ENDIF
        push    de
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      bc, 512+48
        dec     e
        jr      z, exgoit
        dec     e
        ld      bc, 1024+32
        jr      z, exgoit
        ld      c, 16
      ELSE
        ld      bc, 512+160
        dec     e
        jr      z, exgoit
        dec     e
        ld      bc, 1024+144
        jr      z, exgoit
        ld      c, 128
      ENDIF
    IF  speed=0 OR speed=1
exgoit: call    exgbts
    ENDIF
    IF  speed=2
        ld      e, 0
exgoit: ld      d, e
        call    exgbts
    ENDIF
    IF  speed=3
        ld      e, 0
exgoit: ld      d, e
        call    exlee8
    ENDIF
        ld      iyl, c
        add     iy, de
    IF  speed=2 OR speed=3
        ld      e, d
    ENDIF
    IF  speed=3
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      b, (iy-256+mapbase-mapbase/256*256)
      ELSE
        ld      b, (iy-112+mapbase-(mapbase+16)/256*256)
      ENDIF
        dec     b
        call    nz, exgbts
        ex      de, hl
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      c, (iy-204+mapbase-mapbase/256*256)
        ld      b, (iy-152+mapbase-mapbase/256*256)
      ELSE
        ld      c, (iy-60+mapbase-(mapbase+16)/256*256)
        ld      b, (iy-8+mapbase-(mapbase+16)/256*256)
      ENDIF
        add     hl, bc
        ex      de, hl
    ELSE
        call    expair
    ENDIF
        pop     bc
        ex      (sp), hl
      IF  back=1
        ex      de, hl
        add     hl, de
        lddr
      ELSE
        push    hl
        sbc     hl, de
        pop     de
        ldir
      ENDIF
        pop     hl
        jr      exloop
    IF  speed=2 OR speed=3
exgbm:  ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
        adc     a, a
        jr      nc, exgbmc
        jp      exlit
exgbi:  ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
        adc     a, a
        jp      exgbic
    ENDIF
    IF  speed=3
exgbts: jp      p, exlee8
        ld      e, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
        rl      b
        ret     z
        srl     b
        defb    250
exxopy: ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
exl16:  adc     a, a
        jr      z, exxopy
        rl      d
        djnz    exl16
        ret
excopy: ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
exlee8: adc     a, a
        jr      z, excopy
        rl      e
        djnz    exlee8
        ret
    ELSE
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
expair: ld      b, (iy-256+mapbase-mapbase/256*256)
      ELSE
expair: ld      b, (iy-112+mapbase-(mapbase+16)/256*256)
      ENDIF
      IF speed=2
        dec     b
        call    nz, exgbts
      ELSE
        call    exgbts
      ENDIF
        ex      de, hl
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      c, (iy-204+mapbase-mapbase/256*256)
        ld      b, (iy-152+mapbase-mapbase/256*256)
      ELSE
        ld      c, (iy-60+mapbase-(mapbase+16)/256*256)
        ld      b, (iy-8+mapbase-(mapbase+16)/256*256)
      ENDIF
        add     hl, bc
        ex      de, hl
        ret
    ENDIF
    IF  speed=0 OR speed=1
exgbts: ld      de, 0
excont: dec     b
        ret     m
      IF  speed=0
        call    exgetb
      ELSE
        add     a, a
        call    z, exgetb
      ENDIF
        rl      e
        rl      d
        jr      excont
      IF  speed=0
exgetb: add     a, a
        ret     nz
        ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
        adc     a, a
        ret
      ELSE
exgetb: ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
        adc     a, a
        ret
      ENDIF
    ENDIF
    IF  speed=2
exgbg:  ld      a, (hl)
        IF  back=1
        dec     hl
        ELSE
        inc     hl
        ENDIF
exgbts: adc     a, a
        jr      z, exgbg
        rl      e
        rl      d
        djnz    exgbts
        ret
    ENDIF