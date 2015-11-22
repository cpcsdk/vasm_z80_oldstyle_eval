#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Automatic evaluation of vasm.

Verifies that vasm fails to assemble wrong instructions.
TODO allow to verify if the generated output is correct
BUG does not work on windows
"""

# imports
import glob
import sys
import os
import subprocess

# code

errors = []
COMMENT_CHAR = ';'

ERROR_FAILED = 1
ERROR_SUCCESS = 0
ERROR_NOT_EQUAL = 2

fnamed = '/tmp/vasm.asm' #TODO use a real temporary file

def verify_equality(vasm, fname):
    """Verify the equality of each couple.
    Each line is supposed to be assembled correctly.
    """

    previous_binary = previous_line = None
    successes = []

    f = open(fname)
    for current_line in f.readlines():
        # skip empty lines and comments
        striped = current_line.strip()
        if (not len(striped)) or striped[0] == COMMENT_CHAR:
            continue

        # Create the file
        d = open(fnamed, 'w') #TODO use temporary generated file
        d.write(current_line)
        d.close()

        # launch line compilation
        if not __assemble(vasm, fnamed, True, current_line[:-1]):
            raise Exception("WRONG test file" + fname + " / not assembling")

        # Read the binary
        with open('a.out', 'r') as a:
            current_binary = a.read(-1)

        # verify if we must compare
        if previous_line is None:
            previous_line = current_line
            previous_binary = current_binary
        else:
            if previous_binary != current_binary:
                sys.stdout.write('*')
                repres = "%s => %s\nand\n%s => %s" % (previous_line.strip(),
                                                ",".join("0x%.2X"%ord(_) for _ in previous_binary),
                                                current_line.strip(),
                                                ",".join("0x%.2X"%ord(_) for _ in current_binary),
                                               )
                errors.append( (ERROR_NOT_EQUAL, fname, repres) )
                successes.append(0)
            else:
                sys.stdout.write('o')
                successes.append(1)
            previous_binary = previous_line = None


    f.close()
    return successes

def assemble(vasm, fname, success=True):
    """Launch the assembling of the required file"""
    global errors

    if '_alone' not in fname:
        return [__assemble(vasm, fname, success)]
    else:
        successes = []
        f = open(fname)
        for line in f.readlines():
            # skip empty lines
            if (not len(line.strip())) or line.strip()[0] == COMMENT_CHAR:
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

    expected_file = fname[:-3]+"bin"
    if os.path.exists(expected_file):
        sys.stdout.write('[bin] ')
    if (success and 0==process.returncode) or (not success and 0!=process.returncode):
        # If possible verify if binary matches
        if success and os.path.exists(expected_file):
           a = open('a.out', 'r')
           current_binary = a.read(-1)
           a.close()
           b = open(expected_file)
           expected_binary = b.read(-1)
           b.close()

           if current_binary != expected_binary:
                sys.stdout.write('*')
                error_message = "Binary does not match expected in %s" % expected_file 
                error_message += " \n Expected: " + ",".join("0x%0.2X" % ord(_) for _ in expected_binary)
                error_message += " \n Obtained: " + ",".join("0x%0.2X" % ord(_) for _ in current_binary)
                errors.append( (success, fname, error_message) )
                return 0

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

    if len(sys.argv) == 2:
        vasm = sys.argv[1]
    else:
        if 'VASM' not in os.environ:
            sys.stderr.write("[ERROR] VASM variable not defined\n")
            exit(-1)
        vasm = os.environ['VASM']

    if not os.path.exists(vasm):
        sys.stderr.write("[ERROR] vasm executable not found: %s.\n" % vasm)
        exit(-1)

    successes = []

    good_files = sorted(glob.glob('./good/*.asm'))
    bad_files = sorted(glob.glob('./bad/*.asm'))
    equiv_files = sorted(glob.glob('./equiv/*.asm'))

    sys.stdout.write('Launch tests on:')
    for fname in good_files:
        sys.stdout.write('\n[G] %s '% fname)
        successes.extend(assemble(vasm, fname, True))

    for fname in bad_files:
        sys.stdout.write('\n[B] %s '% fname)
        successes.extend(assemble(vasm, fname, False))

    for fname in equiv_files:
        sys.stdout.write('\n[E] %s '% fname)
        successes.extend(verify_equality(vasm, fname))

    sys.stdout.write('\n\nSummary: %d/%d successes of tests.\n\nList of errors:' % (sum(successes), len(successes)))
    for error in errors:
        print '\n>> Source:',error[1]
        if error[0] == ERROR_FAILED:
            print '\tFailed instead of succeeded'
            print '\tMessage:',error[2]
        elif error[0] == ERROR_SUCCESS:
            print '\tSucceeded instead of failed'
        else:
            print '\tInstruction assembled differently'
            print '\tMessage:\n', error[2]


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

