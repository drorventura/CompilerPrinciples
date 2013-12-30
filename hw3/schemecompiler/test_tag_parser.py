import tag_parser
import unittest

class TestSexprs(unittest.TestCase):

    def test_constant(self):
       sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('#T')
       self.assertEqual(str(sexpr) , '#t')
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
    
    def test_lambdaSimple1(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b c) c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A B C) C)')
    
    def test_lambdaSimple2(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b c . d) (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A B C . D) (+ A B C))')
    
    def test_lambdaSimple3(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b c d e . f) (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A B C D E . F) (+ A B C))')
    
    def test_lambdaSimple4(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a) (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A) (+ A B C))')

    def test_lambdaSimple5(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda a (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA A (+ A B C))')
    
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
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(lambda (a) (lambda (x y) (or #f x)))))")
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
        print(sexpr)

        # assert

    def test_vector(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("#((lambda (x) (+ x y)))")
        sexpr.debruijn()
        # assert



if __name__ == '__main__':
     unittest.main()
