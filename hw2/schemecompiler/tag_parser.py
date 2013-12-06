import sexprs
import itertools

__author__ = 'Dror & Eldar'

##############################
#           Macros           #
##############################
# matched strings for Constants
Constants_Strings = {"Boolean" , "Int" , "Char" , "Fraction", "String", "Nil"}

# for now not in use
Reserveds_Words =  {"AND" ,"BEGIN", "COND" ,"DEFINE" ,"DO" ,"ELSE", "IF" ,
                     "LAMBDA" ,"LET" ,"LET*" ,"LETREC" ,"OR" ,"QUOTE", "SET!"}

QuotedLike_Strings = {"QUOTE" , "QUASIQUOTE" , "UNQUOTE-SPLICING" , "UNQUOTE"}

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
            return tagVector(expr)

        elif className in Constants_Strings:
            return tagConstant(expr)
    
def tagPair(expr):
    print('in tagPair')

    if isinstance(expr.sexpr1, sexprs.Symbol):
        # Identify: Quoted Like Strings
        if expr.sexpr1.string in QuotedLike_Strings:                # Pair(Symbol(QuoteLike), Pair(Sexpression, Nil) )
            print("creating Constant: " + str(expr.sexpr2.sexpr1))
            return Constant(parserRecursive(expr.sexpr2.sexpr1))    # This case handles only the Sexpression above

        elif expr.sexpr1.string == "IF":
            print('if was detected')
            return tagIf(expr.sexpr2)

        elif expr.sexpr1.string == "COND":
            return tagCond(expr.sexpr2)

        # Identify: DEFINE 
        elif expr.sexpr1.string == "DEFINE":
            return "DEFINE core"

        # Identify: LAMBDA
        elif expr.sexpr1.string == "LAMBDA":
            return tagLambda(expr.sexpr2)
        
        # Identify: APPLICATION
        else:
            return tagApplic(expr)

        # Handling Variables FIXME
        #else:
        #    if isinstance(expr.sexpr1 , sexprs.Symbol) and isinstance(expr.sexpr2, sexprs.Symbol):
        #        return  ['.' , sexprs.Pair([parserRecursive(expr.sexpr1),'.',parserRecursive(expr.sexpr2)])]
        #    else:
        #        if isinstance(expr.sexpr2,sexprs.Pair) and isinstance(expr.sexpr2.sexpr1, sexprs.Symbol) and isinstance(expr.sexpr2.sexpr2, sexprs.Symbol):
        #        # senfing to pair const. with list of lists, to work with sum  
        #            list_to_be_flatten = [[parserRecursive(expr.sexpr1)],parserRecursive(expr.sexpr2)]
        #            if list_to_be_flatten[1][0] == '.':
        #                return  sexprs.Pair(sum(list_to_be_flatten,[]))
        #        else:
        #            return  sexprs.Pair([parserRecursive(expr.sexpr1),parserRecursive(expr.sexpr2)])
    else: 
        return sexprs.Pair([parserRecursive(expr.sexpr1), parserRecursive(expr.sexpr2)])

##########################################
#           Special For LAMBDA           #
##########################################
def parserRecursiveForLambda(expr):
        className = expr.__class__.__name__
        
        if className ==   "Pair":
            return tagPairLambda(expr)
    
        elif className == "Symbol":
            return Variable(expr)
    
        elif className == "Vector":
            return tagVector(expr)

        elif className in Constants_Strings:
            return tagConstant(expr)
    
