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

    def test_constant_if_then_else(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("(if #t 4/8 2/4)")
       code = s.code_gen()
       self.assertEqual(code , 'MOV(R0,IND(5));\nCMP(R0, FALSE_CONSTANT);\nJUMP EQ(DIF_LABEL);\nMOV(R0,7);\nJUMP (END_IF);\nDIF_LABEL:\nMOV(R0,7);\nEND_IF:\n')

    def test_constant_quote_symbol(self):
       s , r = tag_parser.AbstractSchemeExpr.parse("'tomer")
       code = s.code_gen()
       print(code)
       print(compiler.memoryTable)
       # self.assertEqual(code , 'MOV(R0,IND(5));\nCMP(R0, FALSE_CONSTANT);\nJUMP EQ(DIF_LABEL);\nMOV(R0,7);\nJUMP (END_IF);\nDIF_LABEL:\nMOV(R0,7);\nEND_IF:\n')



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