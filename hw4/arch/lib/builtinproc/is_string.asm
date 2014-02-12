/* is_string.asm
 * Check if object is type string.
 */

 IS_STRING:

printf("start is_string\n");

  PUSH(FP);
  MOV(FP, SP);
  MOV(R0, FPARG(2));

/* fails with (string? 's) the quote 
 * get seg fault in IND(R0), working without IND())
 */
  CMP(IND(R0), T_STRING);
  JUMP_EQ(L_IS_STRING_TRUE);
printf("NOT equal put FALSE\n");
  
  MOV(R0, IMM(3));
  JUMP(L_IS_STRING_EXIT);

L_IS_STRING_TRUE:
printf("equal put TRUE\n");
  MOV(R0, IMM(5));

L_IS_STRING_EXIT:
  POP(FP);
  RETURN;


