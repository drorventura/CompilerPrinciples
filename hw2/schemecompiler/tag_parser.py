import sexprs
import itertools

__author__ = 'Dror & Eldar'

# matched strings for Constants
Constants_Strings = {"Boolean" , "Int" , "Char" , "Fraction", "String"}

# Global - ParseSwitch Case
def parserRecursive(expr):
        className = expr.__class__.__name__
        if className in Constants_Strings:
            return tagConstant(expr)

        elif className == "Pair":
            return tagPair(expr)

        elif className == "Nil":
            return tagNil(expr)

        elif className == "Vector":
            return tagVector(expr)

        elif className == "Symbol":
            return tagSymbol(expr)

def tagConstant(expr):
        print('in tagConstant')
        return str(Constant(expr))

def tagPair(expr):
        print('in tagPair')
        return str(Pair(expr))

def tagNil(expr):
        print('in tagNil')
        return str(Nil(expr))

def tagSymbol(expr):
        print('in tagSymbol')
        return str(Symbol(expr))

def tagVector(expr):
        print('in tagVector')
        return str(Vector(expr))

############################ #
# Abstract Scheme Expr Class #
class AbstractSchemeExpr:

    #Overide str(...)
    def __str__(self):
        return self.accept(AsStringVisitor)

    @staticmethod
    def parse(string):
        expr , remaining = sexprs.readFromString(string)
        return parserRecursive(expr) , remaining

# Constant Class
class Constant(AbstractSchemeExpr):
    def __init__(self,constant):
        self.constant = constant

    def accept(self, visitor):
        return visitor.visitConstant(self)

# Variable Class
class Variable(AbstractSchemeExpr):
    def __init__(self):
        print("in Variable")

    def accept(self, visitor):
        return visitor.visitVariable(self)

# IfThenElse Class
class IfThenElse(AbstractSchemeExpr):
    def __init__(self):
        print("in IfTheElse")

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
    def __init__(self):
        print("in LambdaSimple")

    def accept(self, visitor):
        return visitor.visitLambdaSimple(self)

# LambdaOpt Class
class LambdaOpt(AbstractLambda):
    def __init__(self):
        print("in LambdaOpt")

    def accept(self,visitor):
        return visitor.visitLambdaOpt(self)

# LambdaVar Class
class LambdaVar(AbstractLambda):
    def __init__(self):
        print("in LambdaVar")

    def accept(self,visitor):
        return visitor.visitLambdaVar(self)

# Applic Class
class Applic(AbstractSchemeExpr):
    def __init__(self):
        print("in Applic")

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
        return str(self.constant)

    def visitVariable(self):
        print('Variable toString')

    def visitIfThenElse(self):
        print('IfThenElse toString')

    def visitAbstractLambda(self):
        print('AbstractLambda toString')

    def visitLambdaSimple(self):
        print('LambdaSimple toString')
    
    def visitLambdaOpt(self):
        print('LambdaOpt toString')
    
    def visitLambdaVar(self):
        print('LambdaVar toString')
    
    def visitApplic(self):
        print('Applic toString')
    
    def visitOr(self):
        print('Or toString')

