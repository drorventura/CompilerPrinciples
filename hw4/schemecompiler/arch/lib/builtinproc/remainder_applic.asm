/* builtinproc/plus_applic.asm
 * Compute Remainderr
 *
 * Programmer: Eldar Damari, 2014
 */

L_Remainder_Applic:
	PUSH(FP);
	MOV(FP, SP);
	PUSH(R1);
	PUSH(R2);

    REM(FPARG(3),FPARG(2)); //TODO args indices are good?

L_Remainder_Applic_Exit:
	POP(R2);
	POP(R1);
	POP(FP);
	
	PUSH(R0);
	CALL(WRITE_INTEGER);
	DROP(2);
	
	RETURN;
