import tag_parser

__author__ = 'Dror Ventura & Eldar Damari'

memoryTable = { 'void':[1,'T_VOID'],'nil':[2,'T_NIL'] }
symbolTable = {'+':'T_PLUS' , '-':'T-MINUS' , '*':'T-MULTI' , '/':'T-DIVIDE'}

mem0 = 7

@staticmethod
def compile_scheme_file(source, target):
    targetFile = open(target,'w')
    targetFile.write(startCode())
    with open(source,'r') as sourceFile:
        sourceFileContent = sourceFile.read()
        generatedContent = appendCodeGen(sourceFileContent)
    targetFile.write(initConstantTable())
    targetFile.write(generatedContent)
    targetFile.write(endCode())

def startCode():
    return  """
            #include <stdio.h>
            #include <stdlib.h>
            #include <string.h>
            #include "./arch/cisc.h"
            int main()
            {
                START_MACHINE;
                JUMP(CONTINUE);

            #include "char.lib"
            #include "io.lib"
            #include "math.lib"
            #include "string.lib"
            #include "system.lib"
            #define VOID(IMM(1));
            #define NIL(IMM(2));
            #define BOOL_FALSE(IMM(3));
            #define BOOL_TRUE(IMM(5));

            CONTINUE:
                /* make void constant */
                CALL(MAKE_SOB_VOID);

                /* make nil constant */
                CALL(MAKE_SOB_NIL);

                /* make boolean False constant */
                PUSH(IMM(0));
                CALL(MAKE_SOB_BOOL);
                DROP(1);

                /* make boolean True constant */
                PUSH(IMM(1));
                CALL(MAKE_SOB_BOOL);
                DROP(1);

            """

def endCode():
    return  """
                STOP_MACHINE;
                return 0;
                }
            """

def initConstantTable():
    return  """

               the constant table initialization code here

            """

def appendCodeGen(source):
    done = False
    code = ""
    s , r = tag_parser.AbstractSchemeExpr.parse(source)
    while not done:
        if r.__eq__(""):
            done = True
            code += s.code_gen()
        else:
            code += s.code_gen()
            s, r = tag_parser.AbstractSchemeExpr.parse(r)
    return code