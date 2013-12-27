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
        self

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
    def __init__(self, sexprList):
        if len(sexprList) == 0:
            self.sexpr = Nil();
        else:
            self.sexpr = Pair(sexprList)

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
        self.string = string
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
        return 'Void'

    def visitNil(self):
        return self.value

    def visitVector(self):
        return '#' + str(self.sexpr)

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
        return '(' + AsStringVisitor.pairToString(self) + ')'

    # this is the recursive call, from visitPair
    def pairToString(self):
        if isinstance(self.sexpr2, Nil):                #proper list end tree
            return str(self.sexpr1)
        else:
            if isinstance(self.sexpr2, Pair):
                #recursive call
                return str(self.sexpr1) + ' ' + AsStringVisitor.pairToString(self.sexpr2)
            else:
                #impreper list end tree
                return str(self.sexpr1) + ' . ' + str(self.sexpr2)
    
    # this is the recursive call, from visitPair
    def pairToString1(self):
        if isinstance(self.sexpr2, Nil) and\
            not isinstance(self.sexpr1,Pair):#proper list end tree
            return str(self.sexpr1)
        else:
            if isinstance(self.sexpr2, Nil) and\
                isinstance(self.sexpr1,Pair):#proper list end tree
                #recursive call
                return AsStringVisitor.pairToString1(self.sexpr1)
            if isinstance(self.sexpr1,type(self.sexpr2)):
                return str(self.sexpr1) + ' . ' + str(self.sexpr2)
            else:
                if isinstance(self.sexpr2, Pair):
                    return str(self.sexpr1) + ' ' + AsStringVisitor.pairToString1(self.sexpr2)

# batz