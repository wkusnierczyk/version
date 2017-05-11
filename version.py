#!/usr/bin/env python

import sys

if __name__ == '__main__':
    try:
        version, part = sys.argv[1:3]
        parts = [int(v) for v in version.split('.')]
        parts['major.minor.build'.split('.').index(part)] += 1
        print('.'.join(str(v) for v in parts))
    except:
        sys.exit(1)
