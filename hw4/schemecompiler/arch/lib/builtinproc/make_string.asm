/* make_string.asm
 * 
 * Returns a new mutable string of length k 
 * where each position in the string is initialized 
 * with the character char.
 */

MAKE_STRING:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R3);
	
	MOV(R1,FPARG(1));
	MOV(R2,INDD(FPARG(2),1));
	MOV(R3,INDD(FPARG(3),1));
	CMP(R1,IMM(1));
	JUMP_EQ(MAKE_DEFAULT_STRING);
	MOV(R1,R2);
	
MAKE_STRING_LOOP:
	CMP(R1,IMM(0));
	JUMP_EQ(EXIT_MAKE_STRING_LOOP);
	PUSH(R3);
	DECR(R1);
	JUMP(MAKE_STRING_LOOP);
	
MAKE_DEFAULT_STRING:
	MOV(R1,R2);
	MOV(R3,IMM(0));
	JUMP(MAKE_STRING_LOOP);
	
EXIT_MAKE_STRING_LOOP:
	PUSH(R2);
	CALL(MAKE_SOB_STRING);
	DROP(1+R2);

	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;

