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
		/* end of creating constant table */


		MOV(R0,IMM(3));
		PUSH(R0);
		PUSH(IMM(1));
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_0);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(IMM(R1));
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        int i,j;
        for(i=0,j=1 ; i < IMM(R3) ; ++i,++j)
        {
             MOV(INDD(R1,j),INDD(R2,i));
        }
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(IMM(R3));
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        for(i=0,j=2 ; i < IMM(R3) ; ++i,++j)
        {
             MOV(INDD(R0,i),FPARG(j));
        }
        MOV(IND(R1),R0);             /* move the params to new env before calling make_sob_closure */
    
	L_After_Env_Expansion_0:
		PUSH(LABEL(L_CLOS_CODE_0));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_0);
	L_CLOS_CODE_0:
		PUSH(FP);
		MOV(FP,SP);
		PUSH(R1);
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_EQ(L_error_not_enough_params_given);
		PUSH(IMM(0));
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_0);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(IMM(R1));
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        int i,j;
        for(i=0,j=1 ; i < IMM(R3) ; ++i,++j)
        {
             MOV(INDD(R1,j),INDD(R2,i));
        }
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(IMM(R3));
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        for(i=0,j=2 ; i < IMM(R3) ; ++i,++j)
        {
             MOV(INDD(R0,i),FPARG(j));
        }
        MOV(IND(R1),R0);             /* move the params to new env before calling make_sob_closure */
    
	L_After_Env_Expansion_0:
		PUSH(LABEL(L_CLOS_CODE_0));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_0);
	L_CLOS_CODE_0:
		PUSH(FP);
		MOV(FP,SP);
		PUSH(R1);
		MOV(R1,IMM(0));
		CMP(R1,FPARG(1));
		JUMP_EQ(L_error_not_enough_params_given);
MOV(R0,FPARG(0))MOV(R0,INDD(R0,0)MOV(R0,INDD(R0,0)		POP(R1);
		POP(FP);
		RETURN;
	L_CLOS_EXIT_0:
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));
		CALLA(INDD(R0,2));
		DROP(1);
		POP(R1);
		DROP(R1);
		POP(R1);
		POP(FP);
		RETURN;
	L_CLOS_EXIT_1:
		CMP (IND(R0), T_CLOSURE);
		JUMP_NE(L_error_not_a_closure);
		PUSH (INDD(R0,1));
		CALLA(INDD(R0,2));
		DROP(1);
		POP(R1);
		DROP(R1);

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
