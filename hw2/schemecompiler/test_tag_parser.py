import tag_parser
import unittest

class TestSexprs(unittest.TestCase):

    def test_negative_number(self):
        sexpr , remaining = tag_parser.AbstractSchemeExpr.parse('and')
        self.assertEqual(str(sexpr) , 'hello')
        #self.assertEqual(str(remaining) , '')

if __name__ == '__main__':
     unittest.main()
