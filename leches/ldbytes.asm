
        define  consta  $69
ultra   ld      ix, ramab1
        exx                     ; salvo de, en caso de volver al cargador estandar y para hacer luego el checksum
        ld      c, 0
ultra1  defb    $26
ultra2  jp      nz, $053f       ; return if at any time space is pressed.
ultra3  ld      b, 0
        call    $05ed           ; leo la duracion de un pulso (positivo o negativo)
        jr      nc, ultra2      ; si el pulso es muy largo retorno a bucle
        ld      a, b
        add     a, -16          ; si el contador esta entre 10 y 16 es el tono guia
        rr      h               ; de las ultracargas, si los ultimos 8 pulsos
        jr      z, ultra1
        add     a, 6            ; son de tono guia h debe valer ff
        jr      c, ultra3
        ld      a, $d8          ; a' tiene que valer esto para entrar en raudo
        ex      af, af'
        dec     h
        jr      nz, ultra1      ; si detecto sincronismo sin 8 pulsos de tono guia retorno a bucle
        call    $05ed           ; leo pulso negativo de sincronismo
        ld      l, 1
ultra4  ld      b, 0            ; 16 bytes
        call    $05ed           ; esta rutina lee 2 pulsos e inicializa el contador de pulsos
        call    $05ed
        ld      a, b
        cp      12
        adc     hl, hl
        jr      nc, ultra4
        call    $05ed
        call    $05ed
        call    $05ed
        call    $05ed
        call    $05ed
        ld      a, l
        xor     h
        exx
        ld      c, a            ; guardo checksum en c'
        push    hl              ; pongo direccion de comienzo en pila
        exx
        pop     de              ; recupero en de la direccion de comienzo del bloque
        dec     de
        ld      h, table>>8
        ld      a, table1 & 255
        inc     c               ; pongo en flag z el signo del pulso
        ld      c, $fe          ; este valor es el que necesita b para entrar en raudo
        jr      nz, ultra6
        ld      ixl, ramaa1 & 255
ultra5  in      f, (c)
        jp      pe, ultra5
        jr      ramaa2          ; salto a raudo segun el signo del pulso en flag z

        .39     defb    $00

ultra6  in      f, (c)
        jp      po, ultra6
        jr      ramab2

ramaa   nop                     ;4
        out     (c), b          ;12
        inc     hl              ;6
        xor     b               ;4
        add     a, a            ;4
        add     a, a            ;4
        call    lee1            ;17
ramaa1  ex      af, af'         ;7+4      64
        ld      a, r            ;9
ramaa2  ld      l, a            ;4
        ld      b, (hl)         ;7
        ld      a, consta       ;7
        ld      r, a            ;9
        call    lee2            ;17
        ex      af, af'         ;7+4      72/72
        jp      nc, ramaa       ;10
        xor     b               ;4
        xor     $9c             ;7
        inc     de              ;6
        ld      (de), a         ;7
        ld      a, $dc          ;7
        push    ix              ;15
        ret     c               ;5
lee1    defb    $ed, $70, $e0
        .9      defb    $6e, $ed, $70, $e0
        jr      ultra9

ramab   nop                     ;4
        out     (c), b          ;12
        inc     hl              ;6
        xor     b               ;4
        add     a, a            ;4
        add     a, a            ;4
        call    lee2            ;17
ramab1  ex      af, af'         ;7+4      64
        ld      a, r            ;9
ramab2  ld      l, a            ;4
        ld      b, (hl)         ;7
        ld      a, consta       ;7
        ld      r, a            ;9
        call    lee1            ;17
        ex      af, af'         ;7+4      72/72
        jp      nc, ramab       ;10
        xor     b               ;4
        xor     $9c             ;7
        inc     de              ;6
        ld      (de), a         ;7
        ld      a, $dc          ;7
        push    ix              ;15
        ret     c               ;5
lee2    defb    $ed, $70, $e8
        .9      defb    $6e, $ed, $70, $e8

ultra9  pop     hl
        exx                     ; ya se ha acabado la ultracarga (raudo)
        dec     de
        ld      b, e
        inc     b
        inc     d
ultraa  xor     (hl)
        inc     hl
        djnz    ultraa
        dec     d
        jr      nz, ultraa      ; con JP ahorro algunos ciclos
        xor     c
        ret     z               ; si no coincide el checksum salgo con carry desactivado

        ei
        rst     $08             ; error-1
        defb    $1a             ; error report: tape loading error
