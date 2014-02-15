/* builtinproc/Less.asm
 *
 */

L_Lt_Applic:

	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R4);
	PUSH(R5);
	PUSH(R6);
	PUSH(R7);
    
    /* save first 1 arguments */
    MOV(R0, FPARG(2));

    /* index variable*/
    MOV(R1,IMM(3)); 

/* Main Loop */
L_Lt_Applic_Loop:
	CMP(R1, FPARG(1)+2);
    /* need to build obj? */
	JUMP_EQ(L_Lt_Applic_TRUE);			

	MOV(R2, FPARG(R1));
    /* check for type */
    CMP(IND(R2), T_INTEGER);
    JUMP_EQ(L_Lt_2nd_is_INT);
    
    CMP(IND(R2), T_FRACTION);
    JUMP_EQ(L_Lt_2nd_is_FRACTION);
    /* back to main loop */ 
    JUMP(L_Lt_Applic_Loop);

/*************/
L_Lt_2nd_is_FRACTION:
    CMP(IND(R0), T_INTEGER);
    JUMP_EQ(L_Lt_1nd_is_INT_FRACTION_NEW);
    
    CMP(IND(R0), T_FRACTION);
    JUMP_EQ(L_Lt_1nd_is_FRACTION_FRACTION);

L_Lt_1nd_is_INT_FRACTION_NEW:
    MOV(R4,INDD(R0,1)); 
    MOV(R5,INDD(R2,2)); 
    MUL(R4,R5);         /* cb R4 is now numerator  */

    CMP(R4,INDD(R2,1));
    JUMP_GT(L_Lt_Applic_FALSE);
    JUMP_EQ(L_Lt_Applic_FALSE);
    
    MOV(R0,R2);

    /* in R0 pointer to INT object */
    INCR(R1);
    JUMP(L_Lt_Applic_Loop);

L_Lt_1nd_is_FRACTION_FRACTION:
    MOV(R4,INDD(R0,1));
    MOV(R5,INDD(R2,2));
    MUL(R4,R5);         /* R4 is now numerator  */
    
    MOV(R6,INDD(R0,2));
    MOV(R7,INDD(R2,1));
    MUL(R6,R7);         /* R6 is now denominator  */

    CMP(R4,R6);
    JUMP_GT(L_Lt_Applic_FALSE);
    JUMP_EQ(L_Lt_Applic_FALSE);
    
    MOV(R0,R2);

    /* in R0 pointer to INT object */
    INCR(R1);
    JUMP(L_Lt_Applic_Loop);

/*************/
L_Lt_2nd_is_INT:
    CMP(IND(R0), T_INTEGER);
    JUMP_EQ(L_Lt_1nd_is_INT_INT);
    
    CMP(IND(R0), T_FRACTION);
    JUMP_EQ(L_Lt_1nd_is_INT_FRACTION);

L_Lt_1nd_is_INT_INT:

    CMP(INDD(R0,1),INDD(R2,1));
    JUMP_GT(L_Lt_Applic_FALSE);
    JUMP_EQ(L_Lt_Applic_FALSE);
    
    MOV(R0,R2);

    /* in R0 pointer to INT object */
    INCR(R1);
    JUMP(L_Lt_Applic_Loop);

/* call from L_Lt_2nd_is_INT */
L_Lt_1nd_is_INT_FRACTION:
    MOV(R4,INDD(R2,1)); 
    MOV(R5,INDD(R0,2)); 
    MUL(R4,R5);         /* cb R4 is now numerator  */

    CMP(INDD(R0,1),R4);
    JUMP_GT(L_Lt_Applic_FALSE);
    JUMP_EQ(L_Lt_Applic_FALSE);
    
    MOV(R0,R2);

    /* in R0 pointer to INT object */
    INCR(R1);
    JUMP(L_Lt_Applic_Loop);

L_Lt_Applic_TRUE:
    MOV(R0,IMM(5));
    JUMP(L_Lt_Applic_Exit);

L_Lt_Applic_FALSE:
    MOV(R0,IMM(3));

L_Lt_Applic_Exit:
	POP(R7);
	POP(R6);
	POP(R5);
	POP(R4);
	POP(R2);
	POP(R1);
	POP(FP);
	
	RETURN;