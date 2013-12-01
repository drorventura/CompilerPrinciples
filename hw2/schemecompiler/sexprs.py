from _ast import List
import reader

__author__ = 'Dror Ventura & Eldar Damari'

# Abstract Class
class AbstractSexpr:

    #Overide str(...)
    def __str__(self):
        return self.accept(AsStringVisitor)

    @staticmethod
    def readFromString(string):
        sexpr , remaining = reader.sexpression.match(string)
        return sexpr , remaining

# Void Class
class Void(AbstractSexpr):
    def __init__(self):
        print('init is needed')

    def accept(self, visitor):
        return visitor.visitVoid(self)

# Nil Class
class Nil(AbstractSexpr):
    def __init__(self):
        self.value = '()'

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
    def __init__(self, value):
        if value == 'T':
            self.value = 't'
        elif value == 'F':
            self.value = 'f'
        else:
            self.value = value

    def accept(self, visitor):
        return visitor.visitBoolean(self)

# char Class
class Char(AbstractSexpr):
    def __init__(self, value):
        self.value = value

    def accept(self, visitor):
        return visitor.visitChar(self)

# Symbol Class
class Symbol(AbstractSexpr):
    def __init__(self,string,length):
        self.string = String
        self.length = length

    def accept(self,visitor):
        return visitor.visitSymbol(self)

# Pair Class
class Pair(AbstractSexpr):
    def __init__(self, sexprList):
        if len(sexprList) == 1:
            self.sexpr1 = sexprList[0]
            self.sexpr2 = Nil()
        else:
            if sexprList[1] == '.':
                self.sexpr1 = sexprList[0]
                self.sexpr2 = sexprList[2]
            else:
                self.sexpr1 = sexprList[0]
                self.sexpr2 = Pair(sexprList[1:])

    def accept(self,visitor):
        return visitor.visitPair(self)

# String Class
class String(AbstractSexpr):
    def __init__(self,string):
        print("In String :")
        print(string)
        self.string = string

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
    def __init__(self,sign,number):
        self.sign = sign
        self.number = number

    def accept(self,visitor):
        return visitor.visitInt(self)

# Fraction Class
class Fraction(AbstractNumber):
    def __init__(self,num,denom):
        # Fixing the number sign
        if num.sign == '-' and denom.sign == '-':
            self.num = Int('+', num.number)
            self.denom = Int('+', denom.number)
        else:
            if num.sign == '-' or denom.sign == '-':
                self.num = Int('-', num.number)
                self.denom = Int('+', denom.number)
            else:
                self.num = Int('+',num.number)
                self.denom = Int('+',denom.number)

    def accept(self,visitor):
        return visitor.visitFraction(self)

# Visitor design pattern
class AsStringVisitor(AbstractSexpr):
    def visitVoid(self):
        print('Void toString')

    def visitNil(self):
        return self.value

    def visitVector(self):
        print('Vector toString')

    def visitBoolean(self):
        return '#' + '%s' %self.value

    def visitInt(self):
        if (self.sign == '-'):
            return '-' + '%s' %self.number
        else:
            return '%s' %self.number

    def visitFraction(self):
        if self.num.number == '0':
            return '0'
        else:
            return str(self.num) + '/' + str(self.denom)

    def visitString(self):
        return '%s' %self.string

    def visitChar(self):
        return '%s' %self.value 

    def visitSymbol(self):
            return '%s' %self.string

    # this is the wrapper for the recursion
    def visitPair(self):
        string = '(' + AsStringVisitor.pairToString(self)
        return  string + ')'

    # this is the recursive call, from visitPair
    def pairToString(self):
        if not isinstance(self, Pair):
            return str(self)
        else:
            if not isinstance(self.sexpr2, Pair):
                if not isinstance(self.sexpr2, Nil):
                    return str(self.sexpr1) + ' . ' + str(self.sexpr2)
                else:
                    return str(self.sexpr1)
            else:
                return str(self.sexpr1) + ' ' + AsStringVisitor.pairToString(self.sexpr2)
