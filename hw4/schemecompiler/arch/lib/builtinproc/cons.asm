/* cons.asm
 * apply cons scheme function.
 */

CONS:
	PUSH(FP);
	MOV(FP,SP);
	PUSH(R1);
	PUSH(R2);

	MOV(R1,FPARG(2));
	MOV(R2,FPARG(3));

	PUSH(R2);
	PUSH(R1);

	CALL(MAKE_SOB_PAIR);

	DROP(2);
	POP(R2);
	POP(R1);
	POP(FP);
	RETURN;
