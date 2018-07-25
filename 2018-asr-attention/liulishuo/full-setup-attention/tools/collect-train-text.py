#!/usr/bin/env python

import os, sys

if __name__ == "__main__":
	text_file = sys.argv[1]
	if not os.path.exists(text_file):
		raise FileExistsError('No file: %s' % text_file)

	with open(text_file) as f:
		for line in f:
			a = line.split()
			print(' '.join(a[1:]))
