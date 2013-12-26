def tagLet(expr):
    body = expr.sexpr2.sexpr1
    if isinstance(expr.sexpr1,sexprs.Nil):
        raise SyntaxError("In Let Parameters Bound Are Empty") 

    bound = expr.sexpr1
    list_params = []
    list_args   = []

    while isinstance(bound,sexprs.Pair):
        list_params.append(bound.sexpr1.sexpr1)
        list_args.append(bound.sexpr1.sexpr2.sexpr1)

        if isinstance(bound.sexpr2,sexprs.Nil):
            break
        else:
            bound = bound.sexpr2
    myPair = buildPairForParamsInLet(list_params)
