
L_Minus_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	/* accumulator */
	MOV(R0, IMM(0));
	/* num of arguments on stack */
	MOV(R1, IMM(2)); /*first arg*/

	MOV(R0, INDD(FPARG(R1),1));
    SUB(R0, INDD(FPARG(R1+1),1));
    ADD(R1,IMM(2));

L_Minus_Applic_Loop:
	CMP(R1, FPARG(1)+2);
	JUMP_EQ(L_Minus_Applic_Exit);			
    SUB(R0, INDD(FPARG(R1),1));
	INCR(R1);
	JUMP(L_Minus_Applic_Loop);

L_Minus_Applic_Exit:
	POP(R2);
	POP(R1);
	POP(FP);
	
	PUSH(R0);
	CALL(WRITE_INTEGER);
	DROP(1);
	
	RETURN;
