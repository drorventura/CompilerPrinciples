import reader

__author__ = 'Dror Ventura & Eldar Damari'

# Abstract Class
class AbstractSexpr:

    #Overide str(...)
    def __str__(self):
        return self.accept(AsStringVisitor)

    @staticmethod
    def readFromString(string):
        sexpr , remaining = reader.Reader.parseSexpr().match(string)
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
    def __init__(self,pair):
        print("Pair class")

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
        if sign == "-":
            self.sign = int(-1)
        else:
            self.sign = int(1)

        self.number = int(number)
        self.number *= self.sign

    def accept(self,visitor):
        return visitor.visitInt(self)

# Fraction Class
class Fraction(AbstractNumber):
    def __init__(self,num,dem):
        # Fixing the number sign
        if num.number < 0 and dem.number > 0 :
            self.num = num.number
            self.dem = dem.number
        else:
            if num.number < 0 or dem.number < 0:
                self.num = int(num.number) * -1
                self.dem = int(dem.number) * -1
            else:
                self.num = num.number
                self.dem = dem.number

    def accept(self,visitor):
        return visitor.visitFraction(self)

# Visitor design pattern
class AsStringVisitor(AbstractSexpr):
    def visitVoid(self):
        print('Void toString')

    def visitNil(self):
        print('Nil toString')

    def visitVector(self):
        print('Vector toString')

    def visitBoolean(self):
        return '#' + '%s' %self.value

    def visitInt(self):
        return '%s' %self.number

    def visitFraction(self):
        if self.num == 0:
            return '0'
        else:
            return '%s' %self.num + '/' + '%s' %self.dem

    def visitString(self):
        return '%s' %self.string

    def visitChar(self):
        return '%s' %self.value 

    def visitSymbol(self):
            return '%s' %self.string

    def visitPair(self):
        print('Pair toString')
