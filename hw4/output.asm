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
		PUSH(IMM(5));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		/* end of creating constant table */


		MOV(R0,IMM(7));

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
