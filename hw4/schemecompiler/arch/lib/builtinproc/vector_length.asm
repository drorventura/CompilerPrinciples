/* vector_length.asm
 * 
 * Returns legnth of the vector.
 */

VECTOR_LENGTH:

	PUSH(FP);
	MOV(FP,SP);
	MOV(R0,FPARG(2));
	MOV(R0,INDD(R0,1));
	PUSH(R0);
	CALL(MAKE_SOB_INTEGER);

	DROP(1);
	POP(FP);
	RETURN;
