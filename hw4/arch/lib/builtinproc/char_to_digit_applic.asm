/* builtinproc/char_to_digit_applic.asm
 * Converts char to digit.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Char_To_Int_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure that converts char to digit */
    CALL(CHAR_TO_INT)

L_EXIT:
	POP(FP);
	RETURN;
