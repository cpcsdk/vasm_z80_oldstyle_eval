
    org 0x100

    macro MACRO1
        ld a, 10
    endm

    macro macro2
        jp $
    endm

    MACRO1
    macro2
