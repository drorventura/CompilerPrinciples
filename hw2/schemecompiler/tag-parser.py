import reader
__author__ = 'Dror & Eldar'

# Abstract Scheme Expr Class
class AbstractSchemeExpr:

    #Overide str(...)
    def __str__(self):
        return self.accept(AsStringVisitor)

    @staticmethod
    def parse(string):
        macroExpanded , remaining = reader.sexpression.match(string)
        return macroExpanded , remaining

# Constant Class
class Constant(AbstractSchemeExpr):
    def __init__(self):
        print('in Constant')

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
        print('Constant toString')

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

