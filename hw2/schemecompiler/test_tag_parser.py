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
        self.assertEqual(str(sexpr) , '(if #t 1 2)')
        self.assertEqual(str(remaining) , '')

    def test_ifThenElse_Void(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(if #t '1)")
        self.assertEqual(str(sexpr) , '(if #t 1 Void)')
        self.assertEqual(str(remaining) , '')

    def test_ifThenElse_ifThenElse(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(if #t (if #f 2 'goo) 3)")
        self.assertEqual(str(sexpr) , '(if #t (if #f 2 GOO) 3)')
        self.assertEqual(str(remaining) , '')

    def test_cond(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(cond (#f '1) (#t 'a) (else 2))")
        self.assertEqual(str(sexpr) , '(if #f 1 (if #t A 2))')
        self.assertEqual(str(remaining) , '')

    def test_cond_void(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(cond (#f '1) (#t 'a))")
        self.assertEqual(str(sexpr) , '(if #f 1 (if #t A Void))')
        self.assertEqual(str(remaining) , '')

    def test_define_singleExpression(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define foo '1)")
        self.assertEqual(str(sexpr) , '(define FOO 1)')
        self.assertEqual(str(remaining) , '')

    def test_define_pairExpression(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define foo (if 'a 'b 'c))")
        self.assertEqual(str(sexpr) , "(define FOO (if A B C))")
        self.assertEqual(str(remaining) , '')

    def test_define_MIT(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(define (foo . ('a 'b)) 'c)")
        self.assertEqual(str(sexpr) , "(define FOO (LAMBDA (A B) C))")
        self.assertEqual(str(remaining) , '')

    def test_application(self):
       sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(+ 1 2 4 ABC)')
       self.assertEqual(str(sexpr) , '(+ 1 2 4 ABC)')

    def test_application_single(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(ABC)')
        self.assertEqual(str(sexpr) , '(ABC)')

    def test_lambdaSimple1(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b c) (+ a b c))')
        self.assertEqual(str(sexpr) , '(LAMBDA (A B C) (+ A B C))')

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

    def test_application(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(or #f A)')
        self.assertEqual(str(sexpr) , '(OR #f A)')

if __name__ == '__main__':
     unittest.main()
