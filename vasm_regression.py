#!/bin/python

"""
Launch a specific test on all versions

TODO add a binary search stuff to find regression
"""

import sys
import os

VERSIONS = [
'test_version_1.7g',
'test_version_1.7f',
'test_version_1.7e',
'test_version_1.7d',
'test_version_1.7c',
'test_version_1.7b',
]


RESULT = ""


for version in VERSIONS:
	if len(sys.argv) == 2:
		PATTERN = sys.argv[1]
	else:
		PATTERN = ""

	cmd_line = "VASM_PATTERN=%s make %s" % (PATTERN, version)
	os.system(cmd_line)

	RESULT += version +"\n"
	with open("current_state.txt") as f:
		RESULT += "\t".join(f.readlines())


print RESULT

