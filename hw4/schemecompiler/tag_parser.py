import sexprs
import compiler

__author__ = 'Dror & Eldar'

##############################
#           Macros           #
##############################
# matched strings for Constants
Constants_Strings = {"Boolean" , "Int" , "Char" , "Fraction", "String", "Nil"}

QuotedLike_Strings = {"QUOTE" , "QUASIQUOTE" , "UNQUOTE-SPLICING" , "UNQUOTE"}

##############################
#           Gensym           #
##############################
n = 0
class Gensym:
    @staticmethod
    def generate():
        global n
        n += 1
        return '&' + '%s' %n + '%s' %(n*n) + '@'

num = 0
class LabelGenerator:
    @staticmethod
    def getLabel():
        global num
        return '%s' %num

    @staticmethod
    def nextLabel():
        global num
        num += 1

##############################
#            GCD             #
##############################
#Calculate the gcd of two numbers
def gcd(a, b):
    return b and gcd(b, a % b) or a

##############################
#        Constant List       #
##############################
memoryTable = { 'void':[1,['T_VOID']],'nil':[2,['T_NIL']] }
mem0 = 7

reservedWordsSymbolTable = {'+':'L_Plus_Applic',         #variadic
                            '-':'L_Minus_Applic',        #variadic
                            '*':'L_Multi_Applic',        #variadic
                            '/':'L_Divide_Applic',       #variadic
                            '>':'L_Lt_Applic',           #variadic
                            '<':'L_Gt_Applic',           #variadic
                            '=':'L_Equal_Applic',        #variadic
                            'vector':'L_Vector_Applic',
                            'list':'L_List_Applic',
                            'map':'L_Map_Applic',
                            'append':'L_Append_Applic',
                            'apply':'L_Apply_Applic',
                            'cons':'L_Cons_Applic',
                            'car':'L_Car_Applic',
                            'cdr':'L_Cdr_Applic',
                            'remainder':'L_Remainder_Applic',
                            'yag':'L_Yag_Applic',
                            'null?':'L_Is_Null_Applic',
                            'boolean?':'L_Is_Boolean_Applic',
                            'char?':'L_Is_Char_Applic',
                            'number?':'L_Is_Num_Applic',
                            'integer?':'L_Is_Int_Applic',
                            'zero?':'L_Is_Zero_Applic',
                            'pair?':'L_Is_Pair_Applic',
                            'vector?':'L_Is_Vector_Applic',
                            'procedure?':'L_Is_Procedure_Applic',
                            'string?':'L_Is_String_Applic',
                            'symbol?':'L_Is_Symbol_Applic',
                            'eq?':'L_Is_Eq_Applic',
                            'make-string':'L_Make_String_Applic',
                            'make-vector':'L_Make_Vector_Applic',
                            'string-length':'L_String_Length_Applic',
                            'string-ref':'L_String_Ref_Applic',
                            'vector-length':'L_Vector_Length_Applic',
                            'vector-ref':'L_Vector_Ref_Applic',
                            'char->integer':'L_Char_To_Int_Applic',
                            'integer->char':'L_Int_To_Char_Applic',
                            'string->symbol':'L_String_To_Symbol_Applic',
                            'symbol->string':'L_Symbol_To_String_Applic',
                            }

def sortedConstantList():
    return sorted(memoryTable.items(), key = lambda x: x[1])

def appendTabs():
    return "\t\t"

def countNumParams(exp,result):
    if type(exp) is sexprs.Pair:
        countNumParams(exp.sexpr1,result)
        countNumParams(exp.sexpr2,result)
    elif not type(exp) is sexprs.Nil:
        result.append(exp)
    return result

def setEnvDepth(exp,depth):
    if isinstance(exp,AbstractLambda):
        exp.depth = depth
        listParams = countNumParams(exp.arguments,[])
        exp.numOfArgs = len(listParams)
        setEnvDepth(exp.body,depth + 1)
    elif isinstance(exp,Applic):
        setEnvDepth(exp.applic,depth)
        arg = exp.arguments
        while type(arg) is sexprs.Pair:
            setEnvDepth(arg.sexpr1,depth)
            arg = arg.sexpr2

##############################
#           Parser           #
##############################
def parserRecursive(expr):
        className = expr.__class__.__name__

        if className ==   "Pair":
            return tagPair(expr)

        elif className == "Symbol":
            return Variable(expr)

        elif className == "Vector":
            return parserRecursive(expr.sexpr)

        elif className in Constants_Strings:
            return tagConstant(expr)

        else:
            return expr

def tagPair(expr):
    if isinstance(expr.sexpr1, sexprs.Symbol):
        # Identify: Quoted Like Strings
        if expr.sexpr1.string == "QUASIQUOTE":
            res = expandQQ(expr.sexpr2)
            return parserRecursive(res)

        if expr.sexpr1.string in QuotedLike_Strings:        # Pair(Symbol(QuoteLike), Pair(Sexpression, Nil) )
            if expr.sexpr2.sexpr1.__class__.__name__ in Constants_Strings:
                return Constant(expr.sexpr2.sexpr1)         # This case handles the Sexpressions like boolean, int, ect.
            else:
                return Constant(expr)                       # This case handles other symbols that are quoted

        # Identify: IF
        elif expr.sexpr1.string == "IF":
            return tagIf(expr.sexpr2)

        # Identify: COND
        elif expr.sexpr1.string == "COND":
            return tagCond(expr.sexpr2)

        # Identify: DEFINE
        elif expr.sexpr1.string == "DEFINE":
            return tagDefine(expr.sexpr2)

        # Identify: LAMBDA
        elif expr.sexpr1.string == "LAMBDA":
            return tagLambda(expr.sexpr2)

        elif expr.sexpr1.string == "LETREC":
            return tagLetrec(expr.sexpr2)

        # Identify: LET
        elif expr.sexpr1.string == "LET":
            return tagLet(expr.sexpr2)

        # Identify: LET*
        elif expr.sexpr1.string == "LET*":
            return tagLetStar(expr.sexpr2)

        # Identify: OR
        elif expr.sexpr1.string == "OR":
            return tagOr(expr.sexpr2)

        # Identify: AND
        elif expr.sexpr1.string == "AND":
            return tagAnd(expr.sexpr2)

        # Identify: APPLICATION
        else:
            return tagApplic(expr)
    else:
        return tagApplic(expr)
            # sexprs.Pair([parserRecursive(expr.sexpr1), parserRecursive(expr.sexpr2)])

