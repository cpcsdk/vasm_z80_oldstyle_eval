#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Build some ground truth files
"""

def write_bytes(f, bytes):
    for b in bytes:
        f.write(chr(b))

def write_string(f, string):
    f.write(string)

def good_delimited():
    f = open('good/delimited.bin', 'w')

    write_bytes(f, [10, 20, 30, 40])
    write_string(f, 'hello: worldhelloworld')
    write_bytes(f, [0, 0])

    f.close()


# code
if __name__ == '__main__':
    good_delimited()


