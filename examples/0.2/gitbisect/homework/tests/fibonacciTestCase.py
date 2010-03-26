#!/usr/bin/python
# -*- coding: utf-8 -*-
"""tests.fibonacciTestCase

Model test case for adding tests into the automatic suite.
To add a test case:
	3) modify methods in the class, building your test case
	4) edit this docstring to show the correct name and short description
	5) test by running this file. will automatically run with main suite
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

# do some path magic so this can run anyhow from anywhere
TESTNAME = os.path.splitext(os.path.basename(os.path.normpath(__file__)))[0]
BASEPATH = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '../'))
sys.path.append(os.path.join(BASEPATH, 'src/'))
__all__ = [TESTNAME]


class fibonacciTestCase(unittest.TestCase):
	"""see: http://www.research.att.com/~njas/sequences/A000045"""

	def setUp(self):
		"""setup code that has to occur for each test*()"""
		import fibonacci
		self.f = fibonacci

	def testSimple1(self):
		"""By definition."""
		self.assertEqual(self.f.fib(0), 0)
		self.assertEqual(self.f.fib(1), 1)

	def testSimple2(self):
		"""First five generated numbers."""
		self.assertEqual(self.f.fib(2), 1)
		self.assertEqual(self.f.fib(3), 2)
		self.assertEqual(self.f.fib(4), 3)
		self.assertEqual(self.f.fib(5), 5)
		self.assertEqual(self.f.fib(6), 8)

	def testSimple3(self):
		"""Randoms from OEIS database."""
		self.assertEqual(self.f.fib(7), 13)
		self.assertEqual(self.f.fib(13), 233)

	def testInverse(self):
		"""test with inverse function for n < 70."""
		import math
		def fibinv(f):
			"""works with n < 70."""
			phi = (1 + 5**0.5) / 2
			if f < 2: return f
			return int(round(math.log(f * 5**0.5) / math.log(phi)))

		# start with F3 because F2 and F1 cause it to be ambiguous
		# this gets slower and slower with a recursive function.
		for n in range(3, 30):
			self.assertEqual(fibinv(self.f.fib(n)), n)


# group all tests into a suite
suite = unittest.TestLoader().loadTestsFromTestCase(globals()[TESTNAME])

# if this file is run individually, then run these test cases
if __name__ == '__main__':
	unittest.main()
