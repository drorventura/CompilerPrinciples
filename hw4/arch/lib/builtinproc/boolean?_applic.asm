/* builtinproc/boolean?_applic.asm
 * Check if object is boolean.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_Boolean_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure that check if object is boolean */
    CALL(IS_SOB_BOOL)

L_EXIT:
	POP(FP);
	RETURN;
