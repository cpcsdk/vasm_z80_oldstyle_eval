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
    ld ixh, (ix+0)
    ld ixh, (ix+0)

    ld iyl, (iy+0)
    ld iyh, (iy+0)
    ld ixh, (iy+0)
    ld ixh, (iy+0)