##########################################
#           Special For LAMBDA           #
##########################################
def parserRecursiveForLambda(expr):
        className = expr.__class__.__name__

        if className == "Symbol":
            return Variable(expr)

        elif className in Constants_Strings:
            raise lambdaParametersIsNotVariable("Lambda Parameters Need To Be Variables")

        elif className ==   "Pair":
            return tagPairLambda(expr)

def tagPairLambda(expr):

    if isinstance(expr.sexpr1, sexprs.Symbol):
        # Handling Variables
        if isinstance(expr.sexpr1 , sexprs.Symbol) and\
           isinstance(expr.sexpr2, sexprs.Symbol):
            return  ['.' , sexprs.Pair([parserRecursive(expr.sexpr1),'.',parserRecursive(expr.sexpr2)])]
        else:
            if isinstance(expr.sexpr2,sexprs.Pair) and\
               isinstance(expr.sexpr2.sexpr1, sexprs.Symbol) and\
               isinstance(expr.sexpr2.sexpr2, sexprs.Symbol):
            # senfing to pair const. with list of lists, to work with sum
                list_to_be_flatten = [[parserRecursiveForLambda(expr.sexpr1)],parserRecursiveForLambda(expr.sexpr2)]
                if list_to_be_flatten[1][0] == '.':
                    return  sexprs.Pair(sum(list_to_be_flatten,[]))
            else:
                try:
                    return  sexprs.Pair([parserRecursiveForLambda(expr.sexpr1),
                                         parserRecursiveForLambda(expr.sexpr2)])
                except lambdaParametersIsNotVariable:
                    return  sexprs.Pair([parserRecursiveForLambda(expr.sexpr1)])
    else:
        raise lambdaParametersIsNotVariable("Lambda Parameters Need To Be Variables")

#END#########################################

def tagVariable(expr):
    return Variable(expr)

# def tagVector(expr):
#     return str(sexprs.Vector(expr))

def tagConstant(expr):
    return Constant(expr)

def tagIf(expr):
    try:
        if isinstance(expr.sexpr2.sexpr2, sexprs.Nil):
            return IfThenElse(parserRecursive(expr.sexpr1),                 # Condition
                              parserRecursive(expr.sexpr2.sexpr1),          # Than
                              Constant(sexprs.Void()))                      #Void
        else:
            return IfThenElse(parserRecursive(expr.sexpr1),                 # Condition
                              parserRecursive(expr.sexpr2.sexpr1),          # Than
                              parserRecursive(expr.sexpr2.sexpr2.sexpr1))   # Else
    except:
        raise NotEnoughParameters('expected: (if <condition> <than> <alternative>) or (if <condition> <than>')

def tagCond(expr):
    try:
        if isinstance(expr, sexprs.Nil):
            # when there is no else-clause
            return sexprs.Void()
        elif isinstance(expr.sexpr1.sexpr1, sexprs.Symbol) and expr.sexpr1.sexpr1.string == 'ELSE':
            # when last clause is else# when last clause is else
            return parserRecursive(expr.sexpr1.sexpr2.sexpr1)
        else:
            return IfThenElse(parserRecursive(expr.sexpr1.sexpr1),          # Condition - Ti
                              parserRecursive(expr.sexpr1.sexpr2.sexpr1),   # Than - Ei
                              tagCond(expr.sexpr2))                         # Recursive Alternative Ti+1
    except:
        raise SyntaxErrorException(expr)

def tagDefine(expr):
    try:
        if isinstance(expr.sexpr1, sexprs.Symbol):
            return Def(Variable(expr.sexpr1),
                       parserRecursive(expr.sexpr2.sexpr1))
        else:
            #MIT-style
            return Def(Variable(expr.sexpr1.sexpr1),
                       tagLambda(sexprs.Pair([expr.sexpr1.sexpr2,           # <arg1>
                                              expr.sexpr2.sexpr1])))        # <expr>
    except:
        raise SyntaxErrorException

def tagLambda(expr):
    body = parserRecursive(expr.sexpr2.sexpr1)

    if not isinstance(expr.sexpr1, sexprs.Nil):
        params = parserRecursiveForLambda(expr.sexpr1)
        if isinstance(params,list):
            params = params[1]
    else:
        return LambdaSimple(expr.sexpr1,body)

    temp_args = params

    # Lambda Variadic
    if isinstance(params, Variable):
        return LambdaVar(params,body)

    while not isinstance(temp_args.sexpr1, type(temp_args.sexpr2)):

        if isinstance(temp_args,sexprs.Pair):

            if  isinstance(temp_args.sexpr1,Variable) and\
                    isinstance(temp_args.sexpr2,sexprs.Pair) and\
                    isinstance(temp_args.sexpr2.sexpr1,Variable) and\
                    isinstance(temp_args.sexpr2.sexpr2,sexprs.Nil):
                        return LambdaSimple(params,body)

            elif  isinstance(temp_args.sexpr1,Variable) and\
                    isinstance(temp_args.sexpr2,sexprs.Pair) and\
                    isinstance(temp_args.sexpr2.sexpr1,Variable) and\
                    isinstance(temp_args.sexpr2.sexpr2,Variable):
                        return LambdaOpt(params,body)
            else:
                if isinstance(temp_args.sexpr2,sexprs.Nil) and isinstance(temp_args.sexpr1,sexprs.Pair):
                            temp_args = temp_args.sexpr1
                else:
                    temp_args = temp_args.sexpr2
                if not isinstance(temp_args,sexprs.Pair):
                    return LambdaSimple(params,body)

    # Lambda Optional
            # differ between (a . b) to (a (b Nil())
    if isinstance(temp_args.sexpr1, Variable) and isinstance(temp_args.sexpr2, Variable):
        return LambdaOpt(params,body)

    # Lambda Simple
    return LambdaSimple(params,body)

def tagLetrec(expressions):
    params , args = seperateParamsAndArgs(expressions.sexpr1)

    expr = expressions.sexpr2.sexpr1

    # lambdaSymbol = sexprs.Symbol('LAMBDA', 6)

    genTmp = Gensym.generate()
    g0 = sexprs.Symbol(genTmp,len(genTmp))
    params.insert(0,g0)

    firstLetrecExp = sexprs.Pair(sum([[buildPairForParamsInLet(params)],
                                      [expr]],[]))

    listLetrecExpr = []
    while len(args) > 0:
        params = params[1:]
        genTmp = Gensym.generate()
        g0 = sexprs.Symbol(genTmp,len(genTmp))
        params.insert(0,g0)
        letrecExp = sexprs.Pair(sum([[buildPairForParamsInLet(params)],[args[0]]],[]))
        listLetrecExpr.append(tagLambda(letrecExp))
        args = args[1:]

    yag = sexprs.Symbol('Yag', 3)

    pairForApplic = sexprs.Pair(sum([[yag], [tagLambda(firstLetrecExp)], listLetrecExpr],[]))

    return tagApplic(pairForApplic)

