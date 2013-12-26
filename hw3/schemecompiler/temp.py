
import pc
import sexprs

__author__ = 'Dror Ventura & Eldar Damari'

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

        # String parser
        stringMetaChars = ps  .const(lambda x: x == '\\n').pack(lambda  x: '\n')\
                              .const(lambda x: x == '\\r').pack(lambda  x: '\r')\
                              .const(lambda x: x == '\\"').pack(lambda  x: '\"')\
                              .const(lambda x: x == '\t').pack(lambda  x: '\t')\
                              .const(lambda x: x == '\f').pack(lambda  x: '\f')\
                              .const(lambda x: x == '\r').pack(lambda  x: '\r')\
                              .const(lambda x: x == '\\').pack(lambda  x: '\\')\
                              .const(lambda x: x == '\l').pack(lambda  x: '\l')\
                              .disjs(8)\
                              .done()
        
        stringNonMetaChar = ps  .const(lambda x: x != '\\' and x != '\"')\
                                .pack(lambda x: x)\
                                .done()

        # string         -  (stringMetaChars U stringNonMetaChar)
        string =       ps  .parser(stringMetaChars)\
                           .parser(stringNonMetaChar)\
                           .disj()\
                           .done()\

        # string Parser -  (string)*
        stringParser = ps  .const(lambda x: x == '"')\
                           .parser(string)\
                           .star()\
                           .pack(lambda x: ''.join(x))\
                           .const(lambda x: x == '"')\
                           .catens(3)\
                           .pack(lambda x: sexprs.String(x))\
                           .done()

        return stringParser

                        # Named Char parser
                        # namedCharParser = ps .const(lambda x: x == '\newline' or x == '\Newline' or  x == '\NEWLINE')\
                                #                      .const(lambda x: x == '#\return'  or x == '#\Return'
                                #                                    or  x == '#\RETURN')\
                                        #                      .const(lambda x: x == '#\tab'     or x == '#\Tab'
                                        #                                    or  x == '#\TAB')\
                                                #                      .const(lambda x: x == '#\page'    or x == '#\Page'
                                                #                                    or  x == '#\PAGE')\
                                                        #                      .const(lambda x: x == '#\lambda'  or x == '#\Lambda'
                                                        #                                    or  x == '#\LAMBDA')\
                                                                #                      .disjs(5)\
                                                                #                      .star()\
        stringParserTa = ps .const(lambda x: x == '"')\
                            .parser(pc.pcWord("#\\return"))\
                            .pack(lambda x: ''.join(x))\
                            .const(lambda x: x == '"')\
                            .catens(3)\
                            .pack(lambda x: sexprs.String(x[1]))\
                            .done()
