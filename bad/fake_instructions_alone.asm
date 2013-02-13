    pop sp
    push sp
    ld $1000,$10
    ld ($1000),$10
    ld ($1000),($10)
    ld $1000,($10)

    ld (hl),($10)
    ld (hl),($1000)
    ld $10,(hl)
    ld ($10),(hl)
    ld $10,(ix + 0)
    ld ($10),(ix + 0)
    ld (ix + 0),($10)
    ld $10,(iy + 0)
    ld ($10),(iy + 0)
    
    ld b,(bc)
    ld c,(bc)
    ld d,(bc)
    ld e,(bc)
    ld h,(bc)
    ld l,(bc)
    ld f,(bc)
    ld r,(bc)
    ld i,(bc)

    ld b,(de)
    ld c,(de)
    ld d,(de)
    ld e,(de)
    ld h,(de)
    ld l,(de)
    ld f,(de)
    ld r,(de)
    ld i,(de)

    ld b,(sp)
    ld c,(sp)
    ld d,(sp)
    ld e,(sp)
    ld h,(sp)
    ld l,(sp)
    ld f,(sp)
    ld r,(sp)
    ld i,(sp)

    ld r,(hl)
    ld i,(hl)

    ld sp,bc
    ld sp,de
    ld bc,sp
    ld de,sp
    ld hl,sp
    ld ix,sp
    ld iy,sp

    and f
    and (bc)
    and (de)
    and (sp)
    and ($12)
    and ($0012)
    and ($1234)

    cp f
    cp (bc)
    cp (de)
    cp (sp)
    cp ($1234)

    or f
    or (bc)
    or (de)
    or (sp)
    or ($1234)
    
    xor f
    xor (bc)
    xor (de)
    xor (sp)
    xor ($1234)

    ex bc,bc
    ex bc,de
    ex bc,hl
    ex bc,sp
    ex de,bc
    ex de,de
    ex de,sp
    ex hl,bc
    ex hl,de
    ex hl,hl
    ex hl,sp
    ex hl,(sp)
    ex (hl),sp
    ex (hl),sp
    ex ix,(sp)
    ex (ix),sp
    ex (ix),sp
    ex iy,(sp)
    ex (iy),sp
    ex (iy),sp
    
    IM 3
