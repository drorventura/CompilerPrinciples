import tag_parser
import unittest

class TestSexprs(unittest.TestCase):

    def test_constant(self):
       sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('#T')
       self.assertEqual(str(sexpr) , '#t')
       self.assertEqual(str(remaining) , '')

    def test_constant_empty_list(self):
       sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("'()")
       self.assertEqual(str(sexpr) , '()')
       self.assertEqual(str(remaining) , '')

    def test_constant_quote(self):
       sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("'1")
       self.assertEqual(str(sexpr) , '1')
       self.assertEqual(str(remaining) , '')

    def test_variable(self):
       sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('and')
       self.assertEqual(str(sexpr) , 'AND')
       self.assertEqual(str(remaining) , '')

    def test_ifThenElse(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(if #t '1 2)")
        self.assertEqual(str(sexpr) , '(IF #t 1 2)')
        self.assertEqual(str(remaining) , '')

    def test_ifThenElse_Void(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(if #t '1)")
        self.assertEqual(str(sexpr) , '(IF #t 1 Void)')
        self.assertEqual(str(remaining) , '')

    def test_ifThenElse_ifThenElse(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(if #t (if #f 2 goo) 3)")
        self.assertEqual(str(sexpr) , '(IF #t (IF #f 2 GOO) 3)')
        self.assertEqual(str(remaining) , '')

    def test_cond(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(cond (#f '1) (#t 'a) (else 2))")
        self.assertEqual(str(sexpr) , '(IF #f 1 (IF #t (QUOTE A) 2))')
        self.assertEqual(str(remaining) , '')

    def test_cond_void(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(cond (#f '1) (#t 'a))")
        self.assertEqual(str(sexpr) , '(IF #f 1 (IF #t (QUOTE A) Void))')
        self.assertEqual(str(remaining) , '')

    def test_define_singleExpression(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(;sdfsdfsd\\ndefine foo '1)")
        self.assertEqual(str(sexpr) , '(DEFINE FOO 1)')
        self.assertEqual(str(remaining) , '')
        sexpr.semantic_analysis()

    def test_define_pairExpression(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define foo (if 'a b c))")
        self.assertEqual(str(sexpr) , "(DEFINE FOO (IF (QUOTE A) B C))")
        self.assertEqual(str(remaining) , '')

    def test_define_MIT_lambdaSimple(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define (foo . (a b c)) c)")
        self.assertEqual(str(sexpr) , "(DEFINE FOO (LAMBDA (A B C) C))")
        self.assertEqual(str(remaining) , '')

    def test_define_MIT_variadicLambda(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define (foo . b) c)")
        self.assertEqual(str(sexpr) , "(DEFINE FOO (LAMBDA B C))")
        self.assertEqual(str(remaining) , '')

    def test_define_MIT_optLambda(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define (foo . (a . b)) c)")
        self.assertEqual(str(sexpr) , "(DEFINE FOO (LAMBDA (A . B) C))")
        self.assertEqual(str(remaining) , '')

    def test_application_single(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(ABC)')
        self.assertEqual(str(sexpr) , '(ABC)')

    def test_or(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(or #f 'A)")
        self.assertEqual(str(sexpr) , '(OR #f (QUOTE A))')

    def test_or1(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(or)")
        self.assertEqual(str(sexpr) , '(OR)')

    def test_and(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(and 'a b c)")
        self.assertEqual(str(sexpr) , '(IF (QUOTE A) (IF B (IF C C #f) #f) #f)')

    def test_application_1(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(+ 1 2 4 abc)')
        self.assertEqual(str(sexpr) , '(+ 1 2 4 ABC)')

    def test_application_2(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(+ (lambda (x) x) (lambda (x) (lambda (y) 3)) 2 4 abc)')
        self.assertEqual(str(sexpr) , '(+ (LAMBDA (X) X) (LAMBDA (X) (LAMBDA (Y) 3)) 2 4 ABC)')
        # tag_parser.setEnvDepth(sexpr,0)
        # print(sexpr.arguments.sexpr2.sexpr1.body.depth)

    def test_lambdaSimple1(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b c) c)')
        self.assertEqual(str(sexpr) , '(LAMBDA (A B C) C)')
        # tag_parser.setEnvDepth(sexpr,0)
    
    def test_lambdaSimple2(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b c . d) (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A B C . D) (+ A B C))')
        # tag_parser.setEnvDepth(sexpr,0)
    
    def test_lambdaSimple3(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b c d e . f) (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A B C D E . F) (+ A B C))')
    
    def test_lambdaSimple4(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a) (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A) (+ A B C))')

    def test_lambdaSimple5(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(lambda a (+ (car a) (cdr  a)))")
        # self.assertEqual(str(sexpr) , '(LAMBDA A (+ A B C))')
        sexpr.semantic_analysis()
        # print(sexpr.numOfArgs)
    
    def test_let_2_arg(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(let ((x (+ 1 2)) (y 7)) (+ 1 2))')
        self.assertEqual(str(sexpr) , '((LAMBDA (X Y) (+ 1 2)) (+ 1 2) 7)')
    
    def test_let_1_arg(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(let ((x 5)) (+ 2 1))')
        self.assertEqual(str(sexpr) , '((LAMBDA (X) (+ 2 1)) 5)')

    def test_letstar_1_arg(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(let* ((x 5) (y (+ x 1))) (+ x y))')
        self.assertEqual(str(sexpr) , '((LAMBDA (X) ((LAMBDA (Y) (+ X Y)) (+ X 1))) 5)')

    def test_letstar_2_arg(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(let* ((x 5) (y (+ x 1)) (z 18)) (+ x y))')
        self.assertEqual(str(sexpr) , '((LAMBDA (X) ((LAMBDA (Y) ((LAMBDA (Z) (+ X Y)) 18)) (+ X 1))) 5)')
        # tag_parser.setEnvDepth(sexpr,0)
        # print(sexpr.applic.body.applic.body.applic.depth)

    def test_letrec(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(letrec ((a 2)) 'hello)")
        self.assertEqual(str(sexpr) , '(Yag (LAMBDA (&11@ A) (QUOTE HELLO)) (LAMBDA (&24@ A) 2))')

    def test_letrec2(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(letrec ((a (a 3)) (b #t)) (if a b #f))")
        self.assertEqual(str(sexpr) , '(Yag (LAMBDA (&39@ A B) (IF A B #f)) (LAMBDA (&416@ A B) (A 3)) (LAMBDA (&525@ A B) #t))')


    def test_classes(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(lambda (a b) (lambda (c d) (lambda (x y) (+ 1 2)))))")
        # print(sexpr.__class__)
        # print(sexpr.arguments.__class__)
        # print(sexpr.body.__class__)
        # print(sexpr.body.applic.__class__)
        # print(sexpr.body.arguments.__class__)
        # print(sexpr.body.arguments.sexpr1.__class__)
        # print(sexpr.body.arguments.sexpr2.__class__)
        # print(sexpr.body.arguments.sexpr2.sexpr1.__class__)
        # print(sexpr.body.arguments.sexpr2.sexpr2.__class__)
        #sexpr.debruijn()
        #print("\n")
        #print(sexpr.__class__)
        #print(sexpr.arguments.__class__)
        #print(sexpr.body.__class__)
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(lambda (a b) (lambda (c d) (lambda (x y) (+ a x)))))")
        sexpr.debruijn()
        # print(sexpr.body.body.body.applic.__class__)
        # assert
    def test_classes2(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(lambda (a) (lambda (x y) (if #t a b)))))")
        sexpr.debruijn()
        # assert

    def test_classes3(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(lambda (a) (lambda (x y) (or #f y)))))")
        sexpr.debruijn()
        # assert

    def test_classes4(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define foo (lambda (x) (+ x y)))")
        sexpr.debruijn()
        self.assertEqual(type(sexpr.expr.body.arguments.sexpr1).__name__ , 'VarParam')

    def test_classes5(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(LAMBDA (X) (+ x (- 3 2)))")
        sexpr.debruijn()
        self.assertEqual(sexpr.body.arguments.sexpr1.__class__.__name__ , 'VarParam')

    def test_classes6(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("((LAMBDA (X V) (F Z X)) (+ V Z X) 2)")
        sexpr.debruijn()
        # assert

    def test_classes7(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(LAMBDA (X) (LAMBDA (Y Z) ((LAMBDA (X V) (F Z X)) (+ V Z X))))")
        sexpr.debruijn()
        # print(sexpr)

    # def test_classes8(self):
    #     sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(LAMBDA (A B C) (LAMBDA (E F G) (LIST (OR A B (OR C D)) (* G O G O) (LAMBDA Y (LAMBDA X (LAMBDA X (LAMBDA X (LAMBDA X (LAMBDA X (LAMBDA X (LAMBDA X (LAMBDA X (LAMBDA X (LAMBDA X (X Y)))))))))))) (IF (= 9 2) (OR 1 2 3) A) (IF A B (IF A B (IF A B C))) \"bye bye\")))")
    #     sexpr.debruijn()
    #     print(sexpr)

        # assert

    def test_vector(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("#((lambda (x) (+ x y)))")
        sexpr.debruijn()
        # assert

    def test_abstract(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse(
        """
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
        """
        )
        sexpr.semantic_analysis()
        print(sexpr)
        # print(sexpr.code_gen())
        print("r: " + remaining)

    def test_empty_let(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(let () ((lambda s (let () ((lambda s s) s s s))) #t))")
        sexpr.semantic_analysis()
        self.assertEqual(str(sexpr), "((LAMBDA () ((LAMBDA S ((LAMBDA () ((LAMBDA S S) S S S)))) #t)))")
        # print(sexpr.code_gen())
        # ((lambda () ((lambda s ((lambda () ((lambda s s) s s s)))) #t)))

if __name__ == '__main__':
     unittest.main()
