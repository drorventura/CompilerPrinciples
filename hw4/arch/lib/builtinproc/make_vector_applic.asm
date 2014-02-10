/* builtinproc/make_vector_applic.asm
 * Creates a vector.
 *
 * Programmer: Eldar Damari, 2014
 */

L_Make_Vector_Applic:

	PUSH(FP);
	MOV(FP, SP);

    /* Calling builtin procedure to make sob vector */
    CALL(MAKE_SOB_VECTOR)

L_EXIT:
	POP(FP);
	RETURN;
