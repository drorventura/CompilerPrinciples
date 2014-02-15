/* string_ref.asm
 * Returns the character at position k 
 * in str. The first position in the string corresponds to 0, so the position k must be less than the length of the string, otherwise the exn:fail:contract exception is raised 
 */

STRING_REF:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);

	MOV(R1,FPARG(3));
	MOV(R1,INDD(R1,1));
	ADD(R1,2);
	MOV(R0,FPARG(2));
	MOV(R0,INDD(R0,R1));
	

	PUSH(R0);
	CALL(MAKE_SOB_CHAR);
	DROP(1);
	
	POP(R1);
	POP(FP);
	RETURN;

