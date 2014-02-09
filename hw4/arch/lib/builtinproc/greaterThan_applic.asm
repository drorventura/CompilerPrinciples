/* builtinproc/lessThan_applic.asm
 * Compute Variadic Greater Than
 *
 * Programmer: Eldar Damari, 2014
 */

L_Gt_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	/* accumulator */
	MOV(R0, IMM(0));
	/* num of arguments on stack */
	MOV(R1, FPARG(1));
	ADD(R1, IMM(1));
/* initial test if a < b out, else jump to leesLoop */
L_Gt_Applic_Loop:
	CMP(R1, IMM(1));
	JUMP_EQ(L_Gt_Applic_Exit);			
	MOV(R2, FPARG(R1));
	MOV(R3, FPARG(R1-1));
	CMP(INDD(R2,1),INDD(R3,1));  /*comparing 2 args*/
    JUMP_LG(L_Gt_Applic_Exit);   /* jump if greater than*/
    JUMP_GT(L_Gt_greaterLoop);

/*if a < b than R2 <- a and R1 <- R1-1
 * keep with leesLoop until out of arguments*/
L_Gt_greaterLoop:
    DECR(R1);
	CMP(R1, IMM(1));
	JUMP_EQ(L_Gt_Applic_Exit);			
	MOV(R3, FPARG(R1-1));
	CMP(INDD(R2,1),INDD(R3,1));  /*comparing 2 args*/
    JUMP_LT(L_Gt_Applic_Exit);   /* jump if greater than*/
    JUMP_GT(L_Gt_lessLoop);

L_Gt_Applic_Exit:
	POP(R2);
	POP(R1);
	POP(FP);
	
	PUSH(R0);
	CALL(WRITE_INTEGER);
	DROP(1);
	
	RETURN;
