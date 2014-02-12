/* symbol_to_string.asm
 * 
 */

L_SYMBOL_TO_STRING:
	PUSH(FP);
	MOV(FP,SP);

    PUSH(R1);
    PUSH(R2);	
    PUSH(R3);
    PUSH(R4);	

    MOV(R1,FPARG(2));
	MOV(R1,INDD(R1,1));
	MOV(R1,INDD(R1,1));
    MOV(R2,INDD(R1,1)); /*number of chars */
    INCR(R2);
    MOV(R3,R2);

    MOV(R4,INDD(R1,R2));

L_SYMBOL_TO_STRING_LOOP:
    CMP(R2,0);
    JUMP_EQ(L_SYMBOL_TO_STRING_MAKE_STRING);

    MOV(R4,INDD(R1,R2));
    PUSH(R4);
    DECR(R2);
    JUMP(L_SYMBOL_TO_STRING_LOOP);

L_SYMBOL_TO_STRING_MAKE_STRING:
    CALL(MAKE_SOB_STRING);
    DROP(R3);

    POP(R4);
    POP(R3);
    POP(R2);
    POP(R1);

	POP(FP);
	RETURN;
