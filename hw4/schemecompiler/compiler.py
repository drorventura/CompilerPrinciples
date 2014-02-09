import tag_parser

__author__ = 'Dror Ventura & Eldar Damari'

def compile_scheme_file(source, target):
    with open(target,'w') as targetFile:
        targetFile.write(startCode())
        with open(source,'r') as sourceFile:
            sourceFileContent = sourceFile.read()
            generatedContent = appendCodeGen(sourceFileContent)

        targetFile.write(initConstantTable())

        targetFile.write(generatedContent)

        # targetFile.write(addCodePrintTo("1"))

        targetFile.write(endCode())

def startCode():
    return \
"""#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./arch/cisc.h"
int main()
{
    START_MACHINE;
    JUMP(CONTINUE);

    #include "./arch/char.lib"
    #include "./arch/io.lib"
    #include "./arch/math.lib"
    #include "./arch/scheme.lib"
    #include "./arch/string.lib"
    #include "./arch/system.lib"
    #include "./arch/builtin.lib"

    #define VOID IMM(1)
    #define NIL IMM(2)
    #define BOOL_FALSE IMM(3)
    #define BOOL_TRUE IMM(5)

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
    return """
    L_exit:
    STOP_MACHINE;
    return 0;

    /* exceptions */
    L_error_not_a_closure:
        printf("Error - Not a closure");
        JUMP(L_exit);

    L_error_not_enough_params_given:
        printf("Error - Not enough parameters where given");
        JUMP(L_exit);
}
"""

def appendCodeGen(source):
    done = False
    code = "\n"
    if not source:
        raise CompilationError('Input file is empty')
    else:
        s , r = tag_parser.AbstractSchemeExpr.parse(source)
        s.semantic_analysis()
        while not done:
            if r.__eq__(""):
                done = True
                code += "%s" %s.code_gen()
            else:
                code += "%s" %s.code_gen()
                code += callWriteSob()
                s, r = tag_parser.AbstractSchemeExpr.parse(r)
                s.semantic_analysis()
        return code + callWriteSob()

def initConstantTable():
    sortedDic = tag_parser.sortedConstantList()
    print(sortedDic)
    code = tag_parser.appendTabs() + "/* make constant table*/\n"
    for node in sortedDic[2:]:
        sobType = node[1][1][0]
        if sobType is 'T_INT':
            num = node[1][1][1]
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %num
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_INTEGER);\n"
            code += tag_parser.appendTabs() + "DROP(1);\n"

        elif sobType is 'T_FRACTION':
            num = node[1][1][1]
            denom = node[1][1][2]
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %denom
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %num
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_FRACTION);\n"
            code += tag_parser.appendTabs() + "DROP(2);\n"

        elif sobType is 'T_STRING':
            value = node[1][1][1]
            for i in range(value):
                code += tag_parser.appendTabs() + "PUSH(IMM('%s'));\n" %node[1][1][i+2]

            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %value
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_STRING);\n"
            code += tag_parser.appendTabs() + "DROP(%s);\n" %(value + 1)

        elif sobType is 'T_CHAR':
            value = node[1][1][1]
            code += tag_parser.appendTabs() + "PUSH(IMM('%s'));\n" %value
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_CHAR);\n"
            code += tag_parser.appendTabs() + "DROP(1);\n"

        elif sobType is 'T_PAIR':
            car = node[1][1][1]
            cdr = node[1][1][2]
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %cdr
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %car
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_PAIR);\n"
            code += tag_parser.appendTabs() + "DROP(2);\n"

        elif sobType is 'T_SYMBOL':
            bucket = node[1][1][1]
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %bucket
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_SYMBOL);\n"
            code += tag_parser.appendTabs() + "DROP(1);\n"

        elif sobType is 'T_BUCKET':
            symbolName = node[1][1][1]
            value = node[1][1][2]
            code += tag_parser.appendTabs() + 'PUSH(IMM("%s"));\n' %value
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %symbolName
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_BUCKET);\n"
            code += tag_parser.appendTabs() + "DROP(2);\n"

        elif sobType is 'T_VECTOR':
            # value = node[1][1][1]
            # code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %value
            # for i in range(value):
            #     code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %node[1][1][i+2]
            # code += tag_parser.appendTabs() + "CALL(MAKE_SOB_VECTOR);\n"
            # code += tag_parser.appendTabs() + "DROP(1);\n"
            print("##############MAKE_SOB_VECTOR##################")

        else:
            print(sobType)
            print("need to implemet that")
    code += tag_parser.appendTabs() + "/* end of creating constant table */\n\n"
    return code

def callWriteSob():
    code = \
        """
        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
"""
    return code

# def addCodePrintTo(key):
#     x = tag_parser.memoryTable.get(key)
#     code = ""
#     if x[1][0] is 'T_INT':
#         code += tag_parser.appendTabs() + "PUSH (%s);\n" %x[1][1]
#         code += tag_parser.appendTabs() + "CALL (WRITE_INTEGER);\n"
#     else:
#         code += tag_parser.appendTabs() + "CALL (WRITE);\n"
#
#     return code

class CompilationError(Exception):
    def __init__(self,message):
        Exception.__init__(self,message)