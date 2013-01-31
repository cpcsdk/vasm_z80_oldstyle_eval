#vasm_z80_oldstyle_eval

The aim of this project is to automatically evaluate
vasm assembler compiled with z80 support and oldstyle syntax
in order to test regressions.
z80 support is a bit buggy atm, so it is important to know where it fails

 - Good folder must contains asm source files supposed to be correctly assembled
 - Bad folder must contains asm source files supposed to raise errors

If the name of one file contains '_alone', the file is assembled line per line



Feel free to add extra test cases, and to patch vasm (http://sun.hasenbraten.de/vasm/)
