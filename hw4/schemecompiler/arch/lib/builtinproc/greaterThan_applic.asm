/* builtinproc/lessThan_applic.asm
 * Compute Greater Than
 *
 */

L_Gt_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
    PUSH(R3);
    PUSH(R5);

    MOV(R3,FPARG(1));
    CMP(R3,1);
    JUMP_EQ(L_Gt_TRUE_Applic);

    INCR(R3);
	MOV(R0, FPARG(2));
    MOV(R5,2);

L_Gt_Applic_Loop:
    CMP(R5,R3);
    JUMP_EQ(L_Gt_TRUE_Applic);

	MOV(R1, FPARG(R5));
	CMP(INDD(R0,1),INDD(R1,1));  /*comparing 2 args*/
    JUMP_GT(L_Gt_TRUE_LOOP);   /* jump if greater than*/
    JUMP(L_Gt_FALSE_Applic);

L_Gt_TRUE_LOOP:
    INCR(R5);
    JUMP(L_Gt_Applic_Loop);

L_Gt_FALSE_Applic:
    MOV(R0, IMM(3));
    JUMP(L_Gt_Applic_Exit);

L_Gt_TRUE_Applic:
  MOV(R0, IMM(5));

L_Gt_Applic_Exit:
	POP(R5);
    POP(R3);
    POP(R2);
    POP(R1);
	POP(FP);

	RETURN;
