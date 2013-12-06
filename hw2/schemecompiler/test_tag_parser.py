import tag_parser
import unittest

class TestSexprs(unittest.TestCase):

    def test_negative_number(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('and')
        self.assertEqual(str(sexpr) , 'AND')
        #self.assertEqual(str(remaining) , '')

    def test_lambdaSimple(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (a b q w e r . v) (1))')
        self.assertEqual(str(sexpr) , 'AND')
        self.assertEqual(str(remaining) , '')

if __name__ == '__main__':
     unittest.main()
