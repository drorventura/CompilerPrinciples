/* builtinproc/minus.asm
 * Compute Variadic minus
 *
 */

L_Minus_Applic:

	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R3); 
	PUSH(R4); 
	PUSH(R5); 
	PUSH(R6); 
	
	/* accumulator */
	MOV(R3, IMM(0)); /* num */
	MOV(R4, IMM(1)); /* denom */
	
	/* displacement for first param on stack */
	MOV(R1, IMM(2));
	
	/* num of args */
	MOV(R6, FPARG(1));
	
	CMP(R6, IMM(0));
	JUMP_EQ(L_Minus_Applic_Before_Exit);
	MOV(R2,FPARG(R1));
	DECR(R6);
	INCR(R1);
	CMP(IND(R2),T_INTEGER);
	JUMP_EQ(L_Minus_Init);
	MOV(R3,INDD(R2,1));
	MOV(R4,INDD(R2,2));
	JUMP(L_Minus_Applic_Loop);

L_Minus_Init:
	MOV(R3,INDD(R2,1));
	
L_Minus_Applic_Loop:
	CMP(R6, IMM(0));
	JUMP_EQ(L_Minus_Applic_Before_Exit);
	MOV(R2,FPARG(R1));
	CMP(IND(R2),T_INTEGER);
	JUMP_EQ(L_Minus_Int);
	JUMP(L_Minus_Frac);
	
L_Minus_Int:
	CMP(R4,IMM(1));
	JUMP_NE(L_Minus_Frac_Int);
	SUB(R3,INDD(R2,1));	
	JUMP(L_Minus_Continue_Loop);
	
L_Minus_Frac:
	CMP(R4,IMM(1));
	JUMP_EQ(L_Minus_Int_Frac);
	CMP(R4,INDD(R2,2));
	JUMP_NE(L_Minus_Frac_Frac);
	SUB(R3,INDD(R2,1));
	JUMP(L_Minus_Continue_Loop);

L_Minus_Frac_Int:
	MOV(R5,INDD(R2,1));
	MUL(R5,R4);
	SUB(R3,R5);
	JUMP(L_Minus_Continue_Loop);
	
L_Minus_Int_Frac:
	MUL(R3,INDD(R2,2));
	SUB(R3,INDD(R2,1));
	MOV(R4,INDD(R2,2));
	JUMP(L_Minus_Continue_Loop);

L_Minus_Frac_Frac:			/* R2 is of the form a/b */
	MUL(R3,INDD(R2,2));		/* R3 <- num*b */
	MOV(R5,INDD(R2,1));		/* R5 <- a */
	MUL(R5,R4);				/* R5 <- a*denom */
	SUB(R3,R5);				/* R3 <- (num*b)-(a*denom) */
	MUL(R4,INDD(R2,2));		/* R4 <- denom*b */

L_Minus_Continue_Loop:
	DECR(R6);
	INCR(R1);	
	JUMP(L_Minus_Applic_Loop);
	
L_Minus_Applic_Before_Exit:
	CMP(R3,IMM(0));
	JUMP_EQ(L_Minus_Make_Int);
	CMP(R4,IMM(1));
	JUMP_NE(L_Minus_Make_Frac);
	
L_Minus_Make_Int:
	PUSH(R3);
	CALL(MAKE_SOB_INTEGER);
	DROP(1);
	JUMP(L_Minus_Applic_Exit);

L_Minus_Make_Frac:
	PUSH(R4);
	PUSH(R3);
	CALL(MAKE_SOB_FRACTION);
	DROP(2);

L_Minus_Applic_Exit:
	POP(R6);
	POP(R5);
	POP(R4);
	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);
	
	RETURN;