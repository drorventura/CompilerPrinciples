/* builtinproc/divide.asm
 * Compute Variadic Multiplier
 *
 */

L_Divide_Applic:

	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);
    
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

/*************/
L_Divide_2nd_is_FRACTION:
    CMP(IND(R0), T_INTEGER);
    JUMP_EQ(L_Divide_1nd_is_INT_FRACTION);
    
    CMP(IND(R0), T_FRACTION);
    JUMP_EQ(L_Divide_1nd_is_FRACTION_FRACTION);

L_Divide_1nd_is_INT_FRACTION:
    MOV(R4,INDD(R2,1));
    MOV(R5,INDD(R2,2));
    MOV(R6,INDD(R0,1));

    MUL(R5,R6);         /* R5 is now denominator  */
    PUSH(R4);
    PUSH(R5);           /* R4 is now numerator*/
    CALL(MAKE_SOB_FRACTION);
    DROP(2);
	
    /* in R0 pointer to FRACTION object */
    INCR(R1);
    JUMP(L_Divide_Applic_Loop);

L_Divide_1nd_is_FRACTION_FRACTION:
    MOV(R4,INDD(R0,1));
    MOV(R5,INDD(R2,2));
    MUL(R4,R5);         /* R4 is now numerator  */
    
    MOV(R6,INDD(R0,2));
    MOV(R7,INDD(R2,1));
    MUL(R6,R7);         /* R4 is now denominator  */

    PUSH(R6);
    PUSH(R4);
    CALL(MAKE_SOB_FRACTION);
    DROP(2);
    /* in R0 pointer to FRACTION object */
    INCR(R1);
    JUMP(L_Divide_Applic_Loop);

/*************/
L_Divide_2nd_is_INT:
    CMP(IND(R0), T_INTEGER);
    JUMP_EQ(L_Divide_1nd_is_INT_INT);
    
    CMP(IND(R0), T_FRACTION);
    JUMP_EQ(L_Divide_1nd_is_FRACTION_INT);

L_Divide_1nd_is_INT_INT:
    MOV(R0, INDD(R0,1));
    MOV(R3, INDD(R2,1));
    PUSH(R3);
    PUSH(R0);
    CALL(MAKE_SOB_FRACTION);
    DROP(2);
    /* in R0 pointer to INT object */
    INCR(R1);
    JUMP(L_Divide_Applic_Loop);

/* call from L_Divide_2nd_is_INT */
L_Divide_1nd_is_FRACTION_INT:
    MOV(R4,INDD(R0,1));
    MOV(R5,INDD(R0,2));
    MOV(R6,INDD(R2,1));

    MUL(R5,R6);         /* R5 is now denominator  */
    PUSH(R5);
    PUSH(R4);           /* R4 is now numerator*/
    CALL(MAKE_SOB_FRACTION);
    DROP(2);
    /* in R0 pointer to FRACTION object */
    INCR(R1);
    JUMP(L_Divide_Applic_Loop);

L_Divide_Applic_Exit:
	POP(R2);
	POP(R1);
	POP(FP);	
	
	RETURN;
