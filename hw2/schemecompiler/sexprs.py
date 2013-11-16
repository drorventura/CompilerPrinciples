from schemecompiler import pc
__author__ = 'Dror Ventura & Eldar Damari'

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
