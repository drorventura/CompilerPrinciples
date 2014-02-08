from compiler import *
from subprocess import *
from datetime import *
from argparse import *

parser = ArgumentParser()

subparsers = parser.add_subparsers(title='subcommands', description='valid subcommands', help='additional help')
parser.add_argument("-c", "--code", help="Compile this code directly", type=str, default="")

all_parser = subparsers.add_parser('all', help='Run all tests')
skip_parser = subparsers.add_parser('skip', help='Skip sections of tests or specific tests')
only_parser = subparsers.add_parser('only', help='Run specific sections of tests or specific tests')

skip_parser.add_argument("-s", "--skip-sections", help="Skip these tests sections", type=int, nargs='*', default=[])
skip_parser.add_argument("-t", "--skip-tests", help="Skip these (specific) tests", type=int, nargs='*', default=[])

only_parser.add_argument("-s", "--only-sections", help="Only run these test sections", type=int, nargs='*', default=[])
only_parser.add_argument("-t", "--only-tests", help="Only run these tests", type=int, nargs='*', default=[])

args = parser.parse_args()

tmpSourceFile = 'tester_tmp.scm'
srcNoExt = tmpSourceFile.replace('.scm', '')
tmpTargetFile = 'tester_tmp.asm'

tests = []
tests.append(('Offical tests',))
tests.append(("""
#t
#f
'()
""", """#t
#f
()""", 'file 1'))
tests.append(("""
(if #f #f #t)
(if #t #t #f)
""", """#t
#t""", 'file 2'))
tests.append(("""
(or)
(or #t)
(or #f)
(or #f #t)
(or #f #f #f #f #f #t #f)
(and)
(and #t)
(and #t #t)
(and #t #f)
(and #f #t)
(and #t #t #t #t #t #t #t #f)
""", """#f
#t
#f
#t
#t
#t
#t
#t
#f
#f
#f""", 'file 3'))
tests.append((r"""
1
2
3
#\a
#\A
#\newline
#\"
#\\
3/4
4/5
6/7
'(1 2 3)
'(1 . (2 . (3 . ())))
'((1 2) (3 4))
'1234
'#\a
""", r"""1
2
3
#\a
#\A
#\newline
#\"
#\\
3/4
4/5
6/7
(1 . (2 . (3 . ())))
(1 . (2 . (3 . ())))
((1 . (2 . ())) . ((3 . (4 . ())) . ()))
1234
#\a""", 'file 4'))
tests.append(("""
(let ((x #f))
  (let ()
    x))

(let ((x #f) (y #t))
  (let ((x #f))
    (let ((x #f) (z #f) (t #f))
      (let ((x #f) (t #f))
  y))))

((((lambda (x)
     (lambda (y)
       y))
   (lambda (p)
     (p (lambda (x y)
    (lambda (p)
      (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))

((((lambda (x)
     (lambda (y)
       (x y)))
   (lambda (p)
     (p (lambda (x y)
    (lambda (p)
      (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))

((((lambda (x)
     (lambda (y)
       (x (x y))))
   (lambda (p)
     (p (lambda (x y)
    (lambda (p)
      (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))

(((((lambda (x) ((x x) (x x)))
    (lambda (x)
      (lambda (y)
  (x (x y)))))
   (lambda (p)
     (p (lambda (x y)
    (lambda (p)
      (p y x))))))
  (lambda (z) (z #t #f)))
 (lambda (x y) x))
""", """#f
#t
#t
#f
#t
#t""", 'file 5'))
tests.append(("""
(let ()
  ((lambda s
     (let ()
       ((lambda s s) s s s)))
   #t))
""", "((#t . ()) . ((#t . ()) . ((#t . ()) . ())))", 'file 6'))
tests.append(("""
(define test
  (let ((p1 (lambda (x1 x2 x3 x4 x5 x6 x7 x8 x9 x10)
        (lambda (z)
    (z x2 x3 x4 x5 x6 x7 x8 x9 x10 x1))))
  (s '(a b c d e f g h i j)))
    (lambda ()
      (equal? (((((((((((apply p1 s) p1) p1) p1) p1) p1) p1) p1) p1) p1)
         list)
        s))))
""", "", 'file 7'))
tests.append(("""
(((((lambda (x) (x (x x)))
    (lambda (x)
      (lambda (y)
  (x (x y)))))
   (lambda (p)
     (p (lambda (x)
    (lambda (y)
      (lambda (z)
        ((z y) x)))))))
  (lambda (x)
    ((x #t) #f)))
 (lambda (x)
   (lambda (y)
     x)))
""", "#t", 'file 8'))
tests.append((r"""
(boolean? #t)
(boolean? #f)
(boolean? 1234)
(boolean? 'a)
(symbol? 'b)
(procedure? procedure?)
(eq? (car '(a b c)) 'a)
(= (car (cons 1 2)) 1)
(integer? 1234)
(char? #\a)
(null? '())
(string? "abc")
(symbol? 'lambda)
(vector? '#(1 2 3))
(vector? 1234)
(string? '#(a b c))
(string? 1234)
(= 3 (vector-length '#(a #t ())))
(pair? '(a . b))
(pair? '())
(zero? 0)
(zero? 234)
(+ 2 2/3)
(* 1/3 3/5 5/7)
(+ 1/2 1/3)
""", """#t
#t
#f
#f
#t
#t
#t
#t
#t
#t
#t
#t
#t
#t
#f
#f
#f
#t
#t
#f
#t
#f
8/3
1/7
5/6""", 'file 9'))
tests.append(("""
(define with (lambda (s f) (apply f s)))

(define crazy-ack
  (letrec ((ack3
      (lambda (a b c)
        (cond
         ((and (zero? a) (zero? b)) (+ c 1))
         ((and (zero? a) (zero? c)) (ack-x 0 (- b 1) 1))
         ((zero? a) (ack-z 0 (- b 1) (ack-y 0 b (- c 1))))
         ((and (zero? b) (zero? c)) (ack-x (- a 1) 1 0))
         ((zero? b) (ack-z (- a 1) 1 (ack-y a 0 (- c 1))))
         ((zero? c) (ack-x (- a 1) b (ack-y a (- b 1) 1)))
         (else (ack-z (- a 1) b (ack-y a (- b 1) (ack-x a b (- c 1))))))))
     (ack-x
      (lambda (a . bcs)
        (with bcs
    (lambda (b c)
      (ack3 a b c)))))
     (ack-y
      (lambda (a b . cs)
        (with cs
    (lambda (c)
      (ack3 a b c)))))
     (ack-z
      (lambda abcs
        (with abcs
    (lambda (a b c)
      (ack3 a b c))))))
    (lambda ()
      (and (= 7 (ack3 0 2 2))
           (= 61 (ack3 0 3 3))
           (= 316 (ack3 1 1 5))
           #;(= 636 (ack3 2 0 1))
     ))))

(crazy-ack)
""", "#t", 'file 10'))
tests.append(("""
(define fact
  (lambda (n)
    (if (zero? n)
      1
      (* n (fact (- n 1)))
    )
  )
)

(fact 5)
""", "120", 'file 11'))
tests.append(("""
(letrec ((fact-1
    (lambda (n)
      (if (zero? n)
    1
    (* n (fact-2 (- n 1))))))
   (fact-2
    (lambda (n)
      (if (zero? n)
    1
    (* n (fact-3 (- n 1))))))
   (fact-3
    (lambda (n)
      (if (zero? n)
    1
    (* n (fact-4 (- n 1))))))
   (fact-4
    (lambda (n)
      (if (zero? n)
    1
    (* n (fact-5 (- n 1))))))
   (fact-5
    (lambda (n)
      (if (zero? n)
    1
    (* n (fact-1 (- n 1)))))))
  (fact-1 10))
""", "3628800", 'file 12'))

