; aPPack decompressor 
; original source by dwedit
; very slightly adapted by utopian
; optimized by Metalbrain

;hl = source
;de = dest

depack:         ld    a,128
apbranch1:      ldi
aploop2:        ld    ixh,1
aploop:	        call  ap_getbit
                jr    nc,apbranch1
                call  ap_getbit
                jr    nc,apbranch2
                call  ap_getbit
                jr    nc,apbranch3

                ld    bc,16		;get an offset
apget4bits:     call  ap_getbit
                rl    c
                jr    nc,apget4bits
                jr    nz,apbranch4
                ex    de,hl
                ld    (hl),b		;write a 0
                ex    de,hl
                inc   de
                jp    aploop2
apbranch4:      ex    af,af'
                ex    de,hl 		;write a previous byte (1-15 away from dest)
                sbc   hl,bc
                ld    a,(hl)
                add   hl,bc
                ld    (hl),a
                ex    af,af'
                ex    de,hl
                inc   de
                jp    aploop2

apbranch3:      ld    c,(hl)		;use 7 bit offset, length = 2 or 3
                inc   hl
                ex    af,af'
                rr    c
                ret   z		;if a zero is found here, it's EOF
                ld    a,2
                ld    b,0
                adc   a,b
                push  hl
                ld    iyh,b
                ld    iyl,c
                ld    h,d
                ld    l,e
                sbc   hl,bc
                ld    c,a
                ex    af,af'
                ldir
                pop   hl
                ld    ixh,b
                jp    aploop
apbranch2:      call  ap_getgamma	;use a gamma code * 256 for offset, another gamma code for length
                dec   c
                ex    af,af'
                ld    a,c
                sub   ixh
                jr    z,ap_r0_gamma
                dec   a
                ;bc=bc*256+(hl), lazy 16bit way
                ld    b,a
                ld    c,(hl)
                inc   hl
                ld    iyh,b
                ld    iyl,c

                push  bc

                call  ap_getgamma2

                ex    (sp),hl		;bc = len, hl=offs
                push  de
                ex    de,hl

                ex    af,af'
                ld    a,4
                cp    d
                jr    nc,apskip2
                inc   bc
                or    a
apskip2:        ld    hl,127
                sbc   hl,de
                jr    c,apskip3
                inc   bc
                inc   bc
apskip3:        pop   hl		;bc = len, de = offs, hl=junk
                push  hl
                or    a
                sbc   hl,de
                ex    af,af'
                pop   de		;hl=dest-offs, bc=len, de = dest
                ldir
                pop   hl
                ld    ixh,b
                jp    aploop

ap_r0_gamma:	call  ap_getgamma2	;and a new gamma code for length
                push  hl
                push  de
                ex    de,hl

                ld    d,iyh
                ld    e,iyl
                sbc   hl,de
                pop   de		;hl=dest-offs, bc=len, de = dest
                ldir
                pop   hl
                ld    ixh,b
                jp    aploop

ap_getgamma2:   ex    af,af'
ap_getgamma:    ld    bc,1
ap_getgammaloop:call  ap_getbit
                rl    c
                rl    b
                call  ap_getbit
                jr    c,ap_getgammaloop
                ret

ap_getbit:      add   a,a
                ret   nz
                ld    a,(hl)
                inc   hl
                rla
                ret

