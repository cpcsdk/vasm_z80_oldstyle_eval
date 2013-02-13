; Must be assembled in the same way
    ld bc, (10+2)*3
    ld bc, (10+2)*3

; Must be assembled in the same way
    ld bc, (10+2)*3
    ld bc, 3*(10+2)

; Must be assembled in the same way
    ld hl, 23*4 - 6*5 + 100
    ld hl, (23*4) - (6*5) + 100

; Must be assembled in the same way
    ld hl, 23*4 - 6*5 + 100
    ld hl, (23*4) - 6*5 + 100

; Must be assembled in the same way
    ld hl, 23*4 - 6*5 + 100
    ld hl, 23*4 - (6*5) + 100 

; Must be assembled in the same way
    ld hl, 23*4 - 6*5 + 100
    ld hl, 23*4 - 6*5 + (100) 

; Must be assembled in the same way
    ld hl, 23*4 - 6*5 + 100 + 64 * 256
    ld hl, 23*4 - 6*5 + (100 + 64 * 256)

; Must be assembled in the same way
    ld hl, 23*4 - 6*5 + 100 + 64 * 256
    ld hl, (23*4 - 6*5) + (100 + 64 * 256)

; Must be assembled in the same way
    ld bc,(>$BC00 + 1) * 256 + (>$BD00 + 1) ; (>CRTC_SELECT + 1) * 256 + (>CRTC_WRITE + 1)
    ld bc,$BDBE

; Must be assembled in the same way
    ld bc,(($BC00 / 256) + 1) * 256 + (($BD00 / 256) + 1)
    ld bc,$BDBE
