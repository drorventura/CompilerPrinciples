
CHAR_TO_INTEGER:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	MOV(R1,INDD(FPARG(2),1)); 
	PUSH(R1);
	CALL(MAKE_SOB_INTEGER);
	DROP(1);
	POP(R1);
	POP(FP);
	RETURN;