def seperateParamsAndArgs(expr):
    bound = expr
    list_params = []
    list_args   = []

    while isinstance(bound,sexprs.Pair):
        list_params.append(bound.sexpr1.sexpr1)

        list_args.append(bound.sexpr1.sexpr2.sexpr1)

        if isinstance(bound.sexpr2,sexprs.Nil):
            break
        else:
            bound = bound.sexpr2
    return list_params , list_args

def pairsAnnotate(expr,inTp):
    bound = expr

    while isinstance(bound,sexprs.Pair):
        bound.sexpr1 = parserRecursive(bound.sexpr1)
        if isinstance(bound.sexpr2,sexprs.Nil):
            bound.sexpr1 = bound.sexpr1.annotateTC(inTp)
        if isinstance(bound.sexpr2,sexprs.Nil):
            break
        else:
            bound = bound.sexpr2
    return 

def buildPairForParamsInLet(list_params):
    return sexprs.Pair(list_params)

# Seperating pairs argument to list
def pairsToList(expr):
    bound = expr
    list_params = []

    while isinstance(bound,sexprs.Pair):
        if not isinstance(bound.sexpr2, (sexprs.Pair,sexprs.Nil)):
            list_params.append(bound.sexpr1)
            list_params.append(bound.sexpr2)
            break
        if isinstance(bound.sexpr1, sexprs.Pair):
            list_params.append(bound.sexpr1)
        else:
            list_params.append(bound.sexpr1)
        bound = bound.sexpr2

    return list_params

def varsToList(expr):
    bound = expr
    list_params = []

    while isinstance(bound,sexprs.Pair):
        list_params.append(bound.sexpr1)
        if not isinstance(bound.sexpr2, (sexprs.Pair,sexprs.Nil)):
            list_params.append(bound.sexpr2)
            break
        if not isinstance(bound.sexpr2,sexprs.Nil):
            bound = bound.sexpr2.sexpr1
        else:
            bound = bound.sexpr2
    return list_params

def tagApplic(applic):
    app = applic.sexpr1
    arguments = applic.sexpr2
    return Applic(app,arguments)

def tagOr(arguments):
    return Or(arguments)

def tagAnd(expr):
    # a single case when and procedure is called with no arguments (AND)
    if isinstance(expr,sexprs.Nil):
        e1 = Constant(sexprs.Boolean('t'))
        e2 = Constant(sexprs.Boolean('f'))
        return IfThenElse(e1,e1,e2)

    # base case for the recursion
    elif isinstance(expr.sexpr2, sexprs.Nil):
        e1 = parserRecursive(expr.sexpr1)
        e2 = Constant(sexprs.Boolean('f'))
        return IfThenElse(e1,e1,e2)

    # the recursive call to tagAnd
    else:
        return  IfThenElse(parserRecursive(expr.sexpr1),
                           tagAnd(expr.sexpr2),
                           Constant(sexprs.Boolean('f')))

def tagLet(expr):
    body = expr.sexpr2.sexpr1
    if isinstance(expr.sexpr1,sexprs.Nil):
        raise SyntaxErrorException("In Let Parameters Bound Are Empty")

    list_params , list_args = seperateParamsAndArgs(expr.sexpr1)

    tagged_list_args = []
    for arg in list_args:
        tagged_list_args.append(parserRecursive(arg))

    paramsPair    = buildPairForParamsInLet(list_params)
    argsPair      = buildPairForParamsInLet(tagged_list_args)
    bodyPair      = ['.', sexprs.Pair([body])]

    pairForLambda = sexprs.Pair(sum([[paramsPair],bodyPair],[])) #warning!
    pairForApplic = sexprs.Pair(sum([[tagLambda(pairForLambda)],['.',argsPair]],[])) #warning!

    return  tagApplic(pairForApplic)

def buildPairForParamsInLet(list_params):
        return sexprs.Pair(list_params)

def tagLetStartRec(expr):

    finalPair1 = ['.',expr.sexpr2.sexpr1]

    if isinstance(expr.sexpr2.sexpr1.sexpr1.sexpr2,sexprs.Nil):
        finalPairWithString = sexprs.Pair(sum([[sexprs.Symbol("LET",3)],
                                                    finalPair1],[]))
    else:
        finalPairWithString = sexprs.Pair(sum([[sexprs.Symbol("LET*",4)],
                                                    finalPair1],[]))
    body = finalPairWithString
    if isinstance(expr.sexpr1,sexprs.Nil):
        raise SyntaxErrorException("In Let Parameters Bound Are Empty")

    list_params , list_args = seperateParamsAndArgs(expr.sexpr1)

    paramsPair    = buildPairForParamsInLet(list_params)
    argsPair      = buildPairForParamsInLet(list_args)
    bodyPair      = ['.', sexprs.Pair([body])]
    pairForLambda = sexprs.Pair(sum([[paramsPair],bodyPair],[])) #warning!
    pairForApplic = sexprs.Pair(sum([[tagLambda(pairForLambda)],['.',argsPair]],[])) #warning!

    return  tagApplic(pairForApplic)

def tagLetStar(expr):

    if isinstance(expr.sexpr1.sexpr2,sexprs.Nil):  # last bound, need to use body
        return tagLet(sexprs.Pair(expr))
    else:
        single_bound = expr.sexpr1.sexpr1
        pairSingleBound = sexprs.Pair([single_bound])  #[ | NIL ] -> [ X | ] -> [5 | NIL]
        cont_body    = ['.', expr.sexpr2]
        pairForLet   = sexprs.Pair(sum([[expr.sexpr1.sexpr2],cont_body],[]))

        bodyWithLet  = sexprs.Pair([pairForLet])

        cont_body_withLet = ['.',bodyWithLet]
        finalPair = sexprs.Pair(sum([[pairSingleBound],cont_body_withLet],[]))

        return tagLetStartRec(finalPair)

