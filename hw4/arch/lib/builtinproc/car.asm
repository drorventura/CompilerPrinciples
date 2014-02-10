/* car.asm
 * Returns first value in a pair
 */
CAR:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	
	MOV(R1,FPARG(2));
	MOV(R0,INDD(R1,1));
	
	POP(R1);
	MOV(SP,FP);
	POP(FP);
	RETURN;
