/* is_zero.asm
 * Returns #t / #f if object is zero.
 */

IS_ZERO_APPLIC:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	
	MOV(R1,FPARG(2));
	MOV(R0,INDD(R1,1));
    CMP(R0,IMM(0));
    JUMP_EQ(L_Is_Zero);
    MOV(R0,IMM(3));
    JUMP(L_IS_ZERO_EXIT);

L_Is_Zero:
    MOV(R0, IMM(5));

L_IS_ZERO_EXIT:
	POP(R1);
	MOV(SP,FP);
	POP(FP);
	RETURN;
