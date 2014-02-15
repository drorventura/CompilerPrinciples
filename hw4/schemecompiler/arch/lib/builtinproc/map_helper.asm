L_Make_Result_List:	
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R7);
	PUSH(R8);
	
	/* R7 is initialized with nil */
	MOV(R7,IMM(2));
	/* R8 is the displacement of the last argument */
	MOV(R8,FPARG(1));
	ADD(R8,IMM(1));
	
L_Make_Result_List_Loop:
	CMP(2,R8);
	JUMP_GT(L_Make_Result_List_Loop_End);
	PUSH(R7);
	PUSH(FPARG(R8));
	CALL(MAKE_SOB_PAIR);
	MOV(R7,R0);
	DROP(2);
	DECR(R8);
	JUMP(L_Make_Result_List_Loop);
	
L_Make_Result_List_Loop_End:
	POP(R8);
	POP(R7);
	POP(FP);
	RETURN;