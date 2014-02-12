/* builtinproc/vector_applic.asm
 * Returns an address for a new allocated vector
 *
 * Programmer: Eldar Damari, 2014
 */

L_Vector_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	
	MOV(R1,FPARG(1)); /* number of parameters to push */
	INCR(R1);		  /* displacement in stack to first argument */
	MOV(R2,IMM(2));
	
L_Vector_Applic_Loop:
	CMP(R2,R1);
	JUMP_GT(L_Vector_Applic_Loop_Exit);
	PUSH(FPARG(R2));
	INCR(R2);
	JUMP(L_Vector_Applic_Loop);
	
L_Vector_Applic_Loop_Exit:
	PUSH(FPARG(1));
	
    /* Calling builtin procedure make sob vector */
    CALL(MAKE_SOB_VECTOR)
	
	DROP(R1);
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;
