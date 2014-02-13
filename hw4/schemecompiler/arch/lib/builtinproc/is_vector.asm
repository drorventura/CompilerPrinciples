 /* is_vector.asm 
 * check is object is a vector.
 */

 IS_VECTOR:
  PUSH(FP);
  MOV(FP, SP);
  MOV(R0, FPARG(2));
  CMP(IND(R0), T_VECTOR);
  JUMP_EQ(L_IS_SOB_VECTOR_TRUE);
  MOV(R0, IMM(3));
  JUMP(L_IS_SOB_VECTOR_EXIT);

L_IS_SOB_VECTOR_TRUE:
  MOV(R0, IMM(5));

L_IS_SOB_VECTOR_EXIT:
  POP(FP);
  RETURN;



