import pc
import sexprs

__author__ = 'Dror Ventura & Eldar Damari'

ps = pc.ParserStack()

# Parser for the Boolean sexpression
boolParser = ps .const(lambda x: x == '#') \
                .const(lambda x: x == 't' or x == 'T') \
                .const(lambda x: x == 'f' or x == 'F') \
                .disj() \
                .caten() \
                .pack(lambda x: sexprs.Boolean(x[1])) \
                .done()

# 1-9
firstdigitParser = ps   .const(lambda x: x >= '1' and x <= '9') \
                        .done()
# 0
zeroParser = ps .const(lambda x: x == '0') \
                .done()
# (1-9) U (0)
otherdigitsParser = ps  .parser(firstdigitParser) \
                        .parser(zeroParser) \
                        .disj() \
                        .done()
# +/-
signParser = ps .const(lambda x: x == '+' or x == '-') \
                .done()

# int parser
intParser = ps  .parser(signParser) \
                .maybe() \
                .parser(zeroParser) \
                .star() \
                .caten() \
                .pack(lambda x: x[0][1]) \
                .parser(firstdigitParser) \
                .parser(otherdigitsParser) \
                .star() \
                .pack(lambda x: ''.join(x)) \
                .caten() \
                .pack(lambda x: ''.join(x)).pack(lambda x: int(x)) \
                .caten() \
                .parser(zeroParser) \
                .pack(lambda x: [0,x]) \
                .disj() \
                .pack(lambda x: sexprs.Int(x[0],x[1])) \
                .done()

# A hex number always start with 0
hexFirstSign = ps   .const(lambda x: x == '0') \
                    .done()
# The second sign of hex number can be x|X|h|H
hexSecondSign = ps  .const(lambda x: x == 'x' or x == 'X' or x == 'h' or x == 'H') \
                    .done()
hexLetters = ps .const (lambda x: (x >= 'a' and x <= 'f') or (x >= 'A' and x <= 'F')) \
                .done()
# Hex parser
hexNumberParser = ps    .parser(signParser) \
                        .maybe() \
                        .parser(hexFirstSign) \
                        .parser(hexSecondSign) \
                        .parser(otherdigitsParser) \
                        .parser(hexLetters) \
                        .disj() \
                        .star() \
                        .pack(lambda x: ''.join(x)).pack(lambda x: int(x,16)) \
                        .catens(4) \
                        .pack(lambda x: sexprs.Int(x[0][1],x[3])) \
                        .done()

# fraction parser
fractionParser = ps .parser(hexNumberParser) \
                    .parser(intParser) \
                    .disj() \
                    .const(lambda x: x == '/') \
                    .parser(hexNumberParser) \
                    .parser(intParser) \
                    .disj() \
                    .catens(3) \
                    .pack(lambda x: sexprs.Fraction(x[0],x[2])) \
                    .done()

# '('
leftParenthesesParser = ps  .parser(pc.pcWord('(')) \
                            .done()
# ')'
rightParenthesesParser = ps .parser(pc.pcWord(')')) \
                            .done()
# Nil parser = '()
nilParser = ps  .parser(leftParenthesesParser) \
                .parser(rightParenthesesParser) \
                .caten() \
                .pack(lambda x: sexprs.Nil()) \
                .done()

improperList = ps   .delayed_parser(lambda : sexpression) \
                    .parser(pc.pcWhite1) \
                    .delayed_parser(lambda : sexpression) \
                    .disj() \
                    .star() \
                    .pack(lambda x: list(filter(lambda ch: ch != ' ', x))) \
                    .const(lambda x: x == '.') \
                    .parser(pc.pcWhite1) \
                    .star() \
                    .pack(lambda x: list(filter(lambda ch: ch != ' ', x))) \
                    .delayed_parser(lambda : sexpression) \
                    .catens(5) \
                    .pack(lambda x: sum([[x[0]], x[1], [x[2]], [x[4]]], [])) \
                    .pack(lambda x: sexprs.Pair(x)) \
                    .done()

properList = ps .parser(pc.pcWhite1) \
                .delayed_parser(lambda : sexpression) \
                .disj() \
                .star() \
                .pack(lambda x: list(filter(lambda ch: ch != ' ', x))) \
                .pack(lambda x: sexprs.Pair(x)) \
                .done()

# Pair parser
pairParser = ps .parser(leftParenthesesParser) \
                .parser(pc.pcWhite1) \
                .star() \
                .parser(improperList) \
                .parser(properList) \
                .disj() \
                .parser(pc.pcWhite1) \
                .star() \
                .parser(rightParenthesesParser) \
                .catens(5) \
                .pack(lambda x: x[2]) \
                .done()

# Vector parser
vectorParser = ps   .const(lambda x: x == '#') \
                    .parser(leftParenthesesParser) \
                    .parser(pc.pcWhite1) \
                    .delayed_parser(lambda : sexpression) \
                    .disj() \
                    .star() \
                    .parser(rightParenthesesParser) \
                    .catens(4) \
                    .pack(lambda x: list(filter(lambda ch: ch != ' ', x[2]))) \
                    .pack(lambda x: sexprs.Vector(x)) \
                    .done()