def expandQQ(expr):

    if isinstance(expr,sexprs.Nil):
        return ()

    if isinstance(expr,sexprs.Pair):
        head = expr.sexpr1
        tail = expr.sexpr2

        if isinstance(head,sexprs.Pair) and\
            head.sexpr1 == "UNQUOTE-SPLICING":
            return sexprs.Pair(sum([[sexprs.Symbol('APPEND',6)],
                ['.',sexprs.Pair(sum([[head.sexpr2.sexpr1],
                    ['.',sexprs.Pair([expandQQ(tail)])]],[]))]],[]))

        elif isinstance(tail,sexprs.Pair) and\
                tail.sexpr1 == "UNQUOTE-SPLICING":
            return sexprs.Pair(sum([[sexprs.Symbol('CONS',4)],
                                ['.',sexprs.Pair(sum([[expandQQ(head)],
                                             ['.',sexprs.Pair([expr.sexpr2.sexpr1])]],[]))]],[]))
        else:
            return sexprs.Pair(sum([[sexprs.Symbol('CONS',4)],
                                ['.',sexprs.Pair(sum([[expandQQ(head)],
                                             ['.',sexprs.Pair([expandQQ(tail)])]],[]))]],[]))
    elif isinstance(expr,sexprs.Vector):
        return sexprs.Pair(sum([[sexprs.Symbol('LIST->VECTOR',12)], ['.',sexprs.Pair([expandQQ(expr)])]],[])) # may be need last arg

    elif isinstance(expr,sexprs.Nil) or \
            isinstance(expr,sexprs.Symbol):
            return sexprs.Pair(sum([[sexprs.Symbol('QUOTE_LAST',5)],
                ['.',sexprs.Pair([expr])]],[]))
    else:
        return expr

##############################
#       Exceptions           #
##############################
class OverWritingReservedWords(Exception):
    def __init__(self,expr):
        Exception.__init__(self,str(expr))

class lambdaParametersIsNotVariable(Exception):
    def __init__(self,message):
        Exception.__init__(self,message)

class NotEnoughParameters(Exception):
    def __init__(self,message):
        Exception.__init__(self,message)

class SyntaxErrorException(Exception):
    def __init__(self,expr):
        Exception.__init__(self,str(expr))

###################################
# Main Abstract Scheme Expr Class #
###################################

class AbstractSchemeExpr:
    #Overide str(...)
    def __str__(self):
        return self.accept(AsStringVisitor)

    #Overide annotate(...)
    def annotateTC(self,inTp):
        return self.annotate(AnnotateVisitor,inTp)

    def code_gen(self):
        return self.generate(CodeGenVisitor)

    def debruijn(self):
        self.debruijn_helper([], [])

    def debruijn_helper(self, bound, param):
        className = self.__class__.__name__
        if className == "Variable":
            minor = -1
            for p in param:
                if str(p) == str(self):
                    minor = param.index(p)
                    self.__class__ = VarParam
                    self.minor = minor
                    break
            if minor < 0:
                for major, list_params in enumerate(bound):
                    for b in list_params:
                        if str(b) == str(self):
                            minor = list_params.index(b)
                            self.__class__ = VarBound
                            self.major = major
                            self.minor = minor
            if minor < 0:
                self.__class__ = VarFree

        elif className.__contains__("Lambda"):
            if className == "LambdaSimple":
                self.arguments, self.body.debruijn_helper([param] + bound, varsToList(self.arguments))
            if className == "LambdaVar":
                return self.arguments, self.body.debruijn_helper([param] + bound, varsToList(self.arguments))
            if className == "LambdaOpt":
                return self.arguments, self.body.debruijn_helper([param] + bound, varsToList(self.arguments))

        else:
            if className == "Applic":
                self.applic.debruijn_helper(bound, param)

                arguments = pairsToList(self.arguments)
                for arg in arguments:
                    arg.debruijn_helper(bound,param)
            elif className == "IfThenElse":
                arguments = pairsToList(self.pair)
                for arg in arguments:
                    arg.debruijn_helper(bound,param)
            elif className == "Or":
                arguments = pairsToList(self.arguments)
                for arg in arguments:
                    arg.debruijn_helper(bound, param)
            elif className == "Def":
                self.name.debruijn_helper(bound,param)
                self.expr.debruijn_helper(bound,param)

    @staticmethod
    def parse(string):
        expr , remaining = sexprs.AbstractSexpr.readFromString(string)
        return parserRecursive(expr) , remaining

    # part 3
    def semantic_analysis(self):
            self.debruijn()
            self.annotateTC(True)
            setEnvDepth(self,0)
            return self

