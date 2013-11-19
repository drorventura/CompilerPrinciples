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

        firstdigitParser = ps .const(lambda x: x >= '1' and x <= '9') \
                              .done()
        zeroParser = ps .const(lambda x: x == '0') \
                        .done()
        otherdigitsParser = ps  .parser(firstdigitParser) \
                                .parser(zeroParser) \
                                .disj() \
                                .done()
        signParser = ps .const(lambda x: x == '+' or x == '-') \
                        .done()
        intParser = ps  .parser(signParser) \
                        .parser(zeroParser) \
                        .star() \
                        .parser(firstdigitParser) \
                        .parser(otherdigitsParser) \
                        .star() \

        return boolParser