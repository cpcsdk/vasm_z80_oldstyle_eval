; Check the good managment of the variables

    ld a, X
    assert X == ADDRESS

    ; Nested repeats
    repeat 10, Y
        repeat 20, X
            db X, Y
        endrepeat
    endrepeat

    ; Nested repeats
    repeat 10, Y
        repeat 20, X
            db X, Y
        endrepeat
    endrepeat

ADDRESS
X db 1
Y


    assert X == ADDRESS



