/* builtinproc/string?_applic.asm
 * Check if object is string.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_string_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure is sob vector?*/
    CALL(IS_SOB_STRING)

L_EXIT:
	POP(FP);
	RETURN;
