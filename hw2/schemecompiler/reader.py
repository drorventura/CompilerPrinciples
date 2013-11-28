import pc
import sexprs
import parser

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
                        .maybe() \
                        .parser(zeroParser) \
                        .star() \
                        .pack(lambda x: ''.join(x)) \
                        .pack(lambda x: x.replace('0',''))\
                        .caten()\
                        .pack(lambda x: x[0][1]) \
                        .parser(firstdigitParser) \
                        .parser(otherdigitsParser) \
                        .star() \
                        .pack(lambda x: ''.join(x)) \
                        .caten() \
                        .pack(lambda x: ''.join(x)) \
                        .caten()\
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
                                .pack(lambda x: ''.join(x)) \
                                .catens(4) \
                                .pack(lambda x: (x[0][1],''.join(x[1:4]))) \
                                .pack(lambda x: sexprs.Int(x[0],x[1])) \
                                .done()

        # fraction parser
        fractionParser = ps .parser(intParser) \
                            .const(lambda x: x == '/') \
                            .parser(intParser) \
                            .catens(3) \
                            .pack(lambda x: sexprs.Fraction(x[0],x[2])) \
                            .done()

        # String parser
        stringParser = ps  .const(lambda x: x == '\"') \
                           .const(lambda x: x >= 'a' and x <= 'z') \
                           .const(lambda x: x >= 'A' and x <= 'Z') \
                           .const(lambda x: x >= '0' and x <= '9') \
                           .const(lambda x: x == '\n' or x == '\r' or x == '\t' or 
                                            x == '\\' or x == '\l')\
                           .const(lambda x: x == '!' or x == '$' or x == '^' or 
                                            x == '*' or x == '-' or x == '_' or
                                            x == '=' or x == '+' or x == '<' or
                                            x == '>' or x == '/' or x == '?') \
                           .disjs(5) \
                           .star() \
                           .pack(lambda x: ''.join(x)) \
                           .const(lambda x: x == '\"') \
                           .catens(3) \
                           .pack(lambda x: sexprs.String(x[1])) \
                           .done()

        # '('
        leftParenthesesParser = ps  .parser(pc.pcWord('('))\
                                    .done()
        # ')'
        rightParenthesesParser = ps .parser(pc.pcWord(')'))\
                                    .done()
        # Nil parser = '()
        nilParser = ps  .parser(leftParenthesesParser) \
                        .parser(rightParenthesesParser) \
                        .done()

        improperList = ps   .delayed_parser(lambda: test) \
                            .parser(pc.pcWhite1) \
                            .delayed_parser(lambda: test) \
                            .disj() \
                            .star() \
                            .pack(lambda x: list(filter(lambda ch: ch != ' ', x))) \
                            .const(lambda x: x == '.') \
                            .parser(pc.pcWhite1) \
                            .star() \
                            .pack(lambda x: list(filter(lambda ch: ch != ' ', x))) \
                            .delayed_parser(lambda: test) \
                            .catens(5) \
                            .pack(lambda x: sum([[x[0]], x[1], [x[2]], [x[4]]], [])) \
                            .pack(lambda x: sexprs.Pair(x)) \
                            .done()

        properList = ps .parser(pc.pcWhite1) \
                        .delayed_parser(lambda: test) \
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

        test = ps   .parser(pairParser)\
                    .parser(fractionParser) \
                    .parser(boolParser) \
                    .parser(hexNumberParser) \
                    .parser(intParser) \
                    .disjs(5) \
                    .done()

        return test