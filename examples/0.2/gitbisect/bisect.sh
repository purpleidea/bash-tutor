#!/bin/bash

# do this so that .pyc doesn't cache false results.
if [ -e src/fibonacci.pyc ]; then
	rm src/fibonacci.pyc
fi
exit `python test.py`

