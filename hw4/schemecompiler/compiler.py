import tag_parser

__author__ = 'Dror Ventura & Eldar Damari'

def compile_scheme_file(source, target):
    tag_parser.resetConstantList()

    builtInProceduresCode = initBuiltInFunctions()

    with open(target,'w') as targetFile:
        targetFile.write(startCode())
        with open(source,'r') as sourceFile:
            sourceFileContent = sourceFile.read()
            generatedContent = appendCodeGen(sourceFileContent)

        targetFile.write(initConstantTable())

        targetFile.write(builtInProceduresCode)

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
        /*printf("Error - Not a closure");*/
        JUMP(L_exit);

    L_error_not_enough_params_given:
        /*printf("Error - Not enough parameters where given");*/
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

    #for item in sortedDic:
    #    print(item)

    code = tag_parser.appendTabs() + "/* make constant table*/\n"
    for node in sortedDic[4:]:
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
            if not type(value) is str:
                code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %value
            else:
                code += tag_parser.appendTabs() + "PUSH(IMM('%s'));\n" %value
            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %symbolName
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_BUCKET);\n"
            code += tag_parser.appendTabs() + "DROP(2);\n"

        elif sobType is 'T_VECTOR':
            vectorList = node[1][1][2]
            numOfparams = node[1][1][1]
            for i in reversed(vectorList):
                code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %i

            code += tag_parser.appendTabs() + "PUSH(IMM(%s));\n" %numOfparams

            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_VECTOR);\n"
            code += tag_parser.appendTabs() + "DROP(%s);\n" %(numOfparams + 1)

        elif sobType is 'T_CLOSURE':
            env = node[1][1][1]
            label = node[1][1][2]

            code += tag_parser.appendTabs() + "PUSH(LABEL(%s));\n" %label
            code += tag_parser.appendTabs() + '/* push the "empty" environment for free vars */\n'
            code += tag_parser.appendTabs() + "PUSH(0);\n"
            code += tag_parser.appendTabs() + "CALL(MAKE_SOB_CLOSURE);\n"
            code += tag_parser.appendTabs() + "DROP(2);\n"

        else:
            print(sobType)
            print("need to implemet that")
    code += tag_parser.appendTabs() + "/* end of creating constant table */\n\n"
    return code

def initBuiltInFunctions():
    yag = \
    """
    (define Yag
        (lambda fs
            (let ((ms (map
                        (lambda (fi)
                          (lambda ms
                            (apply fi (map (lambda (mi)
                                             (lambda args
                                                (apply (apply mi ms) args))) ms))))
                        fs)))
             (apply (car ms) ms))))
    """

    first = \
    """
    (define first
      (lambda (lists)
        (if (null? lists)
          '()
          (cons (car (car lists))
            (first (cdr lists))))))
    """
    rest = \
    """
    (define rest
      (lambda (lists)
        (if (null? lists)
          '()
          (cons (cdr (car lists))
            (rest (cdr lists))))))
    """

    mapHelper = \
    """
    (define map-helper
      (lambda (proc x)
        (if (null? (car x))
          '()
          (let ((args (first x))
            (rest (rest x)))
         (cons (apply proc args)
            (map-helper proc rest))))))
    """

    mapProc = \
    """
    (define map
      (lambda (proc . x)
        (map-helper proc x)))
    """

    s,r = tag_parser.AbstractSchemeExpr.parse(first)
    s.semantic_analysis()
    # print(s)
    code = s.code_gen()
    s,r = tag_parser.AbstractSchemeExpr.parse(rest)
    s.semantic_analysis()
    # print(s)
    code += s.code_gen()
    s,r = tag_parser.AbstractSchemeExpr.parse(mapHelper)
    s.semantic_analysis()
    # print(s)
    code += s.code_gen()
    s,r = tag_parser.AbstractSchemeExpr.parse(mapProc)
    s.semantic_analysis()
    # print(s.expr.numOfArgs)
    code += s.code_gen()

    s,r = tag_parser.AbstractSchemeExpr.parse(yag)
    s.semantic_analysis()
    code += s.code_gen()

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
