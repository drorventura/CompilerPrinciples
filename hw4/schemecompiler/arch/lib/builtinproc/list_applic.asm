/* builtinproc/vector_applic.asm
 * Returns an address for a new allocated vector
 *
 * Programmer: Dror Ventura, 2014
 */

L_List_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);
	
	MOV(R1,FPARG(1));		/* number of parameters to push */
	CMP(R1,0);
	JUMP_EQ(L_List_Applic_Empty);

	/*MOV(R2,R1);*/		  
	INCR(R1);			/* displacement in stack to first argument */
	
	PUSH(IMM(2));
	PUSH(FPARG(R1));
	CALL(MAKE_SOB_PAIR);
	DROP(2);
	DECR(R1);
		
L_List_Applic_Loop:
	CMP(R1,IMM(1));
	JUMP_EQ(L_List_Applic_Loop_Exit);
	
	PUSH(R0);
	PUSH(FPARG(R1));
	CALL(MAKE_SOB_PAIR);
	DROP(2);
	
	DECR(R1);
	JUMP(L_List_Applic_Loop);

L_List_Applic_Empty:
	MOV(R0,IMM(2));
	
L_List_Applic_Loop_Exit:
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;
