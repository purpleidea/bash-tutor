#!/usr/bin/python

def fib(n):
	"""iterative fibonacci."""
	a, b = 0, 1
	for i in range(n):
		a, b = b, a + b
	return a


# call it nicely from command line
if __name__ == '__main__':
	import sys
	try:
		print fib(int(sys.argv[1]))
		sys.exit(0)
	except:
		sys.exit(1)

