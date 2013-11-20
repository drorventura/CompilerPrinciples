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
        return fractionParser 
