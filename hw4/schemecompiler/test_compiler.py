import tag_parser
import compiler
import unittest

class TestCompiler(unittest.TestCase):

    def test_constant_bool_true(self):
       s , r = tag_parser.AbstractSchemeExpr.parse('#t')
       code  = s.code_gen()
       self.assertEqual(code , 'MOV(R0,IND(5));\n')

    def test_constant_bool_false(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("#f")
       code  = s.code_gen()
       self.assertEqual(code , 'MOV(R0,IND(3));\n')

    def test_constant_int(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("1")
       code  = s.code_gen()
       print(code)
       print(compiler.memoryTable)
       self.assertEqual(code , 'MOV(R0,IND(7));\n')

    def test_constant_frac(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("4/7 -3/2")
       code1 = s.code_gen()
       x, y = tag_parser.AbstractSchemeExpr.parse(r)
       code2 = x.code_gen()
       print(compiler.memoryTable)
       self.assertEqual(code1 , 'MOV(R0,IND(7));\n')
       self.assertEqual(code2 , 'MOV(R0,IND(10));\n')


    def test_constant_if_then_else(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("(if #t 4/8 2/4)")
       code = s.code_gen()
       self.assertEqual(code , 'MOV(R0,IND(5));\nCMP(R0, FALSE_CONSTANT);\nJUMP EQ(DIF_LABEL);\nMOV(R0,7);\nJUMP (END_IF);\nDIF_LABEL:\nMOV(R0,7);\nEND_IF:\n')

    def test_constant_quote_symbol(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("'tomer")
       code = s.code_gen()
       print(compiler.memoryTable)
       self.assertEqual(compiler.mem0,19)
       self.assertEqual(code , 'MOV(R0,IND(16));\nMOV(R0,INDD(R0,2));\nMOV(R0,INDD(R0,1));\n')

    def test_constant_quote_proper_list(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("'(1 (and 1 3) 4 6)")
       code = s.code_gen()
       print(tag_parser.sortConstantList(compiler.memoryTable))
       self.assertEqual(compiler.mem0,46)
       self.assertEqual(code , 'MOV(R0,IND(43));\n')

    def test_constant_quote_proper_list2(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("'(1 (3 4) 2 5)")
       code = s.code_gen()
       print(code)
       print(compiler.memoryTable)
       # self.assertEqual(compiler.mem0,46)
       # self.assertEqual(code , 'MOV(R0,IND(43));\n')

    def test_constant_quote_improper_list(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("'(1  . (and 1 3))")
       code = s.code_gen()
       # print(compiler.memoryTable)
       self.assertEqual(compiler.mem0,33)
       self.assertEqual(code , 'MOV(R0,IND(30));\n')

    def test_constant_quote_vector(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("'#(a b 1 4 6 z))")
       code = s.code_gen()
       # print(compiler.memoryTable)
       print(tag_parser.sortConstantList(compiler.memoryTable))
       self.assertEqual(compiler.mem0,55)
       self.assertEqual(code , 'MOV(R0,IND(52));\n')

    def test_constant_empty(self):
       s , r = tag_parser.AbstractSchemeExpr.parse('"dror"')
       code = s.code_gen()
       print(code)
       print(tag_parser.memoryTable)
       # print(tag_parser.sortConstantList(compiler.memoryTable))
       # self.assertEqual(compiler.mem0,55)
       # self.assertEqual(code , 'MOV(R0,IND(52));\n')

if __name__ == '__main__':
     unittest.main()


     # s,r = AbstractSchemeExpr.parse("'foo")
     #
     # # print(type(s.constant))
     #
     # print(s.code_gen())
     #
     # b,r = AbstractSchemeExpr.parse("'a")
     # print(b.code_gen())
     #
     # print(compiler.mem0)
     # print(compiler.memoryTable)