import sexprs
import unittest

__author__ = 'Dror'

class TestSexprs(unittest.TestCase):

#    def test_boolean(self):
#        bool = sexprs.Boolean('F')
#        self.assertTrue(bool.value == 'f')

#    def test_boolean_toString(self):
#        bool = sexprs.Boolean('T')
#        self.assertTrue(str(bool) == '#t')

#    def test_read_boolean(self):
#        sexpr , remaining = sexprs.AbstractSexpr.readFromString('#F')
#        self.assertEqual(str(sexpr) , '#f')
#        self.assertEqual(str(remaining) , '')
    
    def test_negative_number(self):
        sexpr , remaining = sexprs.AbstractSexpr.readFromString('-5')
        self.assertEqual(str(sexpr) , '-5')
        self.assertEqual(str(remaining) , '')
    
    def test_positive_with_leadingZeros(self):
        sexpr , remaining = sexprs.AbstractSexpr.readFromString('+0088')
        self.assertEqual(str(sexpr) , '88')
        self.assertEqual(str(remaining) , '')
    
    def test_positive_number(self):
        sexpr , remaining = sexprs.AbstractSexpr.readFromString('123')
        self.assertEqual(str(sexpr) , '123')
        self.assertEqual(str(remaining) , '')

if __name__ == '__main__':
     unittest.main()
