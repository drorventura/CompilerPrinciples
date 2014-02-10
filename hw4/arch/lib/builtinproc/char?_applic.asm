/* builtinproc/char?_applic.asm
 * Check if object is char.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_Char_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure that check if object is boolean */
    CALL(IS_SOB_CHAR)

L_EXIT:
	POP(FP);
	RETURN;
