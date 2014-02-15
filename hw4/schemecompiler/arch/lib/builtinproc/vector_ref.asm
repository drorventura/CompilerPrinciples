/* vector_ref.asm
 * 
 */

VECTOR_REF:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	
	MOV(R1,FPARG(3));
	MOV(R1,INDD(R1,1));
	INCR(R1);
	MOV(R0,FPARG(2));
	MOV(R0,INDD(R0,R1));
		
	POP(R1);
	POP(FP);
	RETURN;
