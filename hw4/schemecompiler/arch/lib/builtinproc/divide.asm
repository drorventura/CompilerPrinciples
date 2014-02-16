/* builtinproc/divide.asm
 * Compute Variadic Multiplier
 *
 */

L_Divide_Applic:

	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R3);
	PUSH(R4);
	PUSH(R5);
	PUSH(R6);
	PUSH(R7);
    
    /* check if we handle only 1 arg */
    MOV(R1,FPARG(1));

    CMP(R1,IMM(1));
    JUMP_EQ(L_Divide_With_One);
    JUMP(L_Divide_2_Or_More_Args);

L_Divide_With_One:
    MOV(R0,FPARG(2));   /* R0 <- first arg */
    MOV(R1,INDD(R0,1)); /* check if value is negative */
    CMP(R1,IMM(0));
    JUMP_EQ(L_Divide_1arg_zero);
    JUMP_LT(L_Divide_1arg_Negative);
    JUMP_GT(L_Divide_1arg_Positive);


/* Expr: (/ 0) or (/ 0/denominator)
 * return NIL */
L_Divide_1arg_zero:
    MOV(R0,IMM(0));
    JUMP(L_Divide_Applic_Exit);

L_Divide_1arg_Negative:
    /* fix negative notation */
    CMP(IND(R0),T_INTEGER);
    JUMP_EQ(L_Divide_1arg_Negative_INT);
    
    CMP(IND(R0),T_FRACTION);
    JUMP_EQ(L_Divide_1arg_Negative_FRACTION);

L_Divide_1arg_Negative_INT:

    MOV(R1,INDD(R0,1));
    MUL(R1,IMM(-1));
    MOV(R2,IMM(-1));
    JUMP(L_Divide_1arg_MAKE);

L_Divide_1arg_Negative_FRACTION:

    MOV(R1,INDD(R0,1));
    MUL(R1,IMM(-1));
    MOV(R2,INDD(R0,2));
    MUL(R2,IMM(-1));
    JUMP(L_Divide_1arg_MAKE);


L_Divide_1arg_Positive:

    CMP(IND(R0),T_INTEGER);
    JUMP_EQ(L_Divide_1arg_Positive_INT);
    
    CMP(IND(R0),T_FRACTION);
    JUMP_EQ(L_Divide_1arg_Positive_FRACTION);

L_Divide_1arg_Positive_INT:

    MOV(R1,INDD(R0,1));
    MOV(R2,IMM(1));
    JUMP(L_Divide_1arg_MAKE);

L_Divide_1arg_Positive_FRACTION:

    MOV(R1,INDD(R0,1));
    MOV(R2,INDD(R0,2));
    JUMP(L_Divide_1arg_MAKE);

L_Divide_1arg_MAKE:
    PUSH(R1) /* denominator */
    PUSH(R2) /* numerator */
    CALL(MAKE_SOB_FRACTION);
    DROP(2);
    JUMP(L_Divide_Applic_Exit);

L_Divide_2_Or_More_Args:
    
    /* save first 1 arguments */
    MOV(R0, FPARG(2));

    /* index variable*/
    MOV(R1,IMM(3)); 

/* Main Loop */
L_Divide_Applic_Loop:
	CMP(R1, FPARG(1)+2);
    /* need to build obj? */
	JUMP_EQ(L_Divide_Applic_Exit);			

	MOV(R2, FPARG(R1));
    /* check for type */
    CMP(IND(R2), T_INTEGER);
    JUMP_EQ(L_Divide_2nd_is_INT);
    
    CMP(IND(R2), T_FRACTION);
    JUMP_EQ(L_Divide_2nd_is_FRACTION);
    /* back to main loop */ 
    JUMP(L_Divide_Applic_Loop);

/*****2n arg is Fraction********/
L_Divide_2nd_is_FRACTION:
    CMP(IND(R0), T_INTEGER);
    JUMP_EQ(L_Divide_1nd_is_INT_FRACTION);
    
    CMP(IND(R0), T_FRACTION);
    JUMP_EQ(L_Divide_1nd_is_FRACTION_FRACTION);

/* INT / FRACTION */
L_Divide_1nd_is_INT_FRACTION:
    
    MOV(R7, INDD(R0,1));
    MOV(R3, INDD(R2,1));
        
    CMP(R7,IMM(0));
    JUMP_EQ(L_Divide_Return_Loop_With_INT_ZERO);
    JUMP(L_Divide_INT_FRACTION_CHECK_2nd);

L_Divide_INT_FRACTION_CHECK_2nd:
    CMP(R3,IMM(0));
    JUMP_GT(L_Divide_1nd_is_INT_FRACTION_MAKE);
    JUMP_LT(L_Divide_Mul_INT_FRAC_Both_Numbers_Minus1);

L_Divide_Mul_INT_FRAC_Both_Numbers_Minus1:
    MUL(R7,IMM(-1));
    MUL(R3,IMM(-1));

