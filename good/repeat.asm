

WIDTH set 16
HEIGHT set 16

Y set 0
    rept HEIGHT
X set 0
        repeat WIDTH
            db X*Y
        endrepeat
    endr
    
