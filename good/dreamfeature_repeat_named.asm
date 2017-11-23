

    org 0

    ; standard repeat
    repeat 50 , "variable"
        db variable
    endrepeat


    ; Nested repeats
    repeat 10, Y
        repeat 20, X
            db X, Y
        endrepeat
    endrepeat



