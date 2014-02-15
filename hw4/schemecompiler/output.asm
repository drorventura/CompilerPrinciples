#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./arch/cisc.h"
int main()
{
    START_MACHINE;
    JUMP(CONTINUE);

    #include "./arch/char.lib"
    #include "./arch/io.lib"
    #include "./arch/math.lib"
    #include "./arch/scheme.lib"
    #include "./arch/string.lib"
    #include "./arch/system.lib"
    #include "./arch/builtin.lib"

    #define VOID IMM(1)
    #define NIL IMM(2)
    #define BOOL_FALSE IMM(3)
    #define BOOL_TRUE IMM(5)

    CONTINUE:
        /* make void constant */
        CALL(MAKE_SOB_VOID);

        /* make nil constant */
        CALL(MAKE_SOB_NIL);

        /* make boolean False constant */
        PUSH(IMM(0));
        CALL(MAKE_SOB_BOOL);
        DROP(1);

        /* make boolean True constant */
        PUSH(IMM(1));
        CALL(MAKE_SOB_BOOL);
        DROP(1);
		/* make constant table*/
		PUSH(IMM('Y'));
		PUSH(IMM('A'));
		PUSH(IMM('G'));
		PUSH(IMM(3));
		CALL(MAKE_SOB_STRING);
		DROP(4);
		PUSH(IMM(0));
		PUSH(IMM(7));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(12));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(L_APPLY_APPLIC));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('A'));
		PUSH(IMM('P'));
		PUSH(IMM('P'));
		PUSH(IMM('L'));
		PUSH(IMM('Y'));
		PUSH(IMM(5));
		CALL(MAKE_SOB_STRING);
		DROP(6);
		PUSH(IMM(17));
		PUSH(IMM(20));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(27));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(L_Map_Applic));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('M'));
		PUSH(IMM('A'));
		PUSH(IMM('P'));
		PUSH(IMM(3));
		CALL(MAKE_SOB_STRING);
		DROP(4);
		PUSH(IMM(32));
		PUSH(IMM(35));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(40));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(CAR));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('C'));
		PUSH(IMM('A'));
		PUSH(IMM('R'));
		PUSH(IMM(3));
		CALL(MAKE_SOB_STRING);
		DROP(4);
		PUSH(IMM(45));
		PUSH(IMM(48));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(53));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('X'));
		PUSH(IMM(1));
		CALL(MAKE_SOB_STRING);
		DROP(2);
		PUSH(IMM(0));
		PUSH(IMM(58));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(61));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM(10));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(5));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(6));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		/* end of creating constant table */

		MOV(R0,IMM(15));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_61);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_61:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_61);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_61);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_61);
	L_Expansion_Of_Empty_Env_61:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_61);

	L_Shallow_Copy_OldEnv_Exit_61:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_61:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_61);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_61);

	L_Copy_Params_To_NewEnv_Exit_61:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_61:
		PUSH(LABEL(L_CLOS_CODE_61));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_61);

	L_CLOS_CODE_61:

        PUSH(FP);
        MOV(FP,SP);
        /*PUSH(R1);
        PUSH(R2);
        PUSH(R3);
        PUSH(R4);*/

        /* R1 holds the num of params in stack */
        MOV(R1,FPARG(1));
        /* R2 holds the num of args the lambda takes */
        MOV(R2,IMM(1));

        MOV(R3,R2);
        DECR(R3);
        /* compare between num of arg in lambda and num of params in stack */
        CMP(R3,R1);
        JUMP_EQ(L_Stack_Fix_Up_61);
		JUMP_LT(L_Stack_Fix_Down_61);
		JUMP(L_error_not_enough_params_given);

	L_Stack_Fix_Down_61:

        /* R3 holds the displacement for the params in stack */
        MOV(R3,R1);
        INCR(R3);

        /* pushing nil on stack */
        PUSH(IMM(2));
        /* pushing last param in stack */
        PUSH(FPARG(R3));
        /* R0 holds the last pair */
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        
	L_Create_Pairs_Loop_61:
		CMP(R3,R2);
		JUMP_EQ(L_Create_Pairs_Loop_Exit_61);

        /* pushing previous pair */
        PUSH(R0);
        PUSH(FPARG(R3));
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        JUMP(L_Create_Pairs_Loop_61);

	L_Create_Pairs_Loop_Exit_61:

        /* R3 holds the displacement of the optional parameters of the lambda */
        MOV(R3,R2);
        INCR(R3);           /* numOfArgs + 1 */
        MOV(FPARG(R3),R0);

        /* update the number of parameters on stack */
        MOV(FPARG(1),R2);

        /* drop the relevant elements to the buttom of the stack */
        MOV(R4,R1);
        SUB(R4,R2);
        /* R4 holds the how much spaces the element need's to be dropped down */
        MOV(R5,R2);
        ADD(R5,3);
        /* R5 hold the amount of times we drom elements down */
        
	L_Move_Stack_Down_Loop_61:
		CMP(R5,IMM(0));
		JUMP_EQ(L_Move_Stack_Down_Loop_Exit_61);

        MOV(R6,R3);
        ADD(R6,R4);
        MOV(FPARG(R6),FPARG(R3));
        DECR(R3);
        DECR(R5);
        JUMP(L_Move_Stack_Down_Loop_61);

	L_Move_Stack_Down_Loop_Exit_61:

        /* frame pointer and stack pointers needs to be brought down as well */
        SUB(FP,R4);
        DROP(R4);
        JUMP(L_After_Stack_Fix_61);

	L_Stack_Fix_Up_61:

        /* R4 contains the num of args of lambda
        MOV(R4,R2);*/

        /* increment the number of params in stack by 1 */
        INCR(FPARG(1));

        /* stack pointer needs to go up by 1 */
        /*INCR(SP);*/
        PUSH(IMM(0));

        MOV(R3,IMM(-2));
        MOV(R4,IMM(-3));
        INCR(R1);
        
	L_Move_Stack_Up_Loop_61:
		CMP(R3,R1);
		JUMP_GT(L_Move_Stack_Up_Loop_Exit_61);

        MOV(FPARG(R4),FPARG(R3));
        INCR(R3);
        INCR(R4);
		JUMP(L_Move_Stack_Up_Loop_61);

	L_Move_Stack_Up_Loop_Exit_61:
        /* magic number */
        MOV(FPARG(R4),IMM(7109179));
        INCR(FP);
        	L_After_Stack_Fix_61:
		/* CodeGen Body Of Lambda */
		/* ((LAMBDA (MS) (APPLY (CAR MS) MS)) (MAP (LAMBDA (FI) (LAMBDA MS (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS)))) FS)) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: FS */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(1));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_63);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_63:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_63);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_63);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_63);
	L_Expansion_Of_Empty_Env_63:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_63);

	L_Shallow_Copy_OldEnv_Exit_63:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_63:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_63);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_63);

	L_Copy_Params_To_NewEnv_Exit_63:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_63:
		PUSH(LABEL(L_CLOS_CODE_63));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_63);
	L_CLOS_CODE_63:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (FI) (LAMBDA MS (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS)))) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (LAMBDA MS (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS))) */
		/* checking the lambda depth*/
		MOV(R1,IMM(2));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_64);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_64:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_64);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_64);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_64);
	L_Expansion_Of_Empty_Env_64:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_64);

	L_Shallow_Copy_OldEnv_Exit_64:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_64:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_64);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_64);

	L_Copy_Params_To_NewEnv_Exit_64:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_64:
		PUSH(LABEL(L_CLOS_CODE_64));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_64);

	L_CLOS_CODE_64:

        PUSH(FP);
        MOV(FP,SP);
        /*PUSH(R1);
        PUSH(R2);
        PUSH(R3);
        PUSH(R4);*/

        /* R1 holds the num of params in stack */
        MOV(R1,FPARG(1));
        /* R2 holds the num of args the lambda takes */
        MOV(R2,IMM(1));

        MOV(R3,R2);
        DECR(R3);
        /* compare between num of arg in lambda and num of params in stack */
        CMP(R3,R1);
        JUMP_EQ(L_Stack_Fix_Up_64);
		JUMP_LT(L_Stack_Fix_Down_64);
		JUMP(L_error_not_enough_params_given);

	L_Stack_Fix_Down_64:

        /* R3 holds the displacement for the params in stack */
        MOV(R3,R1);
        INCR(R3);

        /* pushing nil on stack */
        PUSH(IMM(2));
        /* pushing last param in stack */
        PUSH(FPARG(R3));
        /* R0 holds the last pair */
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        
	L_Create_Pairs_Loop_64:
		CMP(R3,R2);
		JUMP_EQ(L_Create_Pairs_Loop_Exit_64);

        /* pushing previous pair */
        PUSH(R0);
        PUSH(FPARG(R3));
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        JUMP(L_Create_Pairs_Loop_64);

	L_Create_Pairs_Loop_Exit_64:

        /* R3 holds the displacement of the optional parameters of the lambda */
        MOV(R3,R2);
        INCR(R3);           /* numOfArgs + 1 */
        MOV(FPARG(R3),R0);

        /* update the number of parameters on stack */
        MOV(FPARG(1),R2);

        /* drop the relevant elements to the buttom of the stack */
        MOV(R4,R1);
        SUB(R4,R2);
        /* R4 holds the how much spaces the element need's to be dropped down */
        MOV(R5,R2);
        ADD(R5,3);
        /* R5 hold the amount of times we drom elements down */
        
	L_Move_Stack_Down_Loop_64:
		CMP(R5,IMM(0));
		JUMP_EQ(L_Move_Stack_Down_Loop_Exit_64);

        MOV(R6,R3);
        ADD(R6,R4);
        MOV(FPARG(R6),FPARG(R3));
        DECR(R3);
        DECR(R5);
        JUMP(L_Move_Stack_Down_Loop_64);

	L_Move_Stack_Down_Loop_Exit_64:

        /* frame pointer and stack pointers needs to be brought down as well */
        SUB(FP,R4);
        DROP(R4);
        JUMP(L_After_Stack_Fix_64);

	L_Stack_Fix_Up_64:

        /* R4 contains the num of args of lambda
        MOV(R4,R2);*/

        /* increment the number of params in stack by 1 */
        INCR(FPARG(1));

        /* stack pointer needs to go up by 1 */
        /*INCR(SP);*/
        PUSH(IMM(0));

        MOV(R3,IMM(-2));
        MOV(R4,IMM(-3));
        INCR(R1);
        
	L_Move_Stack_Up_Loop_64:
		CMP(R3,R1);
		JUMP_GT(L_Move_Stack_Up_Loop_Exit_64);

        MOV(FPARG(R4),FPARG(R3));
        INCR(R3);
        INCR(R4);
		JUMP(L_Move_Stack_Up_Loop_64);

	L_Move_Stack_Up_Loop_Exit_64:
        /* magic number */
        MOV(FPARG(R4),IMM(7109179));
        INCR(FP);
        	L_After_Stack_Fix_64:
		/* CodeGen Body Of Lambda */
		/* (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS)) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: MS */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(3));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_66);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_66:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_66);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_66);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_66);
	L_Expansion_Of_Empty_Env_66:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_66);

	L_Shallow_Copy_OldEnv_Exit_66:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_66:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_66);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_66);

	L_Copy_Params_To_NewEnv_Exit_66:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_66:
		PUSH(LABEL(L_CLOS_CODE_66));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_66);
	L_CLOS_CODE_66:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS)) */
		/* checking the lambda depth*/
		MOV(R1,IMM(4));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_67);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_67:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_67);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_67);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_67);
	L_Expansion_Of_Empty_Env_67:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_67);

	L_Shallow_Copy_OldEnv_Exit_67:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_67:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_67);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_67);

	L_Copy_Params_To_NewEnv_Exit_67:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_67:
		PUSH(LABEL(L_CLOS_CODE_67));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_67);

	L_CLOS_CODE_67:

        PUSH(FP);
        MOV(FP,SP);
        /*PUSH(R1);
        PUSH(R2);
        PUSH(R3);
        PUSH(R4);*/

        /* R1 holds the num of params in stack */
        MOV(R1,FPARG(1));
        /* R2 holds the num of args the lambda takes */
        MOV(R2,IMM(1));

        MOV(R3,R2);
        DECR(R3);
        /* compare between num of arg in lambda and num of params in stack */
        CMP(R3,R1);
        JUMP_EQ(L_Stack_Fix_Up_67);
		JUMP_LT(L_Stack_Fix_Down_67);
		JUMP(L_error_not_enough_params_given);

	L_Stack_Fix_Down_67:

        /* R3 holds the displacement for the params in stack */
        MOV(R3,R1);
        INCR(R3);

        /* pushing nil on stack */
        PUSH(IMM(2));
        /* pushing last param in stack */
        PUSH(FPARG(R3));
        /* R0 holds the last pair */
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        
	L_Create_Pairs_Loop_67:
		CMP(R3,R2);
		JUMP_EQ(L_Create_Pairs_Loop_Exit_67);

        /* pushing previous pair */
        PUSH(R0);
        PUSH(FPARG(R3));
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        JUMP(L_Create_Pairs_Loop_67);

	L_Create_Pairs_Loop_Exit_67:

        /* R3 holds the displacement of the optional parameters of the lambda */
        MOV(R3,R2);
        INCR(R3);           /* numOfArgs + 1 */
        MOV(FPARG(R3),R0);

        /* update the number of parameters on stack */
        MOV(FPARG(1),R2);

        /* drop the relevant elements to the buttom of the stack */
        MOV(R4,R1);
        SUB(R4,R2);
        /* R4 holds the how much spaces the element need's to be dropped down */
        MOV(R5,R2);
        ADD(R5,3);
        /* R5 hold the amount of times we drom elements down */
        
	L_Move_Stack_Down_Loop_67:
		CMP(R5,IMM(0));
		JUMP_EQ(L_Move_Stack_Down_Loop_Exit_67);

        MOV(R6,R3);
        ADD(R6,R4);
        MOV(FPARG(R6),FPARG(R3));
        DECR(R3);
        DECR(R5);
        JUMP(L_Move_Stack_Down_Loop_67);

	L_Move_Stack_Down_Loop_Exit_67:

        /* frame pointer and stack pointers needs to be brought down as well */
        SUB(FP,R4);
        DROP(R4);
        JUMP(L_After_Stack_Fix_67);

	L_Stack_Fix_Up_67:

        /* R4 contains the num of args of lambda
        MOV(R4,R2);*/

        /* increment the number of params in stack by 1 */
        INCR(FPARG(1));

        /* stack pointer needs to go up by 1 */
        /*INCR(SP);*/
        PUSH(IMM(0));

        MOV(R3,IMM(-2));
        MOV(R4,IMM(-3));
        INCR(R1);
        
	L_Move_Stack_Up_Loop_67:
		CMP(R3,R1);
		JUMP_GT(L_Move_Stack_Up_Loop_Exit_67);

        MOV(FPARG(R4),FPARG(R3));
        INCR(R3);
        INCR(R4);
		JUMP(L_Move_Stack_Up_Loop_67);

	L_Move_Stack_Up_Loop_Exit_67:
        /* magic number */
        MOV(FPARG(R4),IMM(7109179));
        INCR(FP);
        	L_After_Stack_Fix_67:
		/* CodeGen Body Of Lambda */
		/* (APPLY (APPLY MI MS) ARGS) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: ARGS */
		PUSH(R0);
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,0));

		/* push on stack the codegen of the parameter: MS */
		PUSH(R0);
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,0));
		MOV(R0,INDD(R0,0));

		/* push on stack the codegen of the parameter: MI */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(30));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* jumps to closure's code and returns here */
        CALLA(INDD(R0,2));

        /* not in tail position so after closure code returns here */
        DROP(1);
        /* drops the env from stack */
        POP(R1);
        /* get the number of params from stack to R1 */
        DROP(R1);
        /* clear the stack */
        
		/* push on stack the codegen of the parameter: (APPLY MI MS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(30));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* this applic is in tail position therefore the return address from here is to previous return address */
        PUSH(FPARG(-1));
        /* R1 <- oldfp */
        MOV(R1,FPARG(-2));

        /* R2 will hold the position of last LOCAL on stack */
        MOV(R2,SP);
        DECR(R2);
        SUB(R2,FP);

        /* R3 will hold the position of first LOCAL on stack */
        MOV(R3,IMM(0));

        /* R4 will hold the position of first arg in the previous frame */
        MOV(R4,FPARG(1));
        INCR(R4);

        /* R5 will hold the old num of arguments */
        MOV(R5,FPARG(1));
        
	L_Override_Previous_Frame_Loop_68:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_68);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_68);
		
	L_Override_Previous_Frame_Loop_Exit_68:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(2));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));

        /* restoring the registers that where used */
        /* POP(R4);
        POP(R3);
        POP(R2);
        POP(R1); */
        POP(FP);
        RETURN;
        
	L_CLOS_EXIT_67:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_66:

		/* push on stack the codegen of the parameter: (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(43));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* jumps to closure's code and returns here */
        CALLA(INDD(R0,2));

        /* not in tail position so after closure code returns here */
        DROP(1);
        /* drops the env from stack */
        POP(R1);
        /* get the number of params from stack to R1 */
        DROP(R1);
        /* clear the stack */
        
		/* push on stack the codegen of the parameter: (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS) */
		PUSH(R0);
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,0));
		MOV(R0,INDD(R0,0));

		/* push on stack the codegen of the parameter: FI */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(30));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* this applic is in tail position therefore the return address from here is to previous return address */
        PUSH(FPARG(-1));
        /* R1 <- oldfp */
        MOV(R1,FPARG(-2));

        /* R2 will hold the position of last LOCAL on stack */
        MOV(R2,SP);
        DECR(R2);
        SUB(R2,FP);

        /* R3 will hold the position of first LOCAL on stack */
        MOV(R3,IMM(0));

        /* R4 will hold the position of first arg in the previous frame */
        MOV(R4,FPARG(1));
        INCR(R4);

        /* R5 will hold the old num of arguments */
        MOV(R5,FPARG(1));
        
	L_Override_Previous_Frame_Loop_65:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_65);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_65);
		
	L_Override_Previous_Frame_Loop_Exit_65:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(2));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));

        /* restoring the registers that where used */
        /* POP(R4);
        POP(R3);
        POP(R2);
        POP(R1); */
        POP(FP);
        RETURN;
        
	L_CLOS_EXIT_64:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_63:

		/* push on stack the codegen of the parameter: (LAMBDA (FI) (LAMBDA MS (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS)))) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(43));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* jumps to closure's code and returns here */
        CALLA(INDD(R0,2));

        /* not in tail position so after closure code returns here */
        DROP(1);
        /* drops the env from stack */
        POP(R1);
        /* get the number of params from stack to R1 */
        DROP(R1);
        /* clear the stack */
        
		/* push on stack the codegen of the parameter: (MAP (LAMBDA (FI) (LAMBDA MS (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS)))) FS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		/* checking the lambda depth*/
		MOV(R1,IMM(1));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_69);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_69:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_69);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_69);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_69);
	L_Expansion_Of_Empty_Env_69:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_69);

	L_Shallow_Copy_OldEnv_Exit_69:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_69:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_69);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_69);

	L_Copy_Params_To_NewEnv_Exit_69:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_69:
		PUSH(LABEL(L_CLOS_CODE_69));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_69);
	L_CLOS_CODE_69:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (MS) (APPLY (CAR MS) MS)) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (APPLY (CAR MS) MS) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: MS */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: MS */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(56));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* jumps to closure's code and returns here */
        CALLA(INDD(R0,2));

        /* not in tail position so after closure code returns here */
        DROP(1);
        /* drops the env from stack */
        POP(R1);
        /* get the number of params from stack to R1 */
        DROP(R1);
        /* clear the stack */
        
		/* push on stack the codegen of the parameter: (CAR MS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(30));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* this applic is in tail position therefore the return address from here is to previous return address */
        PUSH(FPARG(-1));
        /* R1 <- oldfp */
        MOV(R1,FPARG(-2));

        /* R2 will hold the position of last LOCAL on stack */
        MOV(R2,SP);
        DECR(R2);
        SUB(R2,FP);

        /* R3 will hold the position of first LOCAL on stack */
        MOV(R3,IMM(0));

        /* R4 will hold the position of first arg in the previous frame */
        MOV(R4,FPARG(1));
        INCR(R4);

        /* R5 will hold the old num of arguments */
        MOV(R5,FPARG(1));
        
	L_Override_Previous_Frame_Loop_70:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_70);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_70);
		
	L_Override_Previous_Frame_Loop_Exit_70:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(2));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_69:
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));

        /* this applic is in tail position therefore the return address from here is to previous return address */
        PUSH(FPARG(-1));
        /* R1 <- oldfp */
        MOV(R1,FPARG(-2));

        /* R2 will hold the position of last LOCAL on stack */
        MOV(R2,SP);
        DECR(R2);
        SUB(R2,FP);

        /* R3 will hold the position of first LOCAL on stack */
        MOV(R3,IMM(0));

        /* R4 will hold the position of first arg in the previous frame */
        MOV(R4,FPARG(1));
        INCR(R4);

        /* R5 will hold the old num of arguments */
        MOV(R5,FPARG(1));
        
	L_Override_Previous_Frame_Loop_62:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_62);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_62);
		
	L_Override_Previous_Frame_Loop_Exit_62:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));

        /* restoring the registers that where used */
        /* POP(R4);
        POP(R3);
        POP(R2);
        POP(R1); */
        POP(FP);
        RETURN;
        
	L_CLOS_EXIT_61:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
		MOV(R0,IMM(64));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		MOV(R0,IMM(66));

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
		MOV(R0,IMM(64));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		MOV(R0,IMM(68));

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
		MOV(R0,IMM(64));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
		MOV(R0,IMM(64));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		MOV(R0,IMM(68));

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
		MOV(R0,IMM(64));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		MOV(R0,IMM(70));

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
		MOV(R0,IMM(64));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
		MOV(R0,IMM(70));

        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);
		MOV(R0,IMM(68));

        PUSH(R0);
        CALL(WRITE_SOB);
        POP(R0);
        CALL(NEWLINE);

    L_exit:
    STOP_MACHINE;
    return 0;

    /* exceptions */
    L_error_not_a_closure:
        printf("Error - Not a closure");
        JUMP(L_exit);

    L_error_not_enough_params_given:
        printf("Error - Not enough parameters where given");
        JUMP(L_exit);
}
