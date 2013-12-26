import tag_parser
import unittest

class TestSexprs(unittest.TestCase):
    
    def test_letstar_1_arg(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('(lambda (x) (+ 1 2))')
        self.assertEqual(str(sexpr) , ' ')
    

if __name__ == '__main__':
     unittest.main()
