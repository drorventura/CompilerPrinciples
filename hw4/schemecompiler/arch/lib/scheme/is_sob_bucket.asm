/* scheme/is_sob_bucket.asm
 * Take pointers to a Scheme object, and places in R0 either 0 or 1
 * (long, not Scheme integer objects or Scheme boolean objets),
 * depending on whether the argument is integer.
 * 
 * Programmer: Dror Ventura, 2014
 */

 IS_SOB_BUCKET:
  PUSH(FP);
  MOV(FP, SP);
  MOV(R0, FPARG(0));
  CMP(IND(R0), T_BUCKET);
  JUMP_EQ(L_IS_SOB_BUCKET_TRUE);
  MOV(R0, IMM(0));
  JUMP(L_IS_SOB_BUCKET_EXIT);
 L_IS_SOB_BUCKET_TRUE:
  MOV(R0, IMM(1));
 L_IS_SOB_BUCKET_EXIT:
  POP(FP);
  RETURN;