def tagPairLambda(expr):
    print('in tagPairLambda')

    if isinstance(expr.sexpr1, sexprs.Symbol):
        # Identify: Quoted Like Strings
        if expr.sexpr1.string in QuotedLike_Strings:                # Pair(Symbol(QuoteLike), Pair(Sexpression, Nil) )
            print("creating Constant: " + str(expr.sexpr2.sexpr1))
            return Constant(parserRecursive(expr.sexpr2.sexpr1))    # This case handles only the Sexpression above

        elif expr.sexpr1.string == "IF":
            print('if was detected')
            return tagIf(expr.sexpr2)

        elif expr.sexpr1.string == "COND":
            return tagCond(expr.sexpr2)

        # Identify: DEFINE 
        elif expr.sexpr1.string == "DEFINE":
            return "DEFINE core"

        # Identify: LAMBDA
        elif expr.sexpr1.string == "LAMBDA":
            return tagLambda(expr.sexpr2)
        
        # Handling Variables
        else:
            if isinstance(expr.sexpr1 , sexprs.Symbol) and isinstance(expr.sexpr2, sexprs.Symbol):
                return  ['.' , sexprs.Pair([parserRecursive(expr.sexpr1),'.',parserRecursive(expr.sexpr2)])]
            else:
                if isinstance(expr.sexpr2,sexprs.Pair) and isinstance(expr.sexpr2.sexpr1, sexprs.Symbol) and isinstance(expr.sexpr2.sexpr2, sexprs.Symbol):
                # senfing to pair const. with list of lists, to work with sum  
                    list_to_be_flatten = [[parserRecursive(expr.sexpr1)],parserRecursive(expr.sexpr2)]
                    if list_to_be_flatten[1][0] == '.':
                        return  sexprs.Pair(sum(list_to_be_flatten,[]))
                else:
                    return  sexprs.Pair([parserRecursive(expr.sexpr1),parserRecursive(expr.sexpr2)])
    else: 
        return sexprs.Pair([parserRecursive(expr.sexpr1), parserRecursive(expr.sexpr2)])
#END#########################################

def tagVariable(expr):
    print('in tagVariable')
    return Variable(expr)

def tagVector(expr):
    print('in tagVector')
    return str(sexprs.Vector(expr))

def tagConstant(expr):
    print('in tagConstant')
    return Constant(expr)

def tagIf(expr):
    try:
        if isinstance(expr.sexpr2.sexpr2, sexprs.Nil):
            return IfThenElse(parserRecursive(expr.sexpr1),         # Condition
                              parserRecursive(expr.sexpr2.sexpr1),  # Than
                              Constant(sexprs.Void()))              #Void
        else:
            return IfThenElse(parserRecursive(expr.sexpr1),         # Condition
                              parserRecursive(expr.sexpr2.sexpr1),  # Than
                              parserRecursive(expr.sexpr2.sexpr2))  # Else
    except:
        raise NotEnoughParameters('expected: (if <condition> <than> <alternative>) or (if <condition> <than>')

def tagCond(expr):
    try:
        if isinstance(expr, sexprs.Nil):                                    # when there is no else-clause
            return sexprs.Void()
        elif isinstance(expr.sexpr1.sexpr1, sexprs.Symbol) and expr.sexpr1.sexpr1.string == 'ELSE':
            return parserRecursive(expr.sexpr1.sexpr2)                      # when last clause is else# when last clause is else
        else:
            return IfThenElse(parserRecursive(expr.sexpr1.sexpr1),          # Condition - Ti
                              parserRecursive(expr.sexpr1.sexpr2),          # Than - Ei
                              tagCond(expr.sexpr2))                         # Recursive Alternative Ti+1
    except:
        raise SyntaxError(expr)

def tagLambda(expr):
    arguments = parserRecursiveForLambda(expr.sexpr1)
    if isinstance(arguments,list):
        arguments = arguments[1]
    body      = parserRecursive(expr.sexpr2)
    temp_args = arguments

    # Lambda Variadic 
    if isinstance(arguments, Variable):
        return LambdaVar(arguments,body)

    while not isinstance(temp_args.sexpr1, type(temp_args.sexpr2)):
        if not isinstance(temp_args.sexpr2,Constant):
            temp_args = temp_args.sexpr2
            
            if isinstance(temp_args,sexprs.Nil):
                return LambdaSimple(arguments,body)

            if isinstance(temp_args.sexpr1 , Variable) and isinstance(temp_args.sexpr2, Variable):
                return LambdaOpt(arguments,body)
        else:
            break

    # Lambda Optional
            # differ between (a . b) to (a (b Nil())
    if isinstance(temp_args.sexpr1, Variable) and isinstance(temp_args.sexpr2, Variable):
        return LambdaOpt(arguments,body)

    # Lambda Simple
    return LambdaSimple(arguments,body)

def tagApplic(applic):
    app = applic.sexpr1
    arguments = applic.sexpr2
    return Applic(app,arguments)




##############################
#       Exceptions           #
##############################

class OverWritingReservedWords(Exception):
    def __init__(self,expr):
        Exception.__init__(self,str(expr))

