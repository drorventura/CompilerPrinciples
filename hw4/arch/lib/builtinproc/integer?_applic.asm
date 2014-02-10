/* builtinproc/integer?_applic.asm
 * Check if object is integer.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_Int_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure that check if number is zero */
    CALL(IS_ZERO)

L_EXIT:
	POP(FP);
	RETURN;
