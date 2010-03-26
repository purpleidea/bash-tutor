#!/usr/bin/python

def fib(n):
	"""recursive fibonacci."""
	if n == 0:
		return 0
	elif n == 1:
		return 1
	else:
		return fib(n-1) + fib(n-2)

# call it nicely from command line
if __name__ == '__main__':
	import sys
	try:
		print fib(int(sys.argv[1]))
		sys.exit(0)
	except:
		sys.exit(1)

