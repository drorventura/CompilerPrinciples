/* builtinproc/eqaul_applic.asm
 * Compute Variadic Eqaul
 *
 */

L_Equal_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R3);
	PUSH(R4);
	
	MOV(R4,IMM(2));
	/* first arg */
	MOV(R2,FPARG(R4));
	INCR(R4);
	
	/* num of arguments on stack */
	MOV(R1, FPARG(1));
	    
L_Equal_True_Loop:
	CMP(R1,1);
	JUMP_EQ(L_Equal_True_Exit);
	MOV(R3,FPARG(R4));
	INCR(R4);
	PUSH(R2);
	PUSH(R3);
	PUSH(2);
	PUSH(0);
	CALL(L_Minus_Applic);
	DROP(4);
	CMP(INDD(R0,1),IMM(0));
	JUMP_NE(L_Equal_False_Exit);
	DECR(R1);
	MOV(R2,R3);
	JUMP(L_Equal_True_Loop);

L_Equal_True_Exit:
    MOV(R0,IMM(5));	
	JUMP(L_Equal_Applic_Exit);
	
L_Equal_False_Exit:
    MOV(R0,IMM(3));
	
L_Equal_Applic_Exit:
	POP(R4);
	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);

	RETURN;
