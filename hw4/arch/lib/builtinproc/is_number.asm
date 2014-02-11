/* is_numer.asm
 * Check if object is integer or Fraction 
 */

 IS_NUMBER:

  PUSH(FP);
  MOV(FP, SP);
  MOV(R0, FPARG(2));

  CMP(IND(R0), T_INTEGER);
  JUMP_EQ(L_IS_NUMBER_TRUE);
  CMP(IND(R0), T_FRACTION);
  JUMP_EQ(L_IS_NUMBER_TRUE);
  
  MOV(R0, IMM(3));
  JUMP(L_IS_NUMBER_EXIT);

L_IS_NUMBER_TRUE:
  MOV(R0, IMM(5));

L_IS_NUMBER_EXIT:
  POP(FP);
  RETURN;


