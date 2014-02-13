LIST_TO_APPLY:
	PUSH(FP);
	MOV(FP, SP);

	CMP(FPARG(0),IMM(2));			/* DONE? */
	JUMP_NE(LIST_TO_APPLY_NOT_NULL);
	MOV(R0, FPARG(1));				/* DONE, ANS IN R0 */
	JUMP(LIST_TO_APPLY_EXIT);
	
LIST_TO_APPLY_NOT_NULL:
	PUSH(FPARG(1));   				/* SO FAR */
	MOV(R10,FPARG(0));
	PUSH(INDD(R10,1)); 				/* CURRENT */
	CALL(MAKE_SOB_PAIR);
	DROP(2);
 
	PUSH(R0); 						/* SO FAR */
	MOV(R10,FPARG(0));
	PUSH(INDD(R10,2));				/* LIST TO APPLY */
	CALL(LIST_TO_APPLY);
	DROP(2);

LIST_TO_APPLY_EXIT:
 POP(FP);
 RETURN;