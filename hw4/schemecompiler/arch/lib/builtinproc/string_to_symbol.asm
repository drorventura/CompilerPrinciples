/* string_to_symbol.asm
 */

L_STRING_TO_SYMBOL:

	PUSH(FP);
	MOV(FP,SP);

    PUSH(FPARG(2));
    PUSH(FPARG(2));
    CALL(MAKE_SOB_BUCKET);
    DROP(2);
    
    PUSH(R0);
    CALL(MAKE_SOB_SYMBOL);
    DROP(1);
    
	POP(FP);
	RETURN;
