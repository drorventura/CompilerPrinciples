import tag_parser
import unittest

class TestSexprs(unittest.TestCase):

    def test_constant(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('#T')
        self.assertEqual(str(sexpr) , '#t')
        #self.assertEqual(str(remaining) , '')

    def test_constant_quote(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("'1")
        self.assertEqual(str(sexpr) , '1')
        #self.assertEqual(str(remaining) , '')

    def test_variable(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('and')
        self.assertEqual(str(sexpr) , 'AND')
        #self.assertEqual(str(remaining) , '')

    def test_ifThenElse(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(if #t '1 2)")
        self.assertEqual(str(sexpr) , '(if #t (1 (2 )))')
        self.assertEqual(str(remaining) , '')

    def test_ifThenElse_Void(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(if #t '1)")
        self.assertEqual(str(sexpr) , '(if #t (1 Void))')
        self.assertEqual(str(remaining) , '')

    def test_cond(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(cond (#f '1) (#t 'a) (else 2))")
        self.assertEqual(str(sexpr) , '(if #f ((1 ) (if #t ((A ) (2 )))))')
        self.assertEqual(str(remaining) , '')

    def test_cond_void(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse("(cond (#f '1) (#t 'a))")
        self.assertEqual(str(sexpr) , '(if #f ((1 ) (if #t ((A ) Void))))')
        self.assertEqual(str(remaining) , '')

if __name__ == '__main__':
     unittest.main()
