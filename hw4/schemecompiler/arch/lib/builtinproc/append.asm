
L_APPEND_Applic:

	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);

	MOV(R2,FPARG(1));
	
	CMP(R2,0);
	JUMP_EQ(L_APPEND_0_ARGUMENT);

	MOV(R0,FPARG(2));
    CMP(R0,IMM(2));
    JUMP_EQ(L_APPEND_EMPTY_LIST_EXIT);
	
	MOV(R1,IMM(2));
	
L_APPEND_LOOP:
    CMP(R2,1);			/* 0 when all lists where appended */
    JUMP_EQ(L_APPEND_AFTER_LOOP);
    
	MOV(R0,FPARG(R1));
	
L_APPEND_FIND_LAST:
    CMP(INDD(R0,2),IMM(2)); /* check if nil */
    JUMP_EQ(L_APPEND_ADD);
	
	MOV(R0,INDD(R0,2));
    JUMP(L_APPEND_FIND_LAST);

L_APPEND_ADD:
	INCR(R1);
    MOV(INDD(R0,2),FPARG(R1));
	DECR(R2);
    JUMP(L_APPEND_LOOP);

L_APPEND_AFTER_LOOP:
    MOV(R0,FPARG(2));
    JUMP(L_APPEND_Applic_EXIT);
	
L_APPEND_0_ARGUMENT:
	MOV(R0,IMM(2));
	JUMP(L_APPEND_Applic_EXIT);

L_APPEND_EMPTY_LIST_EXIT:
    MOV(R0,FPARG(3));

L_APPEND_Applic_EXIT:
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;