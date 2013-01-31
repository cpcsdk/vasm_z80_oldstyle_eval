#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Automatic evaluation of vasm.

Verifies that vasm fails to assemble wrong instructions.
TODO allow to verify if the generated output is correct
"""

# imports
import glob
import sys
import subprocess

# code

errors = []


def assemble(vasm, fname, success=True):
    """Launch the assembling of the required file"""
    global errors

    if '_alone' not in fname:
        return [__assemble(vasm, fname, success)]
    else:
        successes = []
        f = open(fname)
        fnamed = '/tmp/vasm.asm'
        for line in f.readlines():
            # skip empty lines
            if not len(line.strip()):
                continue
            # create file
            d = open(fnamed, 'w') #TODO use temporary generated file
            d.write(line)
            d.close()

            # launch line compilation
            successes.append(__assemble(vasm, fnamed, success, line[:-1]))
        f.close()
        return successes

def __assemble(vasm, fname, success=True, content=None):
    process = subprocess.Popen([vasm, '-Fbin', fname], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

    if (success and 0==process.returncode) or (not success and 0!=process.returncode):
        sys.stdout.write('.')
        return 1
    else:
        sys.stdout.write('*')
        if content is None:
            errors.append( (success, fname, stderr) )
        else:
            errors.append( (success, content, stderr) )
        return 0

def main():
    """Launch all the tests"""
    
    try:
        vasm = sys.argv[1]
    except:
        vasm = '../vasm/vasmz80_oldstyle'

    successes = []

    good_files = sorted(glob.glob('./good/*.asm'))
    bad_files = sorted(glob.glob('./bad/*.asm'))

    for fname in good_files:
        successes.extend(assemble(vasm, fname, True))

    for fname in bad_files:
        successes.extend(assemble(vasm, fname, False))

    print
    print '%d/%d successes of tests.' % (sum(successes), len(successes))
    for error in errors:
        print '\nSource:',error[1]
        if error[0]:
            print 'Failed instead of succeeded'
            print 'Message:',error[2] 
        else:
            print 'Succeeded instead of failed'
                                    

if __name__ == '__main__':
    main()


# metadata
__author__ = 'Romain Giot'
__copyright__ = 'Copyright 2013'
__credits__ = ['Romain Giot']
__licence__ = 'GPL'
__version__ = '0.1'
__maintainer__ = 'Romain Giot'
__email__ = 'giot.romain@gmail.com'
__status__ = 'Prototype'

