#!/usr/bin/python

def fib(n):
	"""recursive fibonacci."""
	if n == 0:
		return 0
	elif n == 1:
		return 1
	else:
		return fib(n-1) + fib(n-2)

