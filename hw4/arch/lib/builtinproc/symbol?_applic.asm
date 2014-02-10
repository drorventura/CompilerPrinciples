/* builtinproc/symbol?_applic.asm
 * Check if object is a symbol.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_Symbol_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure is sob symbol?*/
    CALL(IS_SOB_SYMBOL)

L_EXIT:
	POP(FP);
	RETURN;
