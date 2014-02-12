
L_Divide_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	/* accumulator */
	MOV(R1, IMM(0));
	/* num of arguments on stack */
	MOV(R2, IMM(2)); /*first arg*/

    ##################
	MOV(R1, INDD(FPARG(R2),1));
    DIV(R1, INDD(FPARG(R2+1),1));
    printf("number %f\n",R1);
    ADD(R1,IMM(2));

L_Divide_Applic_Loop:
	CMP(R1, FPARG(1)+2);
	JUMP_EQ(L_Divide_Applic_Exit);			
    DIV(R0, INDD(FPARG(R1),1));
	INCR(R1);
	JUMP(L_Divide_Applic_Loop);

L_Divide_Applic_Exit:
	POP(R2);
	POP(R1);
	POP(FP);
	
	RETURN;
