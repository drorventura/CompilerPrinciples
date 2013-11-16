__author__ = 'Dror Ventura & Eldar Damari'

# Abstract Class
class AbstractSexpr:

    #Overide str(...)
    def __str__(self):
        return self.accept(AsStringVisitor)

    @staticmethod
    def readFromString(string):

        return string

# Void Class
class Void(AbstractSexpr):
    def __init__(self):
        print('init is needed')

    def accept(self, visitor):
        return visitor.visitVoid(self)

# Nil Class
class Nil(AbstractSexpr):
    def __init__(self):
        print('init is needed')

    def accept(self, visitor):
        return visitor.visitNil(self)

# Vector Class
class Vector(AbstractSexpr):
    def __init__(self):
        print('init is needed')

    def accept(self, visitor):
        return visitor.visitVector(self)

# Boolean Class
class Boolean(AbstractSexpr):
    def __init__(self):
        print('init is needed')

    def accept(self, visitor):
        return visitor.visitBoolean(self)

# Visitor design pattern
class AsStringVisitor(AbstractSexpr):
    def visitVoid(self):
        print('Void toString')

    def visitNil(self):
        print('Nil toString')

    def visitVector(self):
        print('Vector toString')

    def visitBoolean(self):
        print('Boolean toString')

    def visitInt(self):
        print('Int toString')

    def visitFraction(self):
        print('Fraction toString')

    def visitString(self):
        print('String toString')

    def visitSymbol(self):
        print('Symbol toString')

    def visitPair(self):
        print('Pair toString')