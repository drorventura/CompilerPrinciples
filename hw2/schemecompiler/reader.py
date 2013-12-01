import pc
import sexprs

__author__ = 'Dror Ventura & Eldar Damari'

ps = pc.ParserStack()

def show(x):
    print('recived '+ str(x))
    return x

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

symbolParser = ps   .parser(stringParser)\
                    .pack(lambda x: sexprs.Symbol(str(x).upper(),len(str(x))))\
                    .done()


class Reader:
    @staticmethod
    def parseSexpr():
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
        firstdigitParser = ps .const(lambda x: x >= '1' and x <= '9') \
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
                .parser(zeroParser) \
                .star() \
                .pack(lambda x: ''.join(x)) \
                .pack(lambda x: x.replace('0',''))\
                .caten()\
                .pack(lambda x: x[0])\
                .parser(signParser)\
                .parser(zeroParser)\
                .star()\
                .pack(lambda x: ''.join(x)) \
                .pack(lambda x: x.replace('0',''))\
                .disjs(3)\
                .parser(firstdigitParser)\
                .parser(otherdigitsParser)\
                .star()\
                .pack(lambda x: ''.join(x)) \
                .caten()\
                .pack(lambda x: ''.join(x)) \
                .caten()\
                .parser(zeroParser)\
                .pack(lambda x: [0,x])\
                .disj()\
                .pack(lambda x: sexprs.Int(x[0],x[1]))\
                .done()

        # fraction parser
        fractionParser = ps  .parser(intParser)\
                .const(lambda x: x == '/')\
                .parser(intParser)\
                .catens(3)\
                .pack(lambda x: sexprs.Fraction(x[0],x[2]))\
                .done()
    
        #_______________________#TODO _________________

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
        string =       ps  .parser(stringMetaChars)\
                           .parser(stringNonMetaChar)\
                           .disj()\
                           .done()\

        # string Parser -  "(string)*"
        stringParser = ps  .const(lambda x: x == '"')\
                           .parser(string)\
                           .star()\
                           .pack(lambda x: ''.join(x))\
                           .const(lambda x: x == '"')\
                           .catens(3)\
                           .pack(lambda x: sexprs.String(x[1]))\
                           .done()
        
       
        # hex digits
        hexDigit =   ps     .const(lambda x: x >= '0' and x <= '9').pack(lambda x: ord(x)-48)\
                            .const(lambda x: x >= 'A' and x <= 'F').pack(lambda x: ord(x)-55)\
                            .const(lambda x: x >= 'a' and x <= 'f').pack(lambda x: ord(x)-87)\
                            .disjs(3)\
                            .done()
        

        # byte sized digit
        byte =        ps    .parser(hexDigit)\
                            .parser(hexDigit)\
                            .caten()\
                            .pack(lambda x: x[0]*16+x[1])\
                            .done()
        # word sized digits
        word =        ps    .parser(byte)\
                            .parser(byte)\
                            .caten()\
                            .pack(lambda x: x[0]*256+x[1])\
                            .done()
        
        # hex digits
        hexDigit =  ps  .const(lambda x: x >= '0' and x <= '9').pack(lambda x: ord(x)-48)\
                        .const(lambda x: x >= 'A' and x <= 'F').pack(lambda x: ord(x)-55)\
                        .const(lambda x: x >= 'a' and x <= 'f').pack(lambda x: ord(x)-87)\
                        .disjs(3)\
                        .done()

    def show(x):
        print('recived '+ str(x))
        return x

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
                    .pack(show)\
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
                           .done()

        

        # visible Chars
        visibleChars =   ps   .const(lambda x: x == '#')\
                              .const(lambda x: x == '\\')\
                              .const(lambda x: ord(x) >= 32 )\
                              .catens(3)\
                              .pack(lambda x: x)\
                              .done()
        

        # Char Parser -    (namedChar U hexChars U visibleChars)*
        charParser = ps    .parser(namedChar)\
                           .parser(hexChars)\
                           .parser(visibleChars)\
                           .disjs(3)\
                           .star()\
                           .pack(lambda x: x)\
                           .done()
        
        # Symbol Parser - 
        symbolParser = ps    .parser(stringParser)\
                            .star()\
                            .pack(lambda x: len(x))\
                            .done()
        
        return symbolParser
