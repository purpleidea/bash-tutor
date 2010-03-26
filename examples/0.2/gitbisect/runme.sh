#!/usr/bin/bash-tutor
# this file should get executed by bash-tutor!
# don't run this in any random directory! these commands actually run!
# you might end up chomping or deleting existing files.

# clean up any previous execution if it exists
if [ -d fib/ ]; then rm -rf fib/; fi

echo 'This is an example of git and unit testing, featuring git-bisect in bash-tutor.'

mkdir fib
cd fib
git init

 # pull in some premade files
cp ../homework/test.py .
mkdir tests
cp ../homework/tests/__init__.py tests/
git add test.py
git add tests
git commit -m 'added basic test infrastructure to new fibonnacci repository.'

 # notice the typo ?
git commit --amend -m 'added basic test infrastructure to new fibonacci repository.'
cp ../homework/tests/fibonacciTestCase.py tests/
git add tests/fibonacciTestCase.py
git commit -m 'added test case for fibonacci function.'
./test.py # it should fail (no function exists)

mkdir src # this where we should put our code
cp ../homework/src/fibonacci_recursive.py src/fibonacci.py
./test.py # works ?
git add src/fibonacci.py
git commit -m 'added working fib function.'
git tag iampass # for later
 # make it better, add argv boilerplate
cp ../homework/src/fibonacci_recursive2.py src/fibonacci.py
git diff
git commit -am 'fibonacci with boilerplate to run it easily.' # note: -am
cp ../homework/README .
cp ../homework/tests/pep8* tests/
git add tests/pep8*
git commit -m 'Added PEP8 tests'
git add README
git commit -m 'Added README file'
git status # ou we see .pyc files, don't we ?
cp ../homework/.gitignore .
cat .gitignore
git add .gitignore
git commit -m 'ignore .pyc junk.'
git status # all clean now

cp ../homework/src/fibonacci_iterative.py src/fibonacci.py
git commit -am 'iterative fib is faster than recursive.'
python src/fibonacci.py 100
cp ../homework/src/fibonacci_memoize.py src/fibonacci.py
git commit -am 'memoize fib is pretty cool.'
python src/fibonacci.py 100
cp ../homework/src/fibonacci_memoize-xxx.py src/fibonacci.py
git commit -am 'small fix.'
git tag failxxx # for later

cp ../homework/tests/fibonacciTestCase2.py tests/fibonacciTestCase.py
git diff
git add tests/fibonacciTestCase.py
git commit -m 'Enlarge the scope of our test case to n < 70'

cp ../homework/AUTHORS .
cp ../homework/TODO .
cp ../homework/VERSION .

git add AUTHORS
git add TODO
git add VERSION

git commit -m 'added text files for package completeness.'
# since it dissapears with checkouts...
#cp ../homework/bisect.sh .
#git add bisect.sh
#git commit -m 'add bisection helper script.'
git log | head -n 20 # keep it short
python src/fibonacci.py 13 # whoa !
./test.py
git tag iamfail # tag to help us
 # git-bisect: start, good, bad, skip, reset, log, run
git bisect start
git bisect good iampass
git bisect bad iamfail
git bisect run bash ../bisect.sh # it has to be in early or outside the repo
git blame src/fibonacci.py
git bisect reset
git revert --no-edit failxxx
if [ -e src/fibonacci.pyc ]; then rm src/fibonacci.pyc; fi
echo 'Done!'

