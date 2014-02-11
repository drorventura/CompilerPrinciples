/* scheme/write_sob_integer.asm
 * Take a pointer to a Scheme symbol object, and 
 * prints (to stdout) the character representation
 * of that object if symbol is a constant or the Scheme object it's bucket holds.
 * 
 * Programmer: Dror Ventura, 2014
 */

 WRITE_SOB_SYMBOL:
  PUSH(FP);
  MOV(FP, SP);
  MOV(R0, FPARG(0));
  MOV(R0, INDD(R0, 1));
  MOV(R0, INDD(R0, 2));
  
  CMP(R0, IMM(T_VOID));
  JUMP_EQ(WRITE_SOB_VOID);
  CMP(R0, IMM(T_NIL));
  JUMP_EQ(WRITE_SOB_NIL); 
  CMP(R0, IMM(T_BOOL));
  JUMP_EQ(WRITE_SOB_BOOL); 
  CMP(R0, IMM(T_CHAR));
  JUMP_EQ(WRITE_SOB_CHAR); 
  CMP(R0, IMM(T_INTEGER));
  JUMP_EQ(WRITE_SOB_INTEGER);
  CMP(R0, IMM(T_FRACTION));
  JUMP_EQ(WRITE_SOB_FRACTION);
  CMP(R0, IMM(T_STRING));
  JUMP_EQ(WRITE_SOB_STRING);
  CMP(R0, IMM(T_SYMBOL));
  JUMP_EQ(WRITE_SOB_SYMBOL);
  CMP(R0, IMM(T_PAIR));
  JUMP_EQ(WRITE_SOB_PAIR);
  CMP(R0, IMM(T_VECTOR));
  JUMP_EQ(WRITE_SOB_VECTOR);
  CMP(R0, IMM(T_CLOSURE));
  JUMP_EQ(WRITE_SOB_CLOSURE);
  
  PUSH(R0);
  CALL(PUTCHAR);
  DROP(1);
  POP(FP);
  RETURN;

