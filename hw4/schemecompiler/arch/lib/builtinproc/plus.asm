/* builtinproc/plus.asm
 * Compute Variadic plus
 */

L_Plus_Applic:

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
	MOV(R4, IMM(0)); /* denom */
	
	/* displacement for first param on stack */
	MOV(R1, IMM(2));
	
	/* num of args */
	MOV(R6, FPARG(1));
	
L_Plus_Applic_Loop:
	CMP(R6, IMM(0));
	JUMP_EQ(L_Plus_Applic_Before_Exit);
	MOV(R2,FPARG(R1));
	CMP(IND(R2),T_INTEGER);
	JUMP_EQ(L_Plus_Int);
	JUMP(L_Plus_Frac);
	
L_Plus_Int:
	CMP(R4,IMM(0));
	JUMP_NE(L_Plus_Int_Frac);
	ADD(R3,INDD(R2,1));
	JUMP(L_Plus_Continue_Loop);
	
L_Plus_Frac:
	CMP(R4,IMM(0));
	JUMP_EQ(L_Plus_Frac_Int);
	CMP(R4,INDD(R2,2));
	JUMP_NE(L_Plus_Frac_Frac);
	ADD(R3,INDD(R2,1));
	JUMP(L_Plus_Continue_Loop);

L_Plus_Frac_Int:
	MUL(R3,INDD(R2,2));
	ADD(R3,INDD(R2,1));
	ADD(R4,INDD(R2,2));
	JUMP(L_Plus_Continue_Loop);
	
L_Plus_Int_Frac:			
	MOV(R5,INDD(R2,1));
	MUL(R5,R4);
	ADD(R3,R5);
	JUMP(L_Plus_Continue_Loop);

L_Plus_Frac_Frac:			/* R2 is of the form a/b */
	MUL(R3,INDD(R2,2));		/* R3 <- num*b */
	MOV(R5,INDD(R2,1));		/* R5 <- a */
	MUL(R5,R4);				/* R5 <- a*denom */
	ADD(R3,R5);				/* R3 <- (num*b)+(a*denom) */
	MUL(R4,INDD(R2,2));		/* R4 <- denom*b */

L_Plus_Continue_Loop:
	DECR(R6);
	INCR(R1);	
	JUMP(L_Plus_Applic_Loop);
	
L_Plus_Applic_Before_Exit:
	CMP(R4,IMM(0));
	JUMP_NE(L_Plus_Make_Frac);
	PUSH(R3);
	CALL(MAKE_SOB_INTEGER);
	DROP(1);
	JUMP(L_Plus_Applic_Exit);

L_Plus_Make_Frac:
	PUSH(R4);
	PUSH(R3);
	CALL(MAKE_SOB_FRACTION);
	DROP(2);

L_Plus_Applic_Exit:
	POP(R6);
	POP(R5);
	POP(R4);
	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);
	
	RETURN;