L_Divide_1nd_is_INT_FRACTION_MAKE:
    /* MOV(R4,R3); hhhhhh*/
    MOV(R5,INDD(R2,2));
    /* MOV(R6,INDD(R0,1));*/

    MUL(R5,R7);         
    PUSH(R3);           /* R3 is now denominator*/
    PUSH(R5);           /* R5 is now numerator  */
    CALL(MAKE_SOB_FRACTION);
    JUMP(L_Divide_DROP2_INC_BACK_TO_LOOP);

/* FRACTION / FRACTION */
L_Divide_1nd_is_FRACTION_FRACTION:
    MOV(R4, INDD(R0,1));
    MOV(R3, INDD(R2,1));
        
    CMP(R4,IMM(0));
    JUMP_EQ(L_Divide_Return_Loop_With_INT_ZERO);
    JUMP(L_Divide_FRACTION_FRACTION_CHECK_2nd);

L_Divide_FRACTION_FRACTION_CHECK_2nd:
    CMP(R3,IMM(0));
    JUMP_GT(L_Divide_1nd_is_FRACTION_FRACTION_MAKE);
    JUMP_LT(L_Divide_Mul_FRAC_FRAC_Both_Numbers_Minus1);

L_Divide_Mul_FRAC_FRAC_Both_Numbers_Minus1:
    MUL(R4,IMM(-1));
    MUL(R3,IMM(-1));

L_Divide_1nd_is_FRACTION_FRACTION_MAKE:
    /*MOV(R4,INDD(R0,1));*/
    MOV(R5,INDD(R2,2));
    MUL(R4,R5);         /* R4 is now numerator  */
    
    MOV(R6,INDD(R0,2));
    /*MOV(R7,INDD(R2,1));*/
    MUL(R6,R3);         /* R6 is now denominator  */

    PUSH(R6);
    PUSH(R4);
    CALL(MAKE_SOB_FRACTION);
    JUMP(L_Divide_DROP2_INC_BACK_TO_LOOP);

/*************/
L_Divide_2nd_is_INT:
    CMP(IND(R0), T_INTEGER);
    JUMP_EQ(L_Divide_1nd_is_INT_INT);
    
    CMP(IND(R0), T_FRACTION);
    JUMP_EQ(L_Divide_1nd_is_FRACTION_INT);

L_Divide_1nd_is_INT_INT:
    MOV(R0, INDD(R0,1));
    MOV(R3, INDD(R2,1));
        
    CMP(R0,IMM(0));
    JUMP_EQ(L_Divide_Return_Loop_With_INT_ZERO);
    JUMP(L_Divide_INT_INT_CHECK_2nd);

L_Divide_INT_INT_CHECK_2nd:
    CMP(R3,IMM(0));
    JUMP_GT(L_Divide_1nd_is_INT_INT_MAKE);
    JUMP_LT(L_Divide_Mul_INT_INT__Both_Numbers_Minus1);

L_Divide_Mul_INT_INT__Both_Numbers_Minus1:
    MUL(R0,IMM(-1));
    MUL(R3,IMM(-1));

L_Divide_1nd_is_INT_INT_MAKE:
    PUSH(R3);
    PUSH(R0); /* CHANGE IS ARGUMENT ORDER*/
    CALL(MAKE_SOB_FRACTION);
    JUMP(L_Divide_DROP2_INC_BACK_TO_LOOP);

/* FRACTION / INT */
L_Divide_1nd_is_FRACTION_INT:
    /* TODO */
    /* R0 IS RUNED OVER RETEST WITH (/ 3 -5 7) */
    MOV(R4, INDD(R0,1));
    MOV(R3, INDD(R2,1));
        
    CMP(R4,IMM(0));
    JUMP_EQ(L_Divide_Return_Loop_With_INT_ZERO);
    JUMP(L_Divide_FRACTION_INT_CHECK_2nd);

L_Divide_FRACTION_INT_CHECK_2nd:
    CMP(R3,IMM(0));
    JUMP_GT(L_Divide_1nd_is_FRACTION_INT_MAKE);
    JUMP_LT(L_Divide_Mul_FRAC_INT_Both_Numbers_Minus1);

L_Divide_Mul_FRAC_INT_Both_Numbers_Minus1:
    MUL(R4,IMM(-1));
    MUL(R3,IMM(-1));

L_Divide_1nd_is_FRACTION_INT_MAKE:
    /*MOV(R4,INDD(R0,1));*/
    MOV(R5,INDD(R0,2));
    /*MOV(R6,R3);*/

    MUL(R5,R3);         
    PUSH(R5);           /* R5 is now denominator*/
    PUSH(R4);           /* R4 is now numerator  */
    CALL(MAKE_SOB_FRACTION);
    JUMP(L_Divide_DROP2_INC_BACK_TO_LOOP);

L_Divide_Return_Loop_With_INT_ZERO:
    PUSH(IMM(0));
    CALL(MAKE_SOB_INTEGER);
    DROP(1);
    JUMP(L_Divide_Applic_Loop);

L_Divide_DROP2_INC_BACK_TO_LOOP:
    DROP(2);
    INCR(R1);
    JUMP(L_Divide_Applic_Loop);
    
L_Divide_Applic_Exit:
	POP(R7);
	POP(R6);
	POP(R5);
	POP(R4);
	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);	
	
	RETURN;
