    ld bc, bc
    ld bc, de
    ld bc, hl
    ld de, bc
    ld de, de
    ld de, hl
    ld hl, bc
    ld hl, de
    ld hl, hl

    ld ix, bc
    ld ix, de
    ld ix, hl
    ld bc, ix
    ld de, ix
    ld hl, ix

    ld iy, bc
    ld iy, de
    ld iy, hl
    ld bc, iy
    ld de, iy
    ld hl, iy
    
    ld ix, ix
    ld ix, iy
    ld iy, iy
    ld iy, ix
    
    add hl, ix
    add ix, hl
    add ix, iy
    add hl, iy
    add iy, hl
    add iy, ix

    adc hl, ix
    adc ix, hl
    adc ix, ix
    adc ix, iy
    adc hl, iy
    adc iy, hl
    adc iy, iy
    adc iy, ix

    sbc hl, ix
    sbc ix, hl
    sbc ix, ix
    sbc ix, iy
    sbc hl, iy
    sbc iy, hl
    sbc iy, iy
    sbc iy, ix
