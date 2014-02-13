/* builtinproc/lessThan_applic.asm
 * Compute Variadic less Than
 *
 */

L_Lt_Applic:
    
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
    PUSH(R3);
    PUSH(R5);

    MOV(R3,FPARG(1));
    CMP(R3,1);
    JUMP_EQ(L_Lt_TRUE_Applic);

    INCR(R3);
	MOV(R0, FPARG(2));
    MOV(R5,3);

L_Lt_Applic_Loop:
    CMP(R5,R3);
    JUMP_EQ(L_Lt_TRUE_Applic);

	MOV(R1, FPARG(R5));
	CMP(INDD(R0,1),INDD(R1,1));  /*comparing 2 args*/
    JUMP_LT(L_Lt_TRUE_LOOP);   /* jump if greater than*/
    JUMP(L_Lt_FALSE_Applic);

L_Lt_TRUE_LOOP:
    INCR(R5);
    JUMP(L_Lt_Applic_Loop);

L_Lt_FALSE_Applic:
    MOV(R0, IMM(3));
    JUMP(L_Lt_Applic_Exit);

L_Lt_TRUE_Applic:
  MOV(R0, IMM(5));

L_Lt_Applic_Exit:
	POP(R5);
    POP(R3);
    POP(R2);
    POP(R1);

	POP(FP);

	RETURN;
