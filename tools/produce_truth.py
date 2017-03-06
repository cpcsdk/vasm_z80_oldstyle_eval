#!/usr/bin/env python
# -*- coding: utf-8 -*-



def save(fname, data):
    print "Save ", data, " in ", fname
    with open(fname, 'wb') as f:
        for byte in data:
            f.write(chr(byte))

def produce_good_named():
    res = []
    for i in range(50):
        res.append(i)

    for Y in range(10):
        for X in range(20):
            res.append(X)
            res.append(Y)

    save("good/repeat_named.bin", res)


def main():
    produce_good_named()


if __name__ == "__main__":
    produce_good_named()
