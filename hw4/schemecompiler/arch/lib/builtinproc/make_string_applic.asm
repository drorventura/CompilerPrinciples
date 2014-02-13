/* builtinproc/make_string_applic.asm
 * Creates a string.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Make_String_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure to make sob string */
    CALL(MAKE_SOB_STRING)

L_EXIT:
	POP(FP);
	RETURN;
