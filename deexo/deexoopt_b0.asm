      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      iy, 256+mapbase/256*256
      ELSE
        ld      iy, (mapbase+16)/256*256+112
      ENDIF
        ld      a, 128
        ld      b, 52
        push    de
        cp      a
init    ld      c, 16
        jr      nz, get4
        ld      de, 1
        ld      ixl, c
get4    call    getbit
        rl      c
        jr      nc, get4
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      (iy-256+mapbase-mapbase/256*256), c
      ELSE
        ld      (iy-112+mapbase-(mapbase+16)/256*256), c
      ENDIF
        push    hl
        ld      hl, 1
        defb    210
setbit  add     hl, hl
        dec     c
        jr      nz, setbit
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
        djnz    init
        pop     de
      IF  literals=1
litcop  inc     c
litseq  lddr
      ELSE
litcop  ldd
      ENDIF
mloop   call    getbit
        jr      c, litcop
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      c, 256-1
      ELSE
        ld      c, 112-1
      ENDIF
getind  call    getbit
        inc     c
        jr      c, getind
    IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        bit     4, c
      IF  literals=1
        jr      nz, litcat
      ELSE
        ret     nz
      ENDIF
    ELSE
      IF  literals=1
        jp      m, litcat
      ELSE
        ret     m
      ENDIF
    ENDIF
        push    de
        ld      iyl, c
        call    getpair
        push    de
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
        ld      bc, 512+48
        dec     e
        jr      z, goit
        dec     e
        ld      bc, 1024+32
        jr      z, goit
        ld      c, 16
      ELSE
        ld      bc, 512+160
        dec     e
        jr      z, goit
        dec     e
        ld      bc, 1024+144
        jr      z, goit
        ld      c, 128
      ENDIF
goit    call    getbits
        ld      iyl, c
        add     iy, de
        call    getpair
        pop     bc
        ex      (sp), hl
        ex      de, hl
        add     hl, de
        lddr
        pop     hl
        jr      mloop

    IF  literals=1
      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
litcat  rl      c
        ret     pe
      ELSE
litcat  ret     po
      ENDIF
        ld      b, (hl)
        dec     hl
        ld      c, (hl)
        dec     hl
        jr      litseq
    ENDIF

      IF  mapbase-mapbase/256*256<240 AND mapbase-mapbase/256*256>135
getpair ld      b, (iy-256+mapbase-mapbase/256*256)
      ELSE
getpair ld      b, (iy-112+mapbase-(mapbase+16)/256*256)
      ENDIF
        call    getbits
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

getbits ld      de, 0
gbcont  dec     b
        ret     m
        call    getbit
        rl      e
        rl      d
        jr      gbcont

getbit  add     a, a
        ret     nz
        ld      a, (hl)
        dec     hl
        adc     a, a
        ret