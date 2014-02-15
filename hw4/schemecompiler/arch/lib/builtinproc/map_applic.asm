/* map function */

L_Map_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R7); /* save the procedure */
	PUSH(R8); /* Help Registry, First Loop -Save the Current list, Middle loop - Save the size of list , Last Loop - loop index */
	PUSH(R9); /* Begin - number of lists, End - size of list */
	PUSH(R10); /* Array of list location, in the end it convert to pointer to reuslt list */
	PUSH(R11); /* Pointer to paramter list, after it save temp */

L_Map_Make_A_List_Copy:	
	/* R7 is initialized with nil */
	MOV(R7,IMM(2));
	/* R8 is the displacement of the last argument */
	MOV(R8,FPARG(1));
	ADD(R8,IMM(1));
	
L_Map_Make_A_List_Copy_Loop:
	CMP(2,R8);
	JUMP_GT(L_Map_Make_A_List_Copy_Loop_End);
	PUSH(R7);
	PUSH(FPARG(R8));
	CALL(MAKE_SOB_PAIR);
	MOV(R7,R0);
	DROP(2);
	DECR(R8);
	JUMP(L_Map_Make_A_List_Copy_Loop);
	
L_Map_Make_A_List_Copy_Loop_End:

	MOV(R11, R0);

	/* Check if the first is null */
	PUSH(R11);
	CALL(IS_NIL);
	DROP(1);
	CMP(R0, 1);
	JUMP_EQ(L_error_not_enough_params_given);

	MOV(R7, INDD(R11,1));

	/* Check if R7 is closure */
	PUSH(R7);
	CALL(IS_CLOSURE);
	DROP(1);
	CMP(R0, 1);
	JUMP_NE(L_error_not_a_closure);

	MOV(R11, INDD(R11,2)); /* Go to next number pos */

	MOV(R9, 0);

	/* Build array of lists = Save the entry */
	PUSH(1);
	CALL(MALLOC);
	DROP(1);
	MOV(R10, R0);

/* This loop save in R9 the number of lists is get in paramters, and build an array on the memory. */
/* Every cell in the array is the first item of each list. */
/* R10 is the entry point for the array */

L_MAP_LOOP_COUNT_LISTS:
	/* Check if the Current is null */
	PUSH(R11);
	CALL(IS_NIL);
	DROP(1);
	CMP(R0, 1);
	JUMP_EQ(L_MAP_LOOP_COUNT_LISTS_END);

	MOV(R8, INDD(R11,1));

	/* Check if R8 is pair */
	PUSH(R8);
	CALL(IS_PAIR);
	DROP(1);
	CMP(R0, 1);
	JUMP_NE(L_error_not_a_closure);

	/* Build array of lists = Enlarge it by 1 */
	PUSH(1);
	CALL(MALLOC);
	DROP(1);
	MOV(IND(R0), R8);

	INCR(R9); /* Update the counter of lists */

	MOV(R11, INDD(R11,2)); /* Go to next number pos */
	JUMP(L_MAP_LOOP_COUNT_LISTS);

L_MAP_LOOP_COUNT_LISTS_END:

	MOV(R8,0); /* Save the size of the list */

L_MAP_LOOP_CALC:
	/* Check if we reach the end of list */
	/* We check only the first list because the input is valid! */
	PUSH(INDD(R10, 1));
	CALL(IS_NIL);
	DROP(1);
	CMP(R0, 1);
	JUMP_EQ(L_MAP_LOOP_CALC_END);

	MOV(IND(R10), R9); /* Save R9 */

L_MAP_LOOP_PUSH_ARG_FROM_EVERY_LIST:
	CMP(R9, 0);
	JUMP_EQ(L_MAP_LOOP_PUSH_ARG_FROM_EVERY_LIST_END);

	MOV(R11, INDD(R10, R9)); /* Jump to relevant list */
	/* MOV(R11, IND(R11)); /* Jump acctuly to the list */
	PUSH(INDD(R11,1)); /* Push the content of the current item */ 
	MOV(INDD(R10,R9), INDD(R11,2)); /* Set to next item in the list */

	DECR(R9);
	JUMP(L_MAP_LOOP_PUSH_ARG_FROM_EVERY_LIST);

L_MAP_LOOP_PUSH_ARG_FROM_EVERY_LIST_END:
	MOV(R9, IND(R10)); /* Recover R9 */ 

	PUSH(R9); /* Push the number of args */
	PUSH(INDD(R7, 1)); /* Push the env */
	CALLA(INDD(R7,2)); /* Applic the procedure */
	DROP(1);
	POP(R14);
	DROP(R14);

	PUSH(R0); /* Save the result to later */

	INCR(R8);
	JUMP(L_MAP_LOOP_CALC);
  
L_MAP_LOOP_CALC_END:
	MOV(R9, R8);  /* R9 - Size of result list */

	/* Reverse the list we create that sit on the stack, we need to do it for sending it to list function */
	PUSH(R9);
	CALL(MALLOC);
	DROP(1);
	MOV(R10, R0); /* Now R10 will be pointer to the result list */
	MOV(R8, 0);  /* R8 - loop index */

L_MAP_LOOP_REVERSE_RESULT:
	CMP(R8, R9);
	JUMP_EQ(L_MAP_LOOP_REVERSE_RESULT_END);

	POP(R11);
	MOV(INDD(R10, R8), R11);

	INCR(R8);
	JUMP(L_MAP_LOOP_REVERSE_RESULT);

L_MAP_LOOP_REVERSE_RESULT_END:
	MOV(R8, 0);  /* R8 - loop index */

L_MAP_LOOP_READY_FOR_MAKE_LIST:
	CMP(R8, R9);
	JUMP_EQ(L_MAP_LOOP_READY_FOR_MAKE_LIST_END);

	MOV(R11, INDD(R10, R8));
	PUSH(R11);

	INCR(R8);
	JUMP(L_MAP_LOOP_READY_FOR_MAKE_LIST);
	
L_MAP_LOOP_READY_FOR_MAKE_LIST_END:
	PUSH(R9); /* push number of args */
	PUSH(IMM(0)); /* env */
	CALL(L_Make_Result_List);
	DROP(2);
	DROP(R9);

	POP(R11);
	POP(R10);
	POP(R9);
	POP(R8);
	POP(R7);
	POP(FP);
	RETURN;