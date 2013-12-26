def expandQQ(sexp):
    if sexp.isUnquote():
        return sexp.cdr.car
    elif sexp.isPair():
            a=sexp.car
            b=sexp.cdr

        if a.isUnquoteSplice():
            return sexprs.Pair(sexprs.Symbol('APPEND'), sexprs.Pair(a.cdr.car, sexprs.Pair(expandQQ(b),sexprs.Nil())))

        elif b.isUnquoteSplice():
            return sexprs.Pair(sexprs.Symbol('CONS'), sexprs.Pair(expandQQ(a), sexprs.Pair(sexp.cdr.car,sexprs.Nil())))
            else:
                return sexprs.Pair(sexprs.Symbol('CONS'), sexprs.Pair(expandQQ(a), sexprs.Pair(expandQQ(b),sexprs.Nil())))

   elif sexp.isVector():
        return sexprs.Pair(sexprs.Symbol('LIST->VECTOR'), sexprs.Pair(expandQQ(sexp.lst),sexprs.Nil()))

    elif sexp.isNil() or sexp.isSymbol():

        return sexprs.Pair(sexprs.Symbol('quote'), sexprs.Pair(sexp, sexprs.Nil()))
    else:
        return sexp

def expandQQ(expr):
    if isinstance(expr,sexprs.Symbol) and\
            expr.sexpr1.__class__.__name__ is "QUOTE":
                return expr.sexpr2.sexpr1

    elif isinstance(expr,sexprs.Pair):
        head = expr.sexpr1
        tail = expr.sexpr2 
        
        if head.sexpr1 is "UNQUOTE-SPLICING":
            return sexprs.Pair([sexprs.Symbol('APPEND'),
                                sexprs.Pair([head.sexpr2.sexpr1,
                                             sexprs.Pair([expandQQ(tail)])]])

        elif tail.sexpr1 is "UNQUOTE-SPLICING":
            return sexprs.Pair([sexprs.Symbol('CONS'),
                                sexprs.Pair([expandQQ(head),
                                             sexprs.Pair[expr.sexpr2.sexpr1]])])
        else:
            return sexprs.Pair([sexprs.Symbol('CONS'), 
                                sexprs.Pair([expandQQ(head), 
                                             sexprs.Pair([expandQQ(tail)])])])
    elif isinstance(expr,sexprs.Vector):
        return sexprs.Pair([sexprs.Symbol('LIST->VECTOR'), sexprs.Pair([expandQQ(expr)])]) # may be need last arg

    elif isinstance(expr,sexprs.Nil) or\
            isinstance(expr,sexprs.Symbol):
            return sexprs.Pair([sexprs.Symbol('QUOTE'), sexprs.Pair([sexp]))
    else:
        return expr