class lambdaArgumentsIsNotVariable(Exception):
    def __init__(self,expr):
        Exception.__init__(self,str(expr))

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

    @staticmethod
    def parse(string):
        expr , remaining = sexprs.AbstractSexpr.readFromString(string)
        return parserRecursive(expr) , remaining

# Constant Class
class Constant(AbstractSchemeExpr):
    def __init__(self,constant):
        self.constant = constant

    def accept(self, visitor):
        return visitor.visitConstant(self)

# Variable Class
class Variable(AbstractSchemeExpr):
    def __init__(self,variable):
        print("in Variable")
        self.variable = variable

    def accept(self, visitor):
        return visitor.visitVariable(self)

# IfThenElse Class
class IfThenElse(AbstractSchemeExpr):
    def __init__(self,condition,than,alternative):
        self.pair = sexprs.Pair([condition,than,alternative])

    def accept(self, visitor):
        return visitor.visitIfThenElse(self)

# AbstractLambda Class
class AbstractLambda(AbstractSchemeExpr):
    def __init__(self):
        print("in AbstractLambda")

    def accept(self, visitor):
        return visitor.visitAbstractLambda(self)

# LambdaSimple Class
class LambdaSimple(AbstractLambda):
    def __init__(self,arguments,body):
        print("in LambdaSimple")
        self.arguments = arguments
        self.body = body

    def accept(self, visitor):
        return visitor.visitLambdaSimple(self)

# LambdaOpt Class
class LambdaOpt(AbstractLambda):
    def __init__(self,arguments,body):
        print("in LambdaOpt")
        self.arguments = arguments
        self.body = body

    def accept(self,visitor):
        return visitor.visitLambdaOpt(self)

# LambdaVar Class
class LambdaVar(AbstractLambda):
    def __init__(self,arguments,body):
        print("in LambdaVar")
        self.arguments = arguments
        self.body = body

    def accept(self,visitor):
        return visitor.visitLambdaVar(self)

# Applic Class
class Applic(AbstractSchemeExpr):
    def __init__(self,applic,arguments):
        print("in Applic")
        self.applic = applic
        self.arguments = arguments

    def accept(self,visitor):
        return visitor.visitApplic(self)

# AbstractNumber Class
class AbstractNumber(AbstractSchemeExpr):
    def __init__(self):
        print("AbstractNumber class")

    def accept(self,visitor):
        return self.accept(self,visitor)

# Or Class
class Or(AbstractNumber):
    def __init__(self):
        print("in Or")

    def accept(self,visitor):
        return visitor.visitOr(self)

# Def Class
class Def(AbstractNumber):
    def __init__(self):
        print("in Def")

    def accept(self,visitor):
        return visitor.visitDef(self)

# Visitor design pattern
class AsStringVisitor(AbstractSchemeExpr):

    def visitConstant(self):
        if not isinstance(self.constant , sexprs.Nil):
            return str(self.constant)
        else:
            return ''

    def visitVariable(self):
        print('Variable toString')
        return str(self.variable)

    def visitIfThenElse(self):
        return '(if ' + str(self.pair.sexpr1) + ' ' + str(self.pair.sexpr2) + ')'

    def visitAbstractLambda(self):
        print('AbstractLambda toString')

    def visitLambdaSimple(self):
        print('VISIT LambdaSimple')
        print(str(self.body))
        print(str(self.arguments))
        return '(LAMBDA ' + '(' + sexprs.AsStringVisitor.pairToString(self.arguments) +') ' + '(' + sexprs.AsStringVisitor.pairToString(self.body) +')' 
    
    def visitLambdaOpt(self):
        print('VISIT LambdaOPT')
        return '(LAMBDA ' + str(self.arguments) +  ' ' + str(self.body) + ' '
    
    def visitLambdaVar(self):
        print('VISIT LambdaVAR')
        return '(LAMBDA ' + str(self.arguments) +  ' ' + str(self.body) + ' '
    
    def visitApplic(self):
        if isinstance(self.arguments,sexprs.Nil):
            return '(' + str(self.applic) + ')'
        return '(' + str(self.applic) + ' ' + sexprs.AsStringVisitor.pairToString(self.arguments) + ')'
    
    def visitOr(self):
        print('Or toString')

