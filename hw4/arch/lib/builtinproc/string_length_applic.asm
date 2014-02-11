/* builtinproc/string_length_applic.asm
 * Returns strlen.
 *
 * Programmer: Eldar Damari, 2014
 */

L_String_Length_String_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure to calc string length */
    CALL(STRLEN)

L_EXIT:
	POP(FP);
	RETURN;
