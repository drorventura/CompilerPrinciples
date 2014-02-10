/* builtinproc/zero?_applic.asm
 * Check id object is zero.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_Zero_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure that check if number is zero */
    CALL(IS_ZERO)

L_EXIT:
	POP(FP);
	RETURN;
