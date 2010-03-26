#!/usr/bin/python

memo = {0:0, 1:2}	# bug
def fib(n):
	"""Fibonacci memoize."""
	if not n in memo:
		memo[n] = fib(n-1) + fib(n-2)
	return memo[n]

# call it nicely from command line
if __name__ == '__main__':
	import sys
	try:
		print fib(int(sys.argv[1]))
		sys.exit(0)
	except:
		sys.exit(1)

