/* symbol_to_string.asm
 * 
 */

SYMBOL_TO_STRING:
	PUSH(FP);
	MOV(FP,SP);
	
	MOV(R0,INDD(FPARG(2),1));
	MOV(R0,IND(R0));
	POP(FP);
	RETURN;

