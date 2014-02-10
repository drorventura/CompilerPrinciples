/* builtinproc/digit_to_char_applic.asm
 * Converts digits to char.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Int_To_Char_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure that converts digit to char */
    CALL(DIGIT_TO_CHAR)

L_EXIT:
	POP(FP);
	RETURN;
