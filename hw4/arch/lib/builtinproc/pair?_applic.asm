/* builtinproc/pair?_applic.asm
 * Check if object is pair.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_Pair_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure is sob pair?*/
    CALL(IS_SOB_PAIR)

L_EXIT:
	POP(FP);
	RETURN;
