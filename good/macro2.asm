    org 0x100

  ;;
  ; Extract of a macro in a real project which does not compile anymore with current vasm version
  ;
  macro VSCROLL_BUILD_DATA_LINE, line

    ; ... code removed ...

        jp c, \@_not_shifted
\@_shifted
    ; ... code removed ...
        jr \@_next2
\@_not_shifted
    ; ... code removed ...
        jr \@_next2
\@_next2

 ; ... code removed ....

      endm



    VSCROLL_BUILD_DATA_LINE 0
    VSCROLL_BUILD_DATA_LINE 1

