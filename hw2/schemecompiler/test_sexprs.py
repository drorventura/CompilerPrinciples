import sexprs
import unittest

__author__ = 'Dror'

class TestSexprs(unittest.TestCase):

    def test_boolean(self):
        bool = sexprs.Boolean('F')
        self.assertTrue(bool.value == 'f')

    def test_boolean_toString(self):
        bool = sexprs.Boolean('T')
        self.assertTrue(str(bool) == '#t')

    def test_read_boolean(self):
        sexpr , remaining = sexprs.AbstractSexpr.readFromString('#F')
        self.assertEqual(str(sexpr) , '#f')
        self.assertEqual(str(remaining) , '')

if __name__ == '__main__':
    unittest.main()

