/* builtinproc/eqaul_applic.asm
 * Compute Variadic Eqaul
 *
 */

L_Equal_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	/* accumulator */
	MOV(R0, IMM(0));
	/* num of arguments on stack */

	MOV(R1, IMM(2)); /*first arg*/

	MOV(R0, INDD(FPARG(R1),1));
    CMP(R0, INDD(FPARG(R1+1),1));
    ADD(R1,IMM(2));
    JUMP_EQ(L_Equal_TRUE_Loop);
    /* not equal - exit */
    MOV(R0,IMM(3));
    JUMP(L_Equal_Applic_Exit);
    
L_Equal_TRUE_Loop:
	CMP(R1, FPARG(1)+2);
	JUMP_EQ(L_Equal_TRUE_Exit);			
    CMP(R0, INDD(FPARG(R1),1));
	INCR(R1);
	JUMP(L_Equal_TRUE_Loop);

L_Equal_TRUE_Exit:
    MOV(R0,IMM(5));

L_Equal_Applic_Exit:
	POP(R2);
	POP(R1);
	POP(FP);

	RETURN;
