
L_Lt_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);

	MOV(R0, FPARG(2));
	MOV(R1, FPARG(3));
	CMP(INDD(R0,1),INDD(R1,1));  /*comparing 2 args*/
    JUMP_LT(L_Lt_TRUE_Applic);   /* jump if greater than*/
    JUMP(L_Lt_FALSE_Applic);

L_Lt_FALSE_Applic:
    MOV(R0, IMM(3));
    JUMP(L_Lt_Applic_Exit);

L_Lt_TRUE_Applic:
  MOV(R0, IMM(5));

L_Lt_Applic_Exit:
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;
