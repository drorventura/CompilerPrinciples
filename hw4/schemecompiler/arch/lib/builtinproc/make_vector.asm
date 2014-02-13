/* builtinproc/make_vector.asm
 * Returns a mutable vector with size slots, 
 * where all slots are initialized to contain v.
 * 
 */

MAKE_VECTOR:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);
	PUSH(R3);
	
	MOV(R2,IMM(3));						/* initialize v to be #f */
	MOV(R1,INDD(FPARG(2),1));			/* get the size slot */
	CMP(FPARG(1),IMM(1));
	JUMP_EQ(MAKE_VECTOR_START_LOOP);
	MOV(R2,FPARG(3));					/* get the v */
	
MAKE_VECTOR_START_LOOP:
	MOV(R3,R1);							/* iterate on R3 */
	
MAKE_VECTOR_LOOP:
	CMP(R3,IMM(0));
	JUMP_EQ(MAKE_VECTOR_LOOP_EXIT);
	PUSH(R2);
	DECR(R3);
	JUMP(MAKE_VECTOR_LOOP);

MAKE_VECTOR_LOOP_EXIT:		
	PUSH(R1);
	CALL(MAKE_SOB_VECTOR);
	DROP(1);
	DROP(R1);
	
	POP(R3);
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;
