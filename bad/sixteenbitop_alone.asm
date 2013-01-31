    ld hl, de
    ld hl, bc
    ld bc, de
    ld bc, hl
    ld de, bc
    ld de, hl


    add hl, ix
    add ix, iy

    ld iyl, (ix+0)
    ld iyh, (ix+0)
