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
		PUSH(IMM(77));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(6));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(5));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(2));
		PUSH(IMM(3));
		CALL(MAKE_SOB_FRACTION);
		DROP(2);
		PUSH(IMM(4));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM('+'));
		PUSH(IMM(1));
		CALL(MAKE_SOB_STRING);
		DROP(2);
		PUSH(IMM('0'));
		PUSH(IMM(18));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(21));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		/* end of creating constant table */


		MOV(R0,IMM(7));

		/* push on stack the codegen of the parameter: 77 */
		PUSH(R0);
		MOV(R0,IMM(9));

		/* push on stack the codegen of the parameter: 6 */
		PUSH(R0);
		MOV(R0,IMM(11));

		/* push on stack the codegen of the parameter: 5 */
		PUSH(R0);
		MOV(R0,IMM(13));

		/* push on stack the codegen of the parameter: 3/2 */
		PUSH(R0);
		MOV(R0,IMM(16));

		/* push on stack the codegen of the parameter: 4 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(5));

		/* get the symbol from memory for the procedure */
		MOV(R0,IMM(24));

        MOV(R0,INDD(R0,1));
        /* R0 now holds the pointer to the symbol's bucket */
        PUSH(R1);
        /* backup R1 in order to use it */
        MOV(R1,R0);
        /* R1 now holds the pointer to the symbol's bucket */
        PUSH(LABEL(L_Plus_Applic));

        /* push the "empty" environment for free vars */
        PUSH(0);
        CALL (MAKE_SOB_CLOSURE);
        DROP(2);
        /* R0 now holds the pointer to the closure */
        MOV(INDD(R1,2),R0);
        /* save the closure as the value in symbol's bucket */
        POP(R1);
        /* restore R1 to be what it was before */
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
