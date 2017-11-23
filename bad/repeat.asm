 
    org 0x100

Y

    assert Y == 0x100

 ; Should fail because Y is used before we do not know which value should be used
    repeat 10, Y
        repeat 20, X
            db X, Y
        endrepeat
    endrepeat


    assert Y == 0x100
