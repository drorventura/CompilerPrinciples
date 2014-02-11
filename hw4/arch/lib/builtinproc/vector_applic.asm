/* builtinproc/vector_applic.asm
 * Returns an address for a new allocated vector
 *
 * Programmer: Eldar Damari, 2014
 */

L_Vector_Applic:
	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure make sob vector */
    CALL(MAKE_SOB_VECTOR)

	POP(FP);
	RETURN;
