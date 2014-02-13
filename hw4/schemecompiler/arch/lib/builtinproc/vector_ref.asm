/* vector_ref.asm
 * 
 */

VECTOR_REF:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R3);
	MOV(R1,FPARG(2));
	MOV(R2,INDD(FPARG(3),1));
	ADD(R1,IMM(2));
	ADD(R1,R2);
	MOV(R0,IND(R1));

	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;
