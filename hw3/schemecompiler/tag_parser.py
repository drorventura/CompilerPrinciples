import sexprs
import itertools

__author__ = 'Dror & Eldar'

##############################
#           Macros           #
##############################
# matched strings for Constants
Constants_Strings = {"Boolean" , "Int" , "Char" , "Fraction", "String", "Nil"}

# for now not in use
Reserved_Words =  {"AND" ,"BEGIN", "COND" ,"DEFINE" ,"DO" ,"ELSE", "IF" ,
                     "LAMBDA" ,"LET" ,"LET*" ,"LETREC" ,"OR" ,"QUOTE", "SET!"}

QuotedLike_Strings = {"QUOTE" , "QUASIQUOTE" , "UNQUOTE-SPLICING" , "UNQUOTE"}

##############################
#           Gensym           #
##############################
n = 0
class Gensym:
    @staticmethod
    def generate():
        global n
        n = n + 1
        return '&' + '%s' %n + '%s' %(n*n) + '@'

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
                    return  sexprs.Pair([parserRecursiveForLambda(expr.sexpr1),\
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
        raise SyntaxError(expr)

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
        raise SyntaxError

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
                if isinstance(temp_args.sexpr2,sexprs.Nil) and\
                        isinstance(temp_args.sexpr1,sexprs.Pair):
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
        raise SyntaxError("In Let Parameters Bound Are Empty")

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
        raise SyntaxError("In Let Parameters Bound Are Empty")

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
                ['.',sexprs.Pair(sum([[head.sexpr2.sexpr1],\
                    ['.',sexprs.Pair([expandQQ(tail)])]],[]))]],[]))

        elif isinstance(tail,sexprs.Pair) and\
                tail.sexpr1 == "UNQUOTE-SPLICING":
            return sexprs.Pair(sum([[sexprs.Symbol('CONS',4)],
                                ['.',sexprs.Pair(sum([[expandQQ(head)],
                                             ['.',sexprs.Pair[expr.sexpr2.sexpr1]]],[]))]],[]))
        else:
            return sexprs.Pair(sum([[sexprs.Symbol('CONS',4)],
                                ['.',sexprs.Pair(sum([[expandQQ(head)],
                                             ['.',sexprs.Pair([expandQQ(tail)])]],[]))]],[]))
    elif isinstance(expr,sexprs.Vector):
        return sexprs.Pair(sum([[sexprs.Symbol('LIST->VECTOR',12)], ['.',sexprs.Pair([expandQQ(expr)])]],[])) # may be need last arg

    elif isinstance(expr,sexprs.Nil) or\
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

class SyntaxError(Exception):
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
            return self

# Constant Class
class Constant(AbstractSchemeExpr):
    def __init__(self,constant):
        self.constant = constant

    def accept(self, visitor):
        return visitor.visitConstant(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateConstant(self,inTp)

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
        Variable.__init__(variable)

    def accept(self, visitor):
        return visitor.visitVariable(self)

class VarParam(Variable):
    def __init__(self, variable, minor):
        Variable.__init__(variable)
        self.minor = minor

    def accept(self, visitor):
        return visitor.visitVariable(self)

class VarBound(Variable):
    def __init__(self, variable,major, minor):
        Variable.__init__(variable)
        self.major = major
        self.minor = minor

    def accept(self, visitor):
        return visitor.visitVariable(self)

# IfThenElse Class
class IfThenElse(AbstractSchemeExpr):
    def __init__(self,condition,than,alternative):
        self.pair = sexprs.Pair([condition,than,alternative])

    def accept(self, visitor):
        return visitor.visitIfThenElse(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateIfThenElse(self,inTp)

# AbstractLambda Class
class AbstractLambda(AbstractSchemeExpr):
    def __init__(self):
        print("blank")

    def accept(self, visitor):
        return visitor.visitAbstractLambda(self)

# LambdaSimple Class
class LambdaSimple(AbstractLambda):
    def __init__(self,arguments,body):
        self.arguments = arguments
        self.body = body

    def accept(self, visitor):
        return visitor.visitAbstractLambda(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateLambdaSimple(self,inTp)

# LambdaOpt Class
class LambdaOpt(AbstractLambda):
    def __init__(self,arguments,body):
        self.arguments = arguments
        self.body = body

    def accept(self,visitor):
        return visitor.visitLambdaOpt(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateLambdaOpt(self,inTp)

# LambdaVar Class
class LambdaVar(AbstractLambda):
    def __init__(self,arguments,body):
        self.arguments = arguments
        self.body = body

    def accept(self,visitor):
        return visitor.visitLambdaVar(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateLambdaVar(self,inTp)

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

# Or Class
class Or(AbstractSchemeExpr):
    def __init__(self,arguments):
        iter = arguments
        while isinstance(iter,sexprs.Pair):
            iter.sexpr1 = parserRecursive(iter.sexpr1)
            iter = iter.sexpr2

        self.arguments = arguments

    def accept(self,visitor):
        return visitor.visitOr(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateOr(self,inTp)

# Def Class
class Def(AbstractSchemeExpr):
    def __init__(self,name,expr):
        self.name = name
        self.expr = expr

    def accept(self,visitor):
        return visitor.visitDef(self)
    
    def annotate(self,visitor,inTp):
        return visitor.visitAnnotateDef(self,inTp)

# Visitor design pattern
class AsStringVisitor(AbstractSchemeExpr):

    def visitConstant(self):
        if isinstance(self.constant,sexprs.String):
            return '"' + str(self.constant) + '"'
        if not isinstance(self.constant , sexprs.Nil):
            return str(self.constant)
        else:
            return ''

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

##########################

class ApplicTP(Applic):
    def __init__(self,expr):
        self.obj = expr

    def accept(self,visitor):
        return visitor.visitApplicTP(self)

# Visitor design pattern
class AnnotateVisitor(AbstractSchemeExpr):

    def visitAnnotateConstant(self,inTp):
        return self.constant

    def visitAnnotateVariable(self,inTp):
        return self.variable

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