# Constant Class
class Constant(AbstractSchemeExpr):
    def __init__(self,constant):
        self.constant = constant

    def accept(self, visitor):
        return visitor.visitConstant(self)
    
    def annotate(self, visitor,inTp):
        return visitor.visitAnnotateConstant(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenConstant(self)

# Variable Class
class Variable(AbstractSchemeExpr):
    def __init__(self,variable):
        self.variable = variable

    def accept(self, visitor):
        return visitor.visitVariable(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateVariable(self,inTp)

class VarFree(Variable):
    def __init__(self, variable):
        super().__init__(variable)

    def accept(self, visitor):
        return visitor.visitVariable(self)

    def generate(self, visitor):
        return visitor.codeGenVarFree(self)

class VarParam(Variable):
    def __init__(self, variable, minor):
        super().__init__(variable)
        self.minor = minor

    def accept(self, visitor):
        return visitor.visitVariable(self)

    def generate(self, visitor):
        return visitor.codeGenVarParam(self)

class VarBound(Variable):
    def __init__(self, variable,major, minor):
        super().__init__(variable)
        self.major = major
        self.minor = minor

    def accept(self, visitor):
        return visitor.visitVariable(self)

    def generate(self, visitor):
        return visitor.codeGenVarBound(self)

# IfThenElse Class
class IfThenElse(AbstractSchemeExpr):
    def __init__(self,condition,than,alternative):
        self.pair = sexprs.Pair([condition,than,alternative])

    def accept(self, visitor):
        return visitor.visitIfThenElse(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateIfThenElse(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenIfThenElse(self)

# AbstractLambda Class
class AbstractLambda(AbstractSchemeExpr):
    def __init__(self):
        self.depth = 0
        self.numOfArgs = 0

    def accept(self, visitor):
        return visitor.visitAbstractLambda(self)

# LambdaSimple Class
class LambdaSimple(AbstractLambda):
    def __init__(self,arguments,body):
        super().__init__()
        self.arguments = arguments
        self.body = body

    def accept(self, visitor):
        return visitor.visitAbstractLambda(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateLambdaSimple(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenLambdaSimple(self)

# LambdaOpt Class
class LambdaOpt(AbstractLambda):
    def __init__(self,arguments,body):
        super().__init__()
        self.arguments = arguments
        self.body = body

    def accept(self,visitor):
        return visitor.visitLambdaOpt(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateLambdaOpt(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenLambdaOpt(self)

# LambdaVar Class
class LambdaVar(AbstractLambda):
    def __init__(self,arguments,body):
        super().__init__()
        self.arguments = arguments
        self.body = body

    def accept(self,visitor):
        return visitor.visitLambdaVar(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateLambdaVar(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenLambdaVar(self)

# Applic Class
class Applic(AbstractSchemeExpr):
    def __init__(self, applic, arguments):
        if isinstance(applic , sexprs.Symbol):
            self.applic = Variable(applic)
        else:
            self.applic = parserRecursive(applic)

        argsList = pairsToList(arguments)
        newArguments = []
        if argsList:
            for arg in argsList:
                arg = parserRecursive(arg)
                newArguments.append(arg)
            self.arguments = sexprs.Pair(newArguments)
        else:
            self.arguments = arguments

    def accept(self,visitor):
        return visitor.visitApplic(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateApplic(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenApplic(self)

# Or Class
class Or(AbstractSchemeExpr):
    def __init__(self,arguments):
        iterator = arguments
        while isinstance(iterator,sexprs.Pair):
            iterator.sexpr1 = parserRecursive(iterator.sexpr1)
            iterator = iterator.sexpr2

        self.arguments = arguments

    def accept(self,visitor):
        return visitor.visitOr(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateOr(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenOr(self)

# Def Class
class Def(AbstractSchemeExpr):
    def __init__(self,name,expr):
        self.name = name
        self.expr = expr

    def accept(self,visitor):
        return visitor.visitDef(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateDef(self,inTp)

    def generate(self, visitor):
        return visitor.codeGenDef(self)

# Visitor design pattern
class AsStringVisitor(AbstractSchemeExpr):

    def visitConstant(self):
        return str(self.constant)
        # if isinstance(self.constant,sexprs.String):
        #     return '"' + str(self.constant) + '"'
        # if not isinstance(self.constant , sexprs.Nil):
        #     return str(self.constant)
        # else:
        #     return ''

    def visitVariable(self):
        return str(self.variable)

    def visitIfThenElse(self):
        return '(IF ' + str(self.pair.sexpr1) + ' ' \
                      + sexprs.AsStringVisitor.pairToString(self.pair.sexpr2) + ')'

    def visitAbstractLambda(self):
        if isinstance(self.arguments, sexprs.Nil):
            return '(LAMBDA ' +'() ' + str(self.body) + ')'
        else:
            return '(LAMBDA ' +'(' + sexprs.AsStringVisitor.pairToString1(self.arguments) + ')' + ' '\
                    + str(self.body) + ')'

    def visitLambdaSimple(self):
        return '(LAMBDA ' +'(' + sexprs.AsStringVisitor.pairToString1(self.arguments) + ')' + ' '\
                          + str(self.body) + ')'

    def visitLambdaOpt(self):
        return '(LAMBDA ' +'(' + sexprs.AsStringVisitor.pairToString1(self.arguments) + ')' + ' '\
                          + str(self.body) + ')'

    def visitLambdaVar(self):
        return '(LAMBDA ' + str(self.arguments) +  ' ' + str(self.body) + ')'

    def visitApplic(self):
        if isinstance(self.arguments,sexprs.Nil):
            return '(' + str(self.applic) + ')'
        else:
            return '(' + str(self.applic) + ' '\
                    + sexprs.AsStringVisitor.pairToString(self.arguments) + ')'

    def visitApplicTP(self):
        if isinstance(self.obj.arguments,sexprs.Nil):
            return '(' + str(self.obj.applic) + ')'
        else:
            return '(' + str(self.obj.applic) + ' '\
                    + sexprs.AsStringVisitor.pairToString(self.obj.arguments) + ')'

    def visitOr(self):
        if isinstance(self.arguments,sexprs.Nil):
            return '(OR)'
        else:
            return '(OR ' + sexprs.AsStringVisitor.pairToString(self.arguments) + ')'


    def visitDef(self):
        return '(DEFINE ' + str(self.name) + ' ' + str(self.expr) + ')'

################################################################

class ApplicTP(AbstractSchemeExpr):
    def __init__(self,expr):
        self.obj = expr

    def accept(self,visitor):
        return visitor.visitApplicTP(self)

    def generate(self, visitor):
        return visitor.codeGenApplicTP(self)

# Visitor design pattern
class AnnotateVisitor(AbstractSchemeExpr):

    def visitAnnotateConstant(self,inTp):
        return self

    def visitAnnotateVariable(self,inTp):
        return self

    def visitAnnotateIfThenElse(self,inTp):
        self.pair.sexpr1 = self.pair.sexpr1.annotateTC(False)
        annotatePairs(self.pair.sexpr2,inTp)
        return self

    def visitAnnotateLambdaSimple(self,inTp):
        self.body = self.body.annotateTC(True)
        return self
    
    def visitAnnotateLambdaOpt(self,inTp):
        self.body = self.body.annotateTC(True)
        return self
    
    def visitAnnotateLambdaVar(self,inTp):
        self.body = self.body.annotateTC(True)
        return self
    
    def visitAnnotateApplic(self,inTp):
        self.applic = self.applic.annotateTC(False)
        # maybe should use left flatting
        #annotatePairs(self.arguments,False)
        bound = self.arguments

        while isinstance(bound,sexprs.Pair):
            bound.sexpr1 = bound.sexpr1.annotateTC(False)
            if isinstance(bound.sexpr2,sexprs.Nil):
                break
            bound = bound.sexpr2

        if inTp is False:   return self
        if inTp is True :   return ApplicTP(self)

    def visitAnnotateOr(self,inTp):
        bound = self.arguments

        while isinstance(bound,sexprs.Pair):
      #      bound.sexpr1 = parserRecursive(bound.sexpr1)
            if isinstance(bound.sexpr2,sexprs.Nil):
                bound.sexpr1 = bound.sexpr1.annotateTC(inTp)
                break
            bound.sexpr1 = bound.sexpr1.annotateTC(False)
            bound = bound.sexpr2

        return self
                    
    def visitAnnotateDef(self,inTp):
        self.expr = self.expr.annotateTC(False)
        return self

def annotatePairs(self,inTp):
    if isinstance(self.sexpr2, sexprs.Nil):                #proper list end tree
        self.sexpr1 = self.sexpr1.annotateTC(inTp)
    else:
        if isinstance(self.sexpr2, sexprs.Pair):
            #recursive call
            self.sexpr1 = self.sexpr1.annotateTC(inTp)
            annotatePairs(self.sexpr2,inTp)
        else:
            #impreper list end tree
            self.sexpr1 = self.sexpr1.annotateTC(inTp)
            self.sexpr2 = self.sexpr2.annotateTC(inTp)

################################################################

class CodeGenVisitor(AbstractSchemeExpr):
    def codeGenConstant(self):
        global memoryTable
        global mem0
        result = ""
        if type(self.constant) is sexprs.Boolean:
            if self.constant.value.__eq__('f'):
                return appendTabs() + "MOV(R0,IMM(3));\n"
            else:
                return appendTabs() + "MOV(R0,IMM(5));\n"

        elif type(self.constant) is sexprs.Nil:
            return appendTabs() + "MOV(R0,IMM(2));\n"

        elif type(self.constant) is sexprs.Int:
            if self.constant.sign:
                if self.constant.sign.__eq__('-'):
                    integer = 0 - int(self.constant.number)
                else:
                    integer = int(self.constant.number)
            else:
                integer = int(self.constant.number)

            integerKey = "%s" %integer
            if memoryTable.get(integerKey) is None:
                memoryTable.update( { integerKey : [ mem0 , ['T_INT',integer] ] } )
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %mem0
                mem0 += 2
            else:
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %memoryTable.get(integerKey)[0]

            return result

        elif type(self.constant) is sexprs.Fraction:
            sign = self.constant.num.sign
            int1 = self.constant.num.number
            int2 = self.constant.denom.number
            divider = gcd(int1,int2)

            if divider > 1:
                if divider == int2:
                    newInt = int1/int2
                    result += Constant(sexprs.Int(sign,newInt)).code_gen()
                    return result
                else:
                    int1 = int(int1/divider)
                    int2 = int(int2/divider)
                    newFrac = sexprs.Fraction(sexprs.Int(sign,int1),sexprs.Int('+',int2))
            else:
                newFrac = self.constant

            newFracName = '%s' %newFrac
            if newFrac.num.sign.__eq__('-'):
                num = 0 - newFrac.num.number
            else:
                num = newFrac.num.number

            denom = newFrac.denom.number

            if memoryTable.get(newFracName) is None:
                memoryTable.update( { newFracName : [ mem0 , ['T_FRACTION',num,denom] ] } )
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %mem0
                mem0 += 3
            else:
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %memoryTable.get(newFracName)[0]

            return result

        elif type(self.constant) is sexprs.String:
            string = self.constant.string
            if memoryTable.get(string) is None:
                value = ['T_STRING',len(string)]
                value.extend(reversed(list(string)))
                memoryTable.update( { string : [ mem0 , value ] } )
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %mem0
                mem0 += (2 + len(string))
            else:
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %memoryTable.get(string)[0]

            return result

        elif type(self.constant) is sexprs.Char:
            value = self.constant.value
            if memoryTable.get(value) is None:
                memoryTable.update( { value : [ mem0 , ['T_CHAR' , value] ] } )
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %mem0
                mem0 += 2
            else:
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %memoryTable.get(value)[0]

            return result

        elif type(self.constant) is sexprs.Pair:
            value = self.constant.sexpr2.sexpr1
            # Handle Vector
            if type(value) is sexprs.Vector:
                CodeGenVisitor.codeGenPair(value.sexpr)
                pairPtr = mem0 - 3
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %pairPtr
            # Handle Symbol
            elif type(value) is sexprs.Symbol:
                result += CodeGenVisitor.codeGenSymbol(value.string.lower(),"'%s" %value.string)
                result += appendTabs() + "MOV(R0,INDD(R0,2));\n"
            # Handle List
            else:
                CodeGenVisitor.codeGenPair(value)
                pairPtr = mem0 - 3
                result += appendTabs() + 'MOV(R0,IMM(%s));\n' %pairPtr
            return result
        else:
            raise SyntaxErrorException("no such constant %s" %self)      # for debug purpose

    @staticmethod
    def codeGenPair(value):
        global memoryTable
        global mem0
        constantList = CodeGenVisitor.topologicalSort(value)
        index = 0
        while len(constantList) > 1:
            node = constantList[index]
            if type(node) is sexprs.Pair:
                first = constantList[index - 1]
                second = constantList[index - 2]
                if type(first) is sexprs.Nil:
                    car = "nil"
                elif type(first) is sexprs.Symbol:
                    car = "bucket_'%s" %first
                else:
                    car = "%s" %first

                if type(second) is sexprs.Nil:
                    cdr = "nil"
                elif type(second) is sexprs.Symbol:
                    cdr = "bucket_'%s" %second
                else:
                    cdr = "%s" %second

                nodeName = "%s" %node

                memoryTable.update( { nodeName : [ mem0,
                                                            ['T_PAIR',
                                                             memoryTable.get(car)[0],
                                                             memoryTable.get(cdr)[0]] ] } )
                mem0 += 3

                constantList.remove(first)
                constantList.remove(second)
                index -= 1

            elif type(node) is sexprs.Symbol:
                index += 1
                CodeGenVisitor.codeGenSymbol(node.string,"'%s" %node.string)
            else:
                index += 1
                Constant(node).code_gen()

    # this is a static method in order to assist the generate symbol's code
    @staticmethod
    def codeGenSymbol(name,value):      # if Symbol is a constant value = symbol_value else value = 0
        global memoryTable
        global mem0
        symbol = "'%s" %name
        bucketName = "bucket_%s" %symbol
        result = ""
        if memoryTable.get(symbol) is None:
            Constant(sexprs.String(name)).code_gen()                # (*)
            stringPtr = memoryTable.get(name)[0]                    # the pointer of the string created in (*)
            memoryTable.update( { bucketName : [ mem0 , ['T_BUCKET',stringPtr, value] ]})
            bucketPtr = mem0                                        # the pointer to bucket
            mem0 += 3
            memoryTable.update( { symbol : [ mem0 , ['T_SYMBOL', bucketPtr] ] })
            result += appendTabs() + "MOV(R0,IMM(%s));\n" %mem0
            mem0 += 2
        else:
            result += appendTabs() + "MOV(R0,IMM(%s));\n" %memoryTable.get(symbol)[0]

        result += appendTabs() + "MOV(R0,INDD(R0,1));\n"
        return result

    @staticmethod
    def topologicalSort(exp):
        if type(exp) is sexprs.Pair:
            car = CodeGenVisitor.topologicalSort(exp.sexpr1)
            cdr = CodeGenVisitor.topologicalSort(exp.sexpr2)
            resultList = []
            resultList.extend(cdr)
            resultList.extend(car)
            resultList.append(exp)
            return resultList
        else:
            return [exp]

    def codeGenVarFree(self):
        symbol = "'%s" %self.variable.string.lower()
        name = self.variable.string.lower()
        # if freeVar was defined then R0<-closure
        if not memoryTable.get(symbol) is None:
            symbolPtr = memoryTable.get(symbol)[0]
            code = appendTabs() + "MOV(R0,IMM(%s));\n" %symbolPtr
            code += appendTabs() + "MOV(R0,INDD(R0,1));\n"
            code += appendTabs() + "MOV(R0,INDD(R0,2));\n"

        # if freeVar is a builtin procedure, create the closure and return result in R0
        # (happens only once for each builtin procedure, after that it is in the constant table)
        elif name in reservedWordsSymbolTable:
            label = reservedWordsSymbolTable.get(name)
            code = CodeGenVisitor.addCodeForBuiltInProcedures(name,label)

        # if variable wasn't defined nor a builtin procedure
        else:
            raise compiler.CompilationError("- Variable %s in not bound" %name)

        return appendTabs() + code

    @staticmethod
    def addCodeForBuiltInProcedures(name,label):
        code = CodeGenVisitor.codeGenSymbol(name,0)
        code += \
        """
        /* R0 now holds the pointer to the symbol's bucket */
        PUSH(R1);
        /* backup R1 in order to use it */
        MOV(R1,R0);
        /* R1 now holds the pointer to the symbol's bucket */
        """
        code += appendTabs() + "PUSH(LABEL(%s));\n" %label
        code += \
        """
        /* push the "empty" environment for free vars */
        PUSH(0);
        CALL (MAKE_SOB_CLOSURE);
        DROP(2);
        /* R0 now holds the pointer to the closure */
        MOV(INDD(R1,2),R0);
        /* save the closure as the value in symbol's bucket */
        POP(R1)
        /* restore R1 to be what it was before */
        """
        return code

    def codeGenVarParam(self):
        offset = self.minor + 2
        return "MOV(R0,FPARG(%s));\n" %offset

    def codeGenVarBound(self):
        code = "MOV(R0,FPARG(0))" #env
        code += "MOV(R0,INDD(R0,%s)" %self.major
        code += "MOV(R0,INDD(R0,%s)" %self.minor
        return code

    def codeGenIfThenElse(self):
        result = ""
        test = self.pair.sexpr1.code_gen()
        result += test
        result += appendTabs() + "CMP(R0, BOOL_FALSE);\n"
        result += appendTabs() + "JUMP_EQ(L_DIF_%s);\n" %LabelGenerator.getLabel()
        dit = self.pair.sexpr2.sexpr1.code_gen()
        result += dit
        result += appendTabs() + "JUMP(L_END_IF_%s);\n" %LabelGenerator.getLabel()
        result += appendTabs() + "L_DIF_%s:\n" %LabelGenerator.getLabel()
        dif = self.pair.sexpr2.sexpr2.sexpr1.code_gen()
        result+= dif
        result += appendTabs() + "L_END_IF_%s:\n" %LabelGenerator.getLabel()

        LabelGenerator.nextLabel()
        return result

    def codeGenLambdaSimple(self):
        code = CodeGenVisitor.environmentExpansionCodeGen(self)

        # Label B of LambdaSimple
        code += "\tL_CLOS_CODE_%s:\n" %LabelGenerator.getLabel()
        code += appendTabs() + "PUSH(FP);\n"
        code += appendTabs() + "MOV(FP,SP);\n"
        code += appendTabs() + "PUSH(R1);\n"
        code += appendTabs() + "MOV(R1,IMM(%s));\n" %self.numOfArgs
        code += appendTabs() + "CMP(R1,FPARG(1));\n"
        code += appendTabs() + "JUMP_EQ(L_error_not_enough_params_given);\n"
        code += self.body.code_gen()
        code += appendTabs() + "POP(R1);\n"
        code += appendTabs() + "POP(FP);\n"
        code += appendTabs() + "RETURN;\n"

        code += "\tL_CLOS_EXIT_%s:\n" %LabelGenerator.getLabel()
        LabelGenerator.nextLabel()
        return code

    def codeGenLambdaOpt(self):
        # Environment expansion
        code = CodeGenVisitor.environmentExpansionCodeGen(self)
        # Label B of LambdaOPT
        code += CodeGenVisitor.stackFixForLambda(self)
        LabelGenerator.nextLabel()
        return code

    def codeGenLambdaVar(self):
        # Environment expansion
        code = CodeGenVisitor.environmentExpansionCodeGen(self)
        # Label B of LambdaVar
        code += CodeGenVisitor.stackFixForLambda(self)
        LabelGenerator.nextLabel()
        return code

    @staticmethod
    def environmentExpansionCodeGen(lambdaExp):
        code = appendTabs() + "MOV(R1,IMM(%s));\n" %lambdaExp.depth
        code += appendTabs() + "CMP(R1,IMM(0));\n"
        code += appendTabs() + "JUMP_EQ(L_After_Env_Expansion_%s);\n" %LabelGenerator.getLabel()
        code += \
    """
        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(IMM(R1));
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        int i,j;
        for(i=0,j=1 ; i < IMM(R3) ; ++i,++j)
        {
             MOV(INDD(R1,j),INDD(R2,i));
        }
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(IMM(R3));
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        for(i=0,j=2 ; i < IMM(R3) ; ++i,++j)
        {
             MOV(INDD(R0,i),FPARG(j));
        }
        MOV(IND(R1),R0);             /* move the params to new env before calling make_sob_closure */
    """
        code += "\n\tL_After_Env_Expansion_%s:\n" %LabelGenerator.getLabel()
        code += appendTabs() + "PUSH(LABEL(L_CLOS_CODE_%s));\n" %LabelGenerator.getLabel() #push the label of the lambda's body
        code += appendTabs() + "PUSH(R1);\n"                                               #push the new env
        code += appendTabs() + "CALL(MAKE_SOB_CLOSURE);\n"
        code += appendTabs() + "DROP(2);\n"
        code += appendTabs() + "JUMP(L_CLOS_EXIT_%s);\n" %LabelGenerator.getLabel()

        return code

    @staticmethod
    def stackFixForLambda(lambdaExp):
        code = "\n\tL_CLOS_CODE_%s:\n" %LabelGenerator.getLabel()
        code += appendTabs() + "PUSH(FP);\n"
        code += appendTabs() + "MOV(FP,SP);\n"

        # stack fix
        code += appendTabs() + "MOV(R1,FPARG(1));\n"
        code += appendTabs() + "ADD(R1,IMM(1));\n"         # holds the num of params in stack

        code += appendTabs() + "int numOfArgs = %s;\n" %(lambdaExp.numOfArgs + 1)

        code += \
        """
        MOV(R2,numOfArgs);
        SUB(R2,IMM(2));
        MOV(R3,R1);
        DECR(R3);
        CMP(R2,R3);             /* compare between num of arg in lambda and num of params in stack */
        """
        code += "JUMP_EQ(L_Stack_Fix_Up_%s);\n" %LabelGenerator.getLabel()
        code += appendTabs() + "JUMP_LT(L_Stack_Fix_Down_%s);\n" %LabelGenerator.getLabel()
        code += appendTabs() + "JUMP(L_error_not_enough_params_given);\n"

        code += "\n\tL_Stack_Fix_Down_%s:\n" %LabelGenerator.getLabel()

        code += appendTabs() + "PUSH(IMM(2));\n"           # pushing nil on stack
        code += appendTabs() + "PUSH(FPARG(R1));\n"        # pushing last param in stack
        code += appendTabs() + "CALL(MAKE_SOB_PAIR);\n"    # R0 holds the last pair
        code += appendTabs() + "DROP(2);\n"

        code += \
        """
        for(i = R1-1 ; i >= numOfArgs ; --i)
        {
            PUSH(R0);
            PUSH(FPARG(i));
            CALL(MAKE_SOB_PAIR);
            DROP(2);
        }

        MOV(FPARG(numOfArgs),R0);

        INCR(R2);                       /* R2 contains number of params */
        MOV(FPARG(1),R2);               /* update the number of parameters on stack */

        /* drop the relevant elements to the buttom of the stack */
        while(numOfArgs >= -2)
        {
            MOV(FPARG(R1),FPARG(numOfArgs));
            DECR(R1);
            numOfArgs-- ;
        }
        SUB(R3,R2);
        SUB(SP,R3);						/* stack pointer needs to down as well */

        """
        code += "JUMP(L_After_Stack_Fix_%s);\n" %LabelGenerator.getLabel()

        code += "\tL_Stack_Fix_Up_%s:\n" %LabelGenerator.getLabel()
        code += \
        """
        INCR(R2);                       /* contains the num of args */
        INCR(FPARG(1));                 /* increment the number of params in stack by 1 */
        INCR(SP);						/* stack pointer needs to go up by 1 */

		for(i = -2 , j = -3 ; i <= R1 ; i++,j++)
        {
			MOV(FPARG(j),FPARG(i));
        }
		MOV(FPARG(i),IMM(7109179));				/* magic number */

"""

        code += "\tL_After_Stack_Fix_%s:\n" %LabelGenerator.getLabel()
        code += lambdaExp.body.code_gen()
        code += appendTabs() + "POP(FP);\n"
        code += appendTabs() + "RETURN;\n"
        code += "\tL_CLOS_EXIT_%s:\n" %LabelGenerator.getLabel()

        return code

    def codeGenApplic(self):
        result = ""
        argsList = list(reversed(pairsToList(self.arguments)))

        for arg in argsList:
            argi = arg.code_gen()
            result += argi
            result += appendTabs() + "PUSH(R0);\n"

        result += appendTabs() + "PUSH(IMM(%s));\n" %len(argsList) # num of parameters

        proc = self.applic.code_gen()
        result += proc
        result += appendTabs() + "CMP (IND(R0), T_CLOSURE);\n"
        result += appendTabs() + "JUMP_NE(L_error_not_a_closure);\n"

        result += appendTabs() + "PUSH (INDD(R0,1));\n"  # env
        result += appendTabs() + "CALLA(INDD(R0,2));\n"  # jumps to closure's code and returns here
        result += appendTabs() + "DROP(1);\n"  # drops the env from stack
        result += appendTabs() + "POP(R1);\n"  # get the number of params from stack to R1
        result += appendTabs() + "DROP(R1);\n" # clear the stack

        return result

    def codeGenApplicTP(self):
        code = self.obj.code_gen()
        return code
    #     result = ""
    #     argsList = list(reversed(pairsToList(self.arguments)))
    #
    #     for arg in argsList:
    #         argi = arg.code_gen()
    #         result += argi
    #         result += appendTabs() + "PUSH(R0);\n"
    #
    #     result += appendTabs() + "PUSH(IMM(%s))" %len(argsList)
    #
    #     proc = self.applic.code_gen()
    #     result += proc
    #     result += appendTabs() + "CMP (IND(R0), T_CLOSURE);\n"
    #     result += appendTabs() + "JUMP_NE(L_error_not_a_closure);\n"
    #     result += appendTabs() + "PUSH (INDD(R0,1));\n"  # env
    #     result += appendTabs() + "PUSH (FPARG(0));\n"
    #     result += appendTabs() + "MOV (R1, FP);\n" # R1 <- old fp
    #     # for(){...} override old frame
    #     result += appendTabs() + "MOV FP, R1);\n"
    #     result += appendTabs() + "JUMP(INND(R0,2));\n"
    #
    #     return result

    def codeGenOr(self):
        code = ""
        argsList = pairsToList(self.arguments)
        if argsList:
            for arg in argsList[:-1]:
                argi = arg.code_gen()
                code += argi
                code += "CMP(R0, BOOL_FALSE);\n"
                code += "JUMP_NE(L_EXIT_%s);\n" %LabelGenerator.getLabel()
            code += argsList[-1].code_gen()
        else:
            code += appendTabs() + "MOV(R0,IMM(3));\n"
        code += "L_EXIT_%s:\n" %LabelGenerator.getLabel()
        LabelGenerator.nextLabel()
        return code

    def codeGenDef(self):
        code = self.expr.code_gen()
        # info = code.split('\n')
        # print(info[-2])

        code += appendTabs() + "MOV(R1,R0);     /*Saving expression address*/\n"
        code += CodeGenVisitor.codeGenSymbol(self.name.variable.string.lower(),0)

        # R0 now contains the pointer to the value of the symbol's bucket
        code += \
        """
        /* add the expression's value from R1 to the bucket */
        MOV(INDD(R0,2), R1);
        /* return #void to user */
        MOV(R0, IMM(1));
        """
        return code