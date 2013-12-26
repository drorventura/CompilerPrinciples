
def tagLetrec(expressions):
    params , args = seperateParamsAndArgs(expressions.sexpr1)
    # paramsAsSchemePairs = buildPairForParamsInLet(params)
    expr = expressions.sexpr2.sexpr1

    lambdaSymbol = sexprs.Symbol('LAMBDA', 6)

    genTmp = Gensym.generate()
    g0 = sexprs.Symbol(genTmp,len(genTmp))
    params.insert(0,g0)
    firstLetrecExp = sexprs.Pair(sum([[lambdaSymbol],
                                      [buildPairForParamsInLet(params)],
                                      [expr]],[]))

    listLetrecExpr = []
    while len(args) > 0:
        params = params[1:]
        genTmp = Gensym.generate()
        g0 = sexprs.Symbol(genTmp,len(genTmp))
        params.insert(0,g0)
        letrecExp = sexprs.Pair(sum([[lambdaSymbol],[buildPairForParamsInLet(params)],[args[0]]],[]))
        listLetrecExpr.append(letrecExp)
        args = args[1:]

    yag = sexprs.Symbol('Yag', 3)
    return parserRecursive(sexprs.Pair(sum([[yag], [firstLetrecExp], listLetrecExpr],[])))
