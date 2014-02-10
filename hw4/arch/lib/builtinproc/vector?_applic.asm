/* builtinproc/vector?_applic.asm
 * Check if object is vector.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Is_Vector_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure is sob vector?*/
    CALL(IS_SOB_VECTOR)

L_EXIT:
	POP(FP);
	RETURN;