# String parser
stringMetaChars = ps  .const(lambda x: x == '\\')\
                      .const(lambda x: x == 'n').pack(lambda x: '\n')\
                      .const(lambda x: x == 'r').pack(lambda x: '\r')\
                      .const(lambda x: x == 't').pack(lambda x: '\t')\
                      .const(lambda x: x == 'f').pack(lambda x: '\f')\
                      .const(lambda x: x == '"').pack(lambda x: '\"')\
                      .const(lambda x: x == '\\' ).pack(lambda x: '\\' )\
                      .const(lambda x: x == 'l').pack(lambda x: '\u03bb')\
                      .disjs(7)\
                      .caten()\
                      .pack(lambda x: x[1])\
                      .done()

stringNonMetaChar = ps  .const(lambda x: x != '\\' and x != '\"')\
                        .done()

# string         -  (stringMetaChars U stringNonMetaChar)
string =    ps  .parser(stringMetaChars)\
                .parser(stringNonMetaChar)\
                .disj()\
                .done()\

# string Parser -  "(string)*"
stringParser = ps   .const(lambda x: x == '"')\
                    .parser(string)\
                    .star()\
                    .pack(lambda x: ''.join(x))\
                    .const(lambda x: x == '"')\
                    .catens(3)\
                    .pack(lambda x: sexprs.String(x[1]))\
                    .done()

symbolParser = ps   .const(lambda x: x >= 'a' and x <= 'z')\
                    .const(lambda x: x >= 'A' and x <= 'Z')\
                    .const(lambda x: x >= '0' and x <= '9')\
                    .const(lambda x: x == '!' or x == '$' or x == '^'
                                  or x == '*' or x == '-' or x == '_'
                                  or x == '=' or x == '+' or x == '<'
                                  or x == '>' or x == '/' or x == '?')\
                    .disjs(4)\
                    .star()\
                    .pack(lambda x: ''.join(x))\
                    .pack(lambda x: sexprs.Symbol(str(x).upper(),len(str(x))))\
                    .done()
        
# hex digits
hexDigit =  ps  .const(lambda x: x >= '0' and x <= '9').pack(lambda x: ord(x)-48)\
                .const(lambda x: x >= 'A' and x <= 'F').pack(lambda x: ord(x)-55)\
                .const(lambda x: x >= 'a' and x <= 'f').pack(lambda x: ord(x)-87)\
                .disjs(3)\
                .done()


# byte sized digit
byte =  ps  .parser(hexDigit)\
            .parser(hexDigit)\
            .caten()\
            .pack(lambda x: x[0]*16+x[1])\
            .done()

# word sized digits
word =  ps  .parser(byte)\
            .parser(byte)\
            .caten()\
            .pack(lambda x: x[0]*256+x[1])\
            .done()

# Hexadecimal Chars
hexChar =   ps  .const(lambda x: x == '#')\
                .const(lambda x: x == '\\')\
                .parser(word)\
                .parser(byte)\
                .disj()\
                .catens(3)\
                .pack(lambda x: chr(x[2]))\
                .done()


# Named Chars
namedChar =   ps   .const(lambda x: x == '#')\
                   .const(lambda x: x == '\\')\
                   .parser(pc.pcWordCI("newline")).pack(lambda x: chr(10))\
                   .parser(pc.pcWordCI("return" )).pack(lambda x: chr(13))\
                   .parser(pc.pcWordCI("tab"    )).pack(lambda x: chr(11))\
                   .parser(pc.pcWordCI("page"   )).pack(lambda x: chr(12))\
                   .parser(pc.pcWordCI("lambda" )).pack(lambda x: '\u03bb')\
                   .disjs(5)\
                   .catens(3)\
                   .pack(lambda x: x[2])\
                   .done()



# visible Chars
visibleChars =   ps   .const(lambda x: x == '#')\
                      .const(lambda x: x == '\\')\
                      .const(lambda x: ord(x) >= 32 )\
                      .catens(3)\
                      .pack(lambda x: x[2])\
                      .done()


# Char Parser -    (namedChar U hexChars U visibleChars)*
charParser = ps    .parser(namedChar)\
                   .parser(hexChar)\
                   .parser(visibleChars)\
                   .disjs(3)\
                   .star()\
                   .pack(lambda x: sexprs.Char(x[0]))\
                   .done()

# Sexpression parser - Main parsing function
sexpression = ps    .parser(fractionParser) \
                    .parser(hexNumberParser) \
                    .parser(intParser) \
                    .parser(boolParser) \
                    .parser(nilParser) \
                    .parser(pairParser) \
                    .parser(vectorParser) \
                    .disjs(7) \
                    .done()


def show(x):
    print('recived '+ str(x))
    return x
