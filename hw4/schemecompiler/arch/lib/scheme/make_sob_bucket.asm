/* scheme/make_sob_bucket.asm
 * Takes the symbol's string as 1st argument, and its value or zero as 2nd argument,
 * and places in R0 the value
 * Programmer: Dror Ventura, 2014
 */

 MAKE_SOB_BUCKET:
  PUSH(FP);
  MOV(FP, SP);
  PUSH(IMM(3));
  CALL(MALLOC);
  DROP(1);
  MOV(IND(R0), T_BUCKET);
  MOV(INDD(R0,1), FPARG(0));
  MOV(INDD(R0,2), FPARG(1));
  POP(FP);
  RETURN;

