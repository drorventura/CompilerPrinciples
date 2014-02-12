
L_APPLY:

	PUSH(FP);
	MOV(FP,SP);
	
	PUSH(R1);
	PUSH(R2);
	PUSH(R3);
	PUSH(R5);
	PUSH(R6);	
		
	MOV(R1,FPARG(2)); 	/* closure */
	MOV(R2,FPARG(3)); 	/* params */
	
	MOV(R5,FPARG(2)); 	/* closure */
	MOV(R0,11);      	/* will hold reverse list */
	MOV(R6,0);
	
	CMP(R2,11);
	JUMP_EQ(APPLY_REVERSE_END2);
	
APPLY_REVERSE:
	CMP(R2,11);
	JUMP_EQ(APPLY_REVERSE_END);
	PUSH(R0);
	PUSH(INDD(R2,1));
	CALL(MAKE_SOB_PAIR);
	DROP(2);
	MOV(R2,INDD(R2,2));
	INCR(R6);
	JUMP(APPLY_REVERSE);
	
APPLY_REVERSE_END:
	
APPLY_PUSH:
	CMP(R0,11);
	JUMP_EQ(APPLY_PUSH_END);
	PUSH(INDD(R0,1));
	MOV(R0,INDD(R0,2));
	JUMP(APPLY_PUSH);
	
APPLY_PUSH_END:
	MOV(R3,SP);
	SUB(R3,FP);
	PUSH(R6);			/* num of params */
	PUSH(INDD(R5,1));	/* env */
	CALLA(INDD(R5,2));
	DROP(2);
	DROP(IMM(R6));
	
	POP(R6);
	POP(R5);
	POP(R3);
	POP(R2);
	POP(R1);	
	
	MOV(SP,FP);
	POP(FP);
	RETURN;
	
APPLY_REVERSE_END2:
	PUSH(11);			/* nil*/
	PUSH(1);			/* num of args*/
	PUSH(INDD(R5,1));	/* env */
	
	CALLA(INDD(R5,2));
	DROP(3);
	
	POP(R6);
	POP(R5);
	POP(R3);
	POP(R2);
	POP(R1);	
	
	MOV(SP,FP);
	POP(FP);
	RETURN;
