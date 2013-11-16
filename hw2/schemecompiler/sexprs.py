from schemecompiler import *
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

# Symbol Class
class Symbol(AbstractSexpr):
    def __init__(self,symbol):
        print("Symbol class")

    def accept(self,visitor):
        return visitor.visitSymbol(self)

# Pair Class
class Pair(AbstractSexpr):
    def __init__(self,pair):
        print("Pair class")

    def accept(self,visitor):
        return visitor.visitPair(self)

# String Class
class String(AbstractSexpr):
    def __init__(self,string):
        print("String class")

    def accept(self,visitor):
        return visitor.visitString(self)

# AbstractNumber Class
class AbstractNumber(AbstractSexpr):
    def __init__(self,symbol):
        print("AbstractNumber class")

    def accept(self,visitor):
        return self.accept(self,visitor)

# Int Class
class Int(AbstractNumber):
    def __init__(self,number):
        print("Int class")

    def accept(self,visitor):
        return visitor.visitInt(self)

# Fraction Class
class Fraction(AbstractNumber):
    def __init__(self,fraction):
        print("Fraction class")

    def accept(self,visitor):
        return visitor.visitInt(self)

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
