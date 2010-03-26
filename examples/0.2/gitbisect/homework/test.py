#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Test infrastructure main entry point.

Running this file kicks of the entire set of test cases included in the TESTS
folder. Tests in that folder may also be run individually from within that
folder or from within this working directory. Individual tests need only to
import the unittest module, and to include a small amount of python boilerplate
which enables these test cases to play nicely with the main suite.
"""
# Copyright (C) 2009-2010  James Shubin, McGill University
# Written for McGill University by James Shubin <purpleidea@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import os
import sys
import unittest

# location of the individual unit tests
TESTS = 'tests'
path = __file__
# is the tests file is run within a deeper directory, fix it.
while path.startswith('../'):
	path = path[len('../'):]
	os.chdir('../')

# `magic' filename ending we require for test case inclusion
MAGIC = 'TestCase.py'

sys.path.append(TESTS)

suites = []

# loop through a list of valid strings we can pass to the import function
for x in [x[0:-len('.py')] for x in os.listdir(TESTS) if x.endswith(MAGIC)]:
	# import from the <TESTS> sub-package
	temp = __import__(TESTS + '.' + x)
	# since we're in a subpackage, we need to add name for: temp.<name>.suite
	suites.append(getattr(temp, x).suite)

# show the set of suites as another suite
suite = unittest.TestSuite(suites)

# if this file is run individually, then run the test suite
if __name__ == '__main__':
	result = unittest.TextTestRunner(verbosity=2).run(suite)
	if result.wasSuccessful(): sys.exit(0)
	else: sys.exit(1)