if (hasattr(args, 'code')) and args.code:
  tests = []
  tests.append(('manual code execution',))
  tests.append((args.code, 'something', 'Manual Code'))

start_time = datetime.now()
testsCount = 0
skippedTestsCount = 0
failedTestsCount = 0
testsSectionsCount = 0
failedTestsSummary = []

test = 0
section = 0
for t in tests:
  if (len(t) == 1):
    testsSectionsCount += 1
    section = testsSectionsCount
    print('----------------')
    print("[%d] %s" % (section, t[0]), end="")
    if (hasattr(args, 'skip_sections') and section in args.skip_sections)\
        or (hasattr(args, 'only_sections') and not section in args.only_sections):
      print(' (skipped)')
    else:
      print()

    print('----------------')
    continue

  testsCount += 1
  test = testsCount

  if (hasattr(args, 'skip_sections') and section in args.skip_sections)\
      or (hasattr(args, 'only_sections') and\
          not section in args.only_sections and\
          not test in args.only_tests):
    skippedTestsCount += 1
    continue

  scheme_code = t[0]
  expected_output = t[1]
  test_description = t[2]

  print("%d. %s => " % (test, test_description), end="")

  if (hasattr(args, 'skip_tests') and test in args.skip_tests)\
      or (hasattr(args, 'only_tests') and\
          not section in args.only_sections and\
          not test in args.only_tests):
    print("Skipped")
    continue

  with open(tmpSourceFile, 'w') as fd:
    fd.write(scheme_code)

  compile_scheme_file(tmpSourceFile, tmpTargetFile)
  output = getoutput('make ' + srcNoExt + ' > /dev/null && ./' + srcNoExt)

  if str(output).lower() == str(expected_output).lower():
    print("Success")
  else:
    failedTestStr = "%d. Test: %s\nGot:\n%s\nExpected:\n%s" % (test, scheme_code, output, expected_output)
    failedTestsSummary.append(failedTestStr)
    print("Failed!\n" + failedTestStr)
    print("(python3 tester_official.py only -t %d to re-run specific test)" % (test))
    failedTestsCount += 1

end_time = datetime.now()

print()

if failedTestsCount == 0:
  print("All tests passed!", end="")
else:
  print("%d tests failed. (out of %d)" % (failedTestsCount, testsCount), end="")

if skippedTestsCount > 0:
  print(" (%d skipped)" % (skippedTestsCount))
else:
  print()

if failedTestsCount != 0:
  print("Failed tests summary:")
  for summary in failedTestsSummary:
    print(summary)
  print("('python3 tester_official.py only -t test_id' to re-run specific test)")

execution_time = end_time - start_time
print("Executed in %d seconds." % (execution_time.total_seconds()))
