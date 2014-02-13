/* cdr.asm
 * Returns senconde value in a pair
 */
CDR:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	
	MOV(R1,FPARG(2));
	MOV(R0,INDD(R1,2));
	
	POP(R1);
	MOV(SP,FP);
	POP(FP);
	RETURN;
