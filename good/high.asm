

VAR1 equ 0x1234
VAR2 equ VAR1/256
VAR3 equ >VAR1
VAR4 equ VAR3*256

    assert VAR2 == 0x12
    assert VAR3 == 0x12
    assert VAR4 == 0x1200
