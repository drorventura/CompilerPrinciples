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
		PUSH(IMM('A'));
		PUSH(IMM('C'));
		PUSH(IMM('C'));
		PUSH(IMM('U'));
		PUSH(IMM('M'));
		PUSH(IMM('U'));
		PUSH(IMM('L'));
		PUSH(IMM('A'));
		PUSH(IMM('T'));
		PUSH(IMM('E'));
		PUSH(IMM(10));
		CALL(MAKE_SOB_STRING);
		DROP(11);
		PUSH(IMM(0));
		PUSH(IMM(58));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(70));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(IS_SOB_NIL));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('N'));
		PUSH(IMM('U'));
		PUSH(IMM('L'));
		PUSH(IMM('L'));
		PUSH(IMM('?'));
		PUSH(IMM(5));
		CALL(MAKE_SOB_STRING);
		DROP(6);
		PUSH(IMM(75));
		PUSH(IMM(78));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(85));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(CDR));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('C'));
		PUSH(IMM('D'));
		PUSH(IMM('R'));
		PUSH(IMM(3));
		CALL(MAKE_SOB_STRING);
		DROP(4);
		PUSH(IMM(90));
		PUSH(IMM(93));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(98));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('L'));
		PUSH(IMM('S'));
		PUSH(IMM(2));
		CALL(MAKE_SOB_STRING);
		DROP(3);
		PUSH(IMM(0));
		PUSH(IMM(103));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(107));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM(9));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(2));
		PUSH(IMM(112));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(8));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(114));
		PUSH(IMM(117));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(2));
		PUSH(IMM(119));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(7));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(2));
		PUSH(IMM(125));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(6));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(127));
		PUSH(IMM(130));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(4));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(132));
		PUSH(IMM(135));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(122));
		PUSH(IMM(137));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(3));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(2));
		PUSH(IMM(143));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(2));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(145));
		PUSH(IMM(148));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(1));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(150));
		PUSH(IMM(153));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(140));
		PUSH(IMM(155));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(LABEL(L_List_Applic));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('L'));
		PUSH(IMM('I'));
		PUSH(IMM('S'));
		PUSH(IMM('T'));
		PUSH(IMM(4));
		CALL(MAKE_SOB_STRING);
		DROP(5);
		PUSH(IMM(161));
		PUSH(IMM(164));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(170));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(L_APPEND_Applic));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('A'));
		PUSH(IMM('P'));
		PUSH(IMM('P'));
		PUSH(IMM('E'));
		PUSH(IMM('N'));
		PUSH(IMM('D'));
		PUSH(IMM(6));
		CALL(MAKE_SOB_STRING);
		DROP(7);
		PUSH(IMM(175));
		PUSH(IMM(178));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(186));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('F'));
		PUSH(IMM('L'));
		PUSH(IMM('A'));
		PUSH(IMM('T'));
		PUSH(IMM('M'));
		PUSH(IMM('A'));
		PUSH(IMM('P'));
		PUSH(IMM(7));
		CALL(MAKE_SOB_STRING);
		DROP(8);
		PUSH(IMM(0));
		PUSH(IMM(191));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(200));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('F'));
		PUSH(IMM('I'));
		PUSH(IMM('L'));
		PUSH(IMM('T'));
		PUSH(IMM('E'));
		PUSH(IMM('R'));
		PUSH(IMM('1'));
		PUSH(IMM(7));
		CALL(MAKE_SOB_STRING);
		DROP(8);
		PUSH(IMM(0));
		PUSH(IMM(205));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(214));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(CONS));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('C'));
		PUSH(IMM('O'));
		PUSH(IMM('N'));
		PUSH(IMM('S'));
		PUSH(IMM(4));
		CALL(MAKE_SOB_STRING);
		DROP(5);
		PUSH(IMM(219));
		PUSH(IMM(222));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(228));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(REMAINDER));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('R'));
		PUSH(IMM('E'));
		PUSH(IMM('M'));
		PUSH(IMM('A'));
		PUSH(IMM('I'));
		PUSH(IMM('N'));
		PUSH(IMM('D'));
		PUSH(IMM('E'));
		PUSH(IMM('R'));
		PUSH(IMM(9));
		CALL(MAKE_SOB_STRING);
		DROP(10);
		PUSH(IMM(233));
		PUSH(IMM(236));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(247));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(L_Equal_Applic));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('='));
		PUSH(IMM(1));
		CALL(MAKE_SOB_STRING);
		DROP(2);
		PUSH(IMM(252));
		PUSH(IMM(255));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(258));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('I'));
		PUSH(IMM('D'));
		PUSH(IMM(2));
		CALL(MAKE_SOB_STRING);
		DROP(3);
		PUSH(IMM(0));
		PUSH(IMM(263));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(267));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('F'));
		PUSH(IMM('I'));
		PUSH(IMM('B'));
		PUSH(IMM('$'));
		PUSH(IMM(4));
		CALL(MAKE_SOB_STRING);
		DROP(5);
		PUSH(IMM(0));
		PUSH(IMM(272));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(278));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM(0));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(LABEL(L_Plus_Applic));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('+'));
		PUSH(IMM(1));
		CALL(MAKE_SOB_STRING);
		DROP(2);
		PUSH(IMM(285));
		PUSH(IMM(288));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(291));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(L_Minus_Applic));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('-'));
		PUSH(IMM(1));
		CALL(MAKE_SOB_STRING);
		DROP(2);
		PUSH(IMM(296));
		PUSH(IMM(299));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(302));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('N'));
		PUSH(IMM('O'));
		PUSH(IMM('T'));
		PUSH(IMM('1'));
		PUSH(IMM(4));
		CALL(MAKE_SOB_STRING);
		DROP(5);
		PUSH(IMM(0));
		PUSH(IMM(307));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(313));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('M'));
		PUSH(IMM('U'));
		PUSH(IMM('L'));
		PUSH(IMM('-'));
		PUSH(IMM('L'));
		PUSH(IMM('I'));
		PUSH(IMM('S'));
		PUSH(IMM('T'));
		PUSH(IMM('$'));
		PUSH(IMM(9));
		CALL(MAKE_SOB_STRING);
		DROP(10);
		PUSH(IMM(0));
		PUSH(IMM(318));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(329));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(IS_SOB_PAIR));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('P'));
		PUSH(IMM('A'));
		PUSH(IMM('I'));
		PUSH(IMM('R'));
		PUSH(IMM('?'));
		PUSH(IMM(5));
		CALL(MAKE_SOB_STRING);
		DROP(6);
		PUSH(IMM(334));
		PUSH(IMM(337));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(344));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(IS_NUMBER));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('N'));
		PUSH(IMM('U'));
		PUSH(IMM('M'));
		PUSH(IMM('B'));
		PUSH(IMM('E'));
		PUSH(IMM('R'));
		PUSH(IMM('?'));
		PUSH(IMM(7));
		CALL(MAKE_SOB_STRING);
		DROP(8);
		PUSH(IMM(349));
		PUSH(IMM(352));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(361));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM('N'));
		PUSH(IMM('O'));
		PUSH(IMM('T'));
		PUSH(IMM('-'));
		PUSH(IMM('A'));
		PUSH(IMM('-'));
		PUSH(IMM('N'));
		PUSH(IMM('U'));
		PUSH(IMM('M'));
		PUSH(IMM('B'));
		PUSH(IMM('E'));
		PUSH(IMM('R'));
		PUSH(IMM('!'));
		PUSH(IMM(13));
		CALL(MAKE_SOB_STRING);
		DROP(14);
		PUSH(IMM(366));
		PUSH(IMM(366));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(381));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(LABEL(L_Multi_Applic));
		/* push the "empty" environment for free vars */
		PUSH(0);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		PUSH(IMM('*'));
		PUSH(IMM(1));
		CALL(MAKE_SOB_STRING);
		DROP(2);
		PUSH(IMM(386));
		PUSH(IMM(389));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(392));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM(10));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM(5));
		CALL(MAKE_SOB_INTEGER);
		DROP(1);
		PUSH(IMM('A'));
		PUSH(IMM(1));
		CALL(MAKE_SOB_STRING);
		DROP(2);
		PUSH(IMM(401));
		PUSH(IMM(401));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(404));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM(2));
		PUSH(IMM(407));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM('Q'));
		PUSH(IMM('U'));
		PUSH(IMM('O'));
		PUSH(IMM('T'));
		PUSH(IMM('E'));
		PUSH(IMM(5));
		CALL(MAKE_SOB_STRING);
		DROP(6);
		PUSH(IMM(412));
		PUSH(IMM(412));
		CALL(MAKE_SOB_BUCKET);
		DROP(2);
		PUSH(IMM(419));
		CALL(MAKE_SOB_SYMBOL);
		DROP(1);
		PUSH(IMM(409));
		PUSH(IMM(422));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(2));
		PUSH(IMM(424));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(427));
		PUSH(IMM(125));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(430));
		PUSH(IMM(130));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(2));
		PUSH(IMM(433));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(2));
		PUSH(IMM(399));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(439));
		PUSH(IMM(135));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(442));
		PUSH(IMM(143));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(436));
		PUSH(IMM(445));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(448));
		PUSH(IMM(148));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		PUSH(IMM(451));
		PUSH(IMM(153));
		CALL(MAKE_SOB_PAIR);
		DROP(2);
		/* end of creating constant table */

		MOV(R0,IMM(15));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_0);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_0:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_0);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_0);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_0);
	L_Expansion_Of_Empty_Env_0:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_0);

	L_Shallow_Copy_OldEnv_Exit_0:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_0:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_0);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_0);

	L_Copy_Params_To_NewEnv_Exit_0:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_0:
		PUSH(LABEL(L_CLOS_CODE_0));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_0);

	L_CLOS_CODE_0:

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
        JUMP_EQ(L_Stack_Fix_Up_0);
		JUMP_LT(L_Stack_Fix_Down_0);
		JUMP(L_error_not_enough_params_given);

	L_Stack_Fix_Down_0:

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
        
	L_Create_Pairs_Loop_0:
		CMP(R3,R2);
		JUMP_EQ(L_Create_Pairs_Loop_Exit_0);

        /* pushing previous pair */
        PUSH(R0);
        PUSH(FPARG(R3));
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        JUMP(L_Create_Pairs_Loop_0);

	L_Create_Pairs_Loop_Exit_0:

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
        ADD(R5,4);
        /* R5 hold the amount of times we drom elements down */
        
	L_Move_Stack_Down_Loop_0:
		CMP(R5,IMM(0));
		JUMP_EQ(L_Move_Stack_Down_Loop_Exit_0);

        MOV(R6,R3);
        ADD(R6,R4);
        MOV(FPARG(R6),FPARG(R3));
        DECR(R3);
        DECR(R5);
        JUMP(L_Move_Stack_Down_Loop_0);

	L_Move_Stack_Down_Loop_Exit_0:

        /* frame pointer and stack pointers needs to be brought down as well */
        SUB(FP,R4);
        DROP(R4);
        JUMP(L_After_Stack_Fix_0);

	L_Stack_Fix_Up_0:

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
        
	L_Move_Stack_Up_Loop_0:
		CMP(R3,R1);
		JUMP_GT(L_Move_Stack_Up_Loop_Exit_0);

        MOV(FPARG(R4),FPARG(R3));
        INCR(R3);
        INCR(R4);
		JUMP(L_Move_Stack_Up_Loop_0);

	L_Move_Stack_Up_Loop_Exit_0:
        /* magic number */
        MOV(FPARG(R4),IMM(7109179));
        INCR(FP);
        	L_After_Stack_Fix_0:
		/* CodeGen Body Of Lambda */
		/* ((LAMBDA (MS) (APPLY (CAR MS) MS)) (MAP (LAMBDA (FI) (LAMBDA MS (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS)))) FS)) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: FS */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(1));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_2);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_2:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_2);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_2);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_2);
	L_Expansion_Of_Empty_Env_2:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_2);

	L_Shallow_Copy_OldEnv_Exit_2:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_2:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_2);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_2);

	L_Copy_Params_To_NewEnv_Exit_2:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_2:
		PUSH(LABEL(L_CLOS_CODE_2));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_2);
	L_CLOS_CODE_2:
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
		JUMP_EQ(L_After_Env_Expansion_3);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_3:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_3);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_3);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_3);
	L_Expansion_Of_Empty_Env_3:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_3);

	L_Shallow_Copy_OldEnv_Exit_3:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_3:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_3);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_3);

	L_Copy_Params_To_NewEnv_Exit_3:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_3:
		PUSH(LABEL(L_CLOS_CODE_3));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_3);

	L_CLOS_CODE_3:

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
        JUMP_EQ(L_Stack_Fix_Up_3);
		JUMP_LT(L_Stack_Fix_Down_3);
		JUMP(L_error_not_enough_params_given);

	L_Stack_Fix_Down_3:

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
        
	L_Create_Pairs_Loop_3:
		CMP(R3,R2);
		JUMP_EQ(L_Create_Pairs_Loop_Exit_3);

        /* pushing previous pair */
        PUSH(R0);
        PUSH(FPARG(R3));
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        JUMP(L_Create_Pairs_Loop_3);

	L_Create_Pairs_Loop_Exit_3:

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
        ADD(R5,4);
        /* R5 hold the amount of times we drom elements down */
        
	L_Move_Stack_Down_Loop_3:
		CMP(R5,IMM(0));
		JUMP_EQ(L_Move_Stack_Down_Loop_Exit_3);

        MOV(R6,R3);
        ADD(R6,R4);
        MOV(FPARG(R6),FPARG(R3));
        DECR(R3);
        DECR(R5);
        JUMP(L_Move_Stack_Down_Loop_3);

	L_Move_Stack_Down_Loop_Exit_3:

        /* frame pointer and stack pointers needs to be brought down as well */
        SUB(FP,R4);
        DROP(R4);
        JUMP(L_After_Stack_Fix_3);

	L_Stack_Fix_Up_3:

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
        
	L_Move_Stack_Up_Loop_3:
		CMP(R3,R1);
		JUMP_GT(L_Move_Stack_Up_Loop_Exit_3);

        MOV(FPARG(R4),FPARG(R3));
        INCR(R3);
        INCR(R4);
		JUMP(L_Move_Stack_Up_Loop_3);

	L_Move_Stack_Up_Loop_Exit_3:
        /* magic number */
        MOV(FPARG(R4),IMM(7109179));
        INCR(FP);
        	L_After_Stack_Fix_3:
		/* CodeGen Body Of Lambda */
		/* (APPLY FI (MAP (LAMBDA (MI) (LAMBDA ARGS (APPLY (APPLY MI MS) ARGS))) MS)) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: MS */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(3));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_5);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_5:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_5);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_5);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_5);
	L_Expansion_Of_Empty_Env_5:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_5);

	L_Shallow_Copy_OldEnv_Exit_5:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_5:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_5);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_5);

	L_Copy_Params_To_NewEnv_Exit_5:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_5:
		PUSH(LABEL(L_CLOS_CODE_5));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_5);
	L_CLOS_CODE_5:
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
		JUMP_EQ(L_After_Env_Expansion_6);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_6:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_6);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_6);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_6);
	L_Expansion_Of_Empty_Env_6:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_6);

	L_Shallow_Copy_OldEnv_Exit_6:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_6:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_6);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_6);

	L_Copy_Params_To_NewEnv_Exit_6:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_6:
		PUSH(LABEL(L_CLOS_CODE_6));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_6);

	L_CLOS_CODE_6:

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
        JUMP_EQ(L_Stack_Fix_Up_6);
		JUMP_LT(L_Stack_Fix_Down_6);
		JUMP(L_error_not_enough_params_given);

	L_Stack_Fix_Down_6:

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
        
	L_Create_Pairs_Loop_6:
		CMP(R3,R2);
		JUMP_EQ(L_Create_Pairs_Loop_Exit_6);

        /* pushing previous pair */
        PUSH(R0);
        PUSH(FPARG(R3));
        CALL(MAKE_SOB_PAIR);
        DROP(2);
        DECR(R3);
        JUMP(L_Create_Pairs_Loop_6);

	L_Create_Pairs_Loop_Exit_6:

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
        ADD(R5,4);
        /* R5 hold the amount of times we drom elements down */
        
	L_Move_Stack_Down_Loop_6:
		CMP(R5,IMM(0));
		JUMP_EQ(L_Move_Stack_Down_Loop_Exit_6);

        MOV(R6,R3);
        ADD(R6,R4);
        MOV(FPARG(R6),FPARG(R3));
        DECR(R3);
        DECR(R5);
        JUMP(L_Move_Stack_Down_Loop_6);

	L_Move_Stack_Down_Loop_Exit_6:

        /* frame pointer and stack pointers needs to be brought down as well */
        SUB(FP,R4);
        DROP(R4);
        JUMP(L_After_Stack_Fix_6);

	L_Stack_Fix_Up_6:

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
        
	L_Move_Stack_Up_Loop_6:
		CMP(R3,R1);
		JUMP_GT(L_Move_Stack_Up_Loop_Exit_6);

        MOV(FPARG(R4),FPARG(R3));
        INCR(R3);
        INCR(R4);
		JUMP(L_Move_Stack_Up_Loop_6);

	L_Move_Stack_Up_Loop_Exit_6:
        /* magic number */
        MOV(FPARG(R4),IMM(7109179));
        INCR(FP);
        	L_After_Stack_Fix_6:
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
        
	L_Override_Previous_Frame_Loop_7:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_7);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_7);
		
	L_Override_Previous_Frame_Loop_Exit_7:
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
        
	L_CLOS_EXIT_6:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_5:

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
        
	L_Override_Previous_Frame_Loop_4:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_4);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_4);
		
	L_Override_Previous_Frame_Loop_Exit_4:
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
        
	L_CLOS_EXIT_3:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_2:

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
		JUMP_EQ(L_After_Env_Expansion_8);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_8:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_8);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_8);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_8);
	L_Expansion_Of_Empty_Env_8:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_8);

	L_Shallow_Copy_OldEnv_Exit_8:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_8:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_8);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_8);

	L_Copy_Params_To_NewEnv_Exit_8:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_8:
		PUSH(LABEL(L_CLOS_CODE_8));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_8);
	L_CLOS_CODE_8:
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
        
	L_Override_Previous_Frame_Loop_9:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_9);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_9);
		
	L_Override_Previous_Frame_Loop_Exit_9:
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
	L_CLOS_EXIT_8:
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
        
	L_Override_Previous_Frame_Loop_1:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_1);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_1);
		
	L_Override_Previous_Frame_Loop_Exit_1:
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
        
	L_CLOS_EXIT_0:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
		MOV(R0,IMM(73));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_10);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_10:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_10);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_10);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_10);
	L_Expansion_Of_Empty_Env_10:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_10);

	L_Shallow_Copy_OldEnv_Exit_10:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_10:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_10);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_10);

	L_Copy_Params_To_NewEnv_Exit_10:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_10:
		PUSH(LABEL(L_CLOS_CODE_10));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_10);
	L_CLOS_CODE_10:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (OP INITIAL SEQUENCE) (IF (NULL? SEQUENCE) INITIAL (OP (CAR SEQUENCE) (ACCUMULATE OP INITIAL (CDR SEQUENCE))))) */
		MOV(R1,IMM(3));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (IF (NULL? SEQUENCE) INITIAL (OP (CAR SEQUENCE) (ACCUMULATE OP INITIAL (CDR SEQUENCE)))) */
		MOV(R0,FPARG(4));

		/* push on stack the codegen of the parameter: SEQUENCE */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(88));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_11);
		MOV(R0,FPARG(3));
		JUMP(L_END_IF_11);
		L_DIF_11:
		MOV(R0,FPARG(4));

		/* push on stack the codegen of the parameter: SEQUENCE */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(101));
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
        
		/* push on stack the codegen of the parameter: (CDR SEQUENCE) */
		PUSH(R0);
		MOV(R0,FPARG(3));

		/* push on stack the codegen of the parameter: INITIAL */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: OP */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(73));
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
        
		/* push on stack the codegen of the parameter: (ACCUMULATE OP INITIAL (CDR SEQUENCE)) */
		PUSH(R0);
		MOV(R0,FPARG(4));

		/* push on stack the codegen of the parameter: SEQUENCE */
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
        
		/* push on stack the codegen of the parameter: (CAR SEQUENCE) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,FPARG(2));
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
        
	L_Override_Previous_Frame_Loop_12:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_12);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_12);
		
	L_Override_Previous_Frame_Loop_Exit_12:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(2));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		L_END_IF_11:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_10:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(110));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		MOV(R0,IMM(158));

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(110));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_14);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_14:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_14);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_14);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_14);
	L_Expansion_Of_Empty_Env_14:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_14);

	L_Shallow_Copy_OldEnv_Exit_14:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_14:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_14);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_14);

	L_Copy_Params_To_NewEnv_Exit_14:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_14:
		PUSH(LABEL(L_CLOS_CODE_14));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_14);
	L_CLOS_CODE_14:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) X) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* X */
		MOV(R0,FPARG(2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_14:

		/* push on stack the codegen of the parameter: (LAMBDA (X) X) */
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
        
		/* push on stack the codegen of the parameter: (MAP (LAMBDA (X) X) LS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(0));
		MOV(R0,IMM(173));
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
        
		/* push on stack the codegen of the parameter: (LIST) */
		PUSH(R0);
		MOV(R0,IMM(189));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: APPEND */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(73));
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
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(110));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);
		MOV(R0,IMM(101));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: CDR */
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
        
		/* push on stack the codegen of the parameter: (MAP CDR LS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(0));
		MOV(R0,IMM(173));
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
        
		/* push on stack the codegen of the parameter: (LIST) */
		PUSH(R0);
		MOV(R0,IMM(189));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: APPEND */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(73));
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
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(203));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_15);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_15:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_15);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_15);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_15);
	L_Expansion_Of_Empty_Env_15:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_15);

	L_Shallow_Copy_OldEnv_Exit_15:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_15:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_15);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_15);

	L_Copy_Params_To_NewEnv_Exit_15:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_15:
		PUSH(LABEL(L_CLOS_CODE_15));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_15);
	L_CLOS_CODE_15:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (PROC SEQ) (ACCUMULATE APPEND (LIST) (MAP PROC SEQ))) */
		MOV(R1,IMM(2));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (ACCUMULATE APPEND (LIST) (MAP PROC SEQ)) */
		MOV(R0,FPARG(3));

		/* push on stack the codegen of the parameter: SEQ */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: PROC */
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
        
		/* push on stack the codegen of the parameter: (MAP PROC SEQ) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(0));
		MOV(R0,IMM(173));
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
        
		/* push on stack the codegen of the parameter: (LIST) */
		PUSH(R0);
		MOV(R0,IMM(189));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: APPEND */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(73));
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
        
	L_Override_Previous_Frame_Loop_16:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_16);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_16);
		
	L_Override_Previous_Frame_Loop_Exit_16:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(3));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_15:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(217));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_17);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_17:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_17);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_17);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_17);
	L_Expansion_Of_Empty_Env_17:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_17);

	L_Shallow_Copy_OldEnv_Exit_17:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_17:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_17);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_17);

	L_Copy_Params_To_NewEnv_Exit_17:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_17:
		PUSH(LABEL(L_CLOS_CODE_17));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_17);
	L_CLOS_CODE_17:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (PRED? LST) (IF (NULL? LST) (LIST) (IF (PRED? (CAR LST)) (CONS (CAR LST) (FILTER1 PRED? (CDR LST))) (FILTER1 PRED? (CDR LST))))) */
		MOV(R1,IMM(2));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (IF (NULL? LST) (LIST) (IF (PRED? (CAR LST)) (CONS (CAR LST) (FILTER1 PRED? (CDR LST))) (FILTER1 PRED? (CDR LST)))) */
		MOV(R0,FPARG(3));

		/* push on stack the codegen of the parameter: LST */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(88));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_18);

		/* push to stack the number of parameters */
		PUSH(IMM(0));
		MOV(R0,IMM(173));
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
        
	L_Override_Previous_Frame_Loop_19:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_19);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_19);
		
	L_Override_Previous_Frame_Loop_Exit_19:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(0));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		JUMP(L_END_IF_18);
		L_DIF_18:
		MOV(R0,FPARG(3));

		/* push on stack the codegen of the parameter: LST */
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
        
		/* push on stack the codegen of the parameter: (CAR LST) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(2));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_20);
		MOV(R0,FPARG(3));

		/* push on stack the codegen of the parameter: LST */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(101));
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
        
		/* push on stack the codegen of the parameter: (CDR LST) */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: PRED? */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(217));
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
        
		/* push on stack the codegen of the parameter: (FILTER1 PRED? (CDR LST)) */
		PUSH(R0);
		MOV(R0,FPARG(3));

		/* push on stack the codegen of the parameter: LST */
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
        
		/* push on stack the codegen of the parameter: (CAR LST) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(231));
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
        
	L_Override_Previous_Frame_Loop_21:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_21);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_21);
		
	L_Override_Previous_Frame_Loop_Exit_21:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(2));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		JUMP(L_END_IF_20);
		L_DIF_20:
		MOV(R0,FPARG(3));

		/* push on stack the codegen of the parameter: LST */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(101));
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
        
		/* push on stack the codegen of the parameter: (CDR LST) */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: PRED? */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(217));
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
        
	L_Override_Previous_Frame_Loop_22:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_22);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_22);
		
	L_Override_Previous_Frame_Loop_Exit_22:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(2));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		L_END_IF_20:
		L_END_IF_18:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_17:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(110));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_23);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_23:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_23);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_23);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_23);
	L_Expansion_Of_Empty_Env_23:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_23);

	L_Shallow_Copy_OldEnv_Exit_23:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_23:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_23);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_23);

	L_Copy_Params_To_NewEnv_Exit_23:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_23:
		PUSH(LABEL(L_CLOS_CODE_23));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_23);
	L_CLOS_CODE_23:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (LST) (FILTER1 (LAMBDA (X) (= (REMAINDER X 2) 1)) LST)) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (FILTER1 (LAMBDA (X) (= (REMAINDER X 2) 1)) LST) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: LST */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(1));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_25);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_25:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_25);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_25);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_25);
	L_Expansion_Of_Empty_Env_25:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_25);

	L_Shallow_Copy_OldEnv_Exit_25:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_25:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_25);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_25);

	L_Copy_Params_To_NewEnv_Exit_25:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_25:
		PUSH(LABEL(L_CLOS_CODE_25));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_25);
	L_CLOS_CODE_25:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) (= (REMAINDER X 2) 1)) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (= (REMAINDER X 2) 1) */
		MOV(R0,IMM(153));

		/* push on stack the codegen of the parameter: 1 */
		PUSH(R0);
		MOV(R0,IMM(148));

		/* push on stack the codegen of the parameter: 2 */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: X */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(250));
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
        
		/* push on stack the codegen of the parameter: (REMAINDER X 2) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(261));
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
        
	L_Override_Previous_Frame_Loop_26:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_26);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_26);
		
	L_Override_Previous_Frame_Loop_Exit_26:
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
	L_CLOS_EXIT_25:

		/* push on stack the codegen of the parameter: (LAMBDA (X) (= (REMAINDER X 2) 1)) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(217));
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
        
	L_Override_Previous_Frame_Loop_24:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_24);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_24);
		
	L_Override_Previous_Frame_Loop_Exit_24:
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
	L_CLOS_EXIT_23:

		/* push on stack the codegen of the parameter: (LAMBDA (LST) (FILTER1 (LAMBDA (X) (= (REMAINDER X 2) 1)) LST)) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(203));
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
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(270));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_27);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_27:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_27);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_27);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_27);
	L_Expansion_Of_Empty_Env_27:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_27);

	L_Shallow_Copy_OldEnv_Exit_27:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_27:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_27);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_27);

	L_Copy_Params_To_NewEnv_Exit_27:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_27:
		PUSH(LABEL(L_CLOS_CODE_27));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_27);
	L_CLOS_CODE_27:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) X) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* X */
		MOV(R0,FPARG(2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_27:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(281));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_28);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_28:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_28);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_28);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_28);
	L_Expansion_Of_Empty_Env_28:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_28);

	L_Shallow_Copy_OldEnv_Exit_28:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_28:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_28);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_28);

	L_Copy_Params_To_NewEnv_Exit_28:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_28:
		PUSH(LABEL(L_CLOS_CODE_28));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_28);
	L_CLOS_CODE_28:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (N C) (IF (= N 0) (C 0) (IF (= N 1) (C 1) (FIB$ (- N 1) (LAMBDA (FIB-N-1) (FIB$ (- N 2) (LAMBDA (FIB-N-2) (C (+ FIB-N-1 FIB-N-2))))))))) */
		MOV(R1,IMM(2));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (IF (= N 0) (C 0) (IF (= N 1) (C 1) (FIB$ (- N 1) (LAMBDA (FIB-N-1) (FIB$ (- N 2) (LAMBDA (FIB-N-2) (C (+ FIB-N-1 FIB-N-2)))))))) */
		MOV(R0,IMM(283));

		/* push on stack the codegen of the parameter: 0 */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: N */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(261));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_29);
		MOV(R0,IMM(283));

		/* push on stack the codegen of the parameter: 0 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(3));
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
        
	L_Override_Previous_Frame_Loop_30:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_30);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_30);
		
	L_Override_Previous_Frame_Loop_Exit_30:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		JUMP(L_END_IF_29);
		L_DIF_29:
		MOV(R0,IMM(153));

		/* push on stack the codegen of the parameter: 1 */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: N */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(261));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_31);
		MOV(R0,IMM(153));

		/* push on stack the codegen of the parameter: 1 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(3));
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
        
	L_Override_Previous_Frame_Loop_32:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_32);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_32);
		
	L_Override_Previous_Frame_Loop_Exit_32:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		JUMP(L_END_IF_31);
		L_DIF_31:
		/* checking the lambda depth*/
		MOV(R1,IMM(1));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_34);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_34:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_34);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_34);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_34);
	L_Expansion_Of_Empty_Env_34:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_34);

	L_Shallow_Copy_OldEnv_Exit_34:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_34:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_34);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_34);

	L_Copy_Params_To_NewEnv_Exit_34:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_34:
		PUSH(LABEL(L_CLOS_CODE_34));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_34);
	L_CLOS_CODE_34:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (FIB-N-1) (FIB$ (- N 2) (LAMBDA (FIB-N-2) (C (+ FIB-N-1 FIB-N-2))))) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (FIB$ (- N 2) (LAMBDA (FIB-N-2) (C (+ FIB-N-1 FIB-N-2)))) */
		/* checking the lambda depth*/
		MOV(R1,IMM(2));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_36);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_36:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_36);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_36);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_36);
	L_Expansion_Of_Empty_Env_36:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_36);

	L_Shallow_Copy_OldEnv_Exit_36:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_36:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_36);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_36);

	L_Copy_Params_To_NewEnv_Exit_36:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_36:
		PUSH(LABEL(L_CLOS_CODE_36));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_36);
	L_CLOS_CODE_36:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (FIB-N-2) (C (+ FIB-N-1 FIB-N-2))) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (C (+ FIB-N-1 FIB-N-2)) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: FIB-N-2 */
		PUSH(R0);
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,0));
		MOV(R0,INDD(R0,0));

		/* push on stack the codegen of the parameter: FIB-N-1 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(294));
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
        
		/* push on stack the codegen of the parameter: (+ FIB-N-1 FIB-N-2) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,1));
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
        
	L_Override_Previous_Frame_Loop_37:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_37);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_37);
		
	L_Override_Previous_Frame_Loop_Exit_37:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_36:

		/* push on stack the codegen of the parameter: (LAMBDA (FIB-N-2) (C (+ FIB-N-1 FIB-N-2))) */
		PUSH(R0);
		MOV(R0,IMM(148));

		/* push on stack the codegen of the parameter: 2 */
		PUSH(R0);
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,0));
		MOV(R0,INDD(R0,0));

		/* push on stack the codegen of the parameter: N */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(305));
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
        
		/* push on stack the codegen of the parameter: (- N 2) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(281));
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
        
	L_Override_Previous_Frame_Loop_35:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_35);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_35);
		
	L_Override_Previous_Frame_Loop_Exit_35:
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
	L_CLOS_EXIT_34:

		/* push on stack the codegen of the parameter: (LAMBDA (FIB-N-1) (FIB$ (- N 2) (LAMBDA (FIB-N-2) (C (+ FIB-N-1 FIB-N-2))))) */
		PUSH(R0);
		MOV(R0,IMM(153));

		/* push on stack the codegen of the parameter: 1 */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: N */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(305));
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
        
		/* push on stack the codegen of the parameter: (- N 1) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(281));
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
        
	L_Override_Previous_Frame_Loop_33:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_33);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_33);
		
	L_Override_Previous_Frame_Loop_Exit_33:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(2));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		L_END_IF_31:
		L_END_IF_29:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_28:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(270));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,2));
		/* R0 now holds the pointer to the closure */

		/* push on stack the codegen of the parameter: ID */
		PUSH(R0);
		MOV(R0,IMM(125));

		/* push on stack the codegen of the parameter: 7 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(281));
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
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(316));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_38);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_38:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_38);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_38);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_38);
	L_Expansion_Of_Empty_Env_38:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_38);

	L_Shallow_Copy_OldEnv_Exit_38:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_38:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_38);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_38);

	L_Copy_Params_To_NewEnv_Exit_38:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_38:
		PUSH(LABEL(L_CLOS_CODE_38));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_38);
	L_CLOS_CODE_38:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) (IF X #f #t)) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (IF X #f #t) */
		MOV(R0,FPARG(2));
		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_39);
		MOV(R0,IMM(3));
		JUMP(L_END_IF_39);
		L_DIF_39:
		MOV(R0,IMM(5));
		L_END_IF_39:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_38:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		MOV(R0,IMM(332));
		MOV(R15,R0);     /*Saving symbol's address*/
		MOV(R15,INDD(R15,1));     /* R15 now contains the pointer to the value of the symbol's bucket */
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_40);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_40:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_40);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_40);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_40);
	L_Expansion_Of_Empty_Env_40:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_40);

	L_Shallow_Copy_OldEnv_Exit_40:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_40:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_40);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_40);

	L_Copy_Params_To_NewEnv_Exit_40:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_40:
		PUSH(LABEL(L_CLOS_CODE_40));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_40);
	L_CLOS_CODE_40:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (LS SUCC FAIL) (IF (NULL? LS) (SUCC 1) (IF (NOT1 (PAIR? LS)) (IF (NUMBER? LS) (SUCC LS) (FAIL (QUOTE NOT-A-NUMBER!))) (MUL-LIST$ (CAR LS) (LAMBDA (MUL-CAR) (MUL-LIST$ (CDR LS) (LAMBDA (MUL-CDR) (SUCC (* MUL-CAR MUL-CDR))) FAIL)) FAIL)))) */
		MOV(R1,IMM(3));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (IF (NULL? LS) (SUCC 1) (IF (NOT1 (PAIR? LS)) (IF (NUMBER? LS) (SUCC LS) (FAIL (QUOTE NOT-A-NUMBER!))) (MUL-LIST$ (CAR LS) (LAMBDA (MUL-CAR) (MUL-LIST$ (CDR LS) (LAMBDA (MUL-CDR) (SUCC (* MUL-CAR MUL-CDR))) FAIL)) FAIL))) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(88));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_41);
		MOV(R0,IMM(153));

		/* push on stack the codegen of the parameter: 1 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(3));
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
        
	L_Override_Previous_Frame_Loop_42:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_42);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_42);
		
	L_Override_Previous_Frame_Loop_Exit_42:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		JUMP(L_END_IF_41);
		L_DIF_41:
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(347));
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
        
		/* push on stack the codegen of the parameter: (PAIR? LS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(316));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_43);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(364));
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
        		CMP(R0, BOOL_FALSE);
		JUMP_EQ(L_DIF_44);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(3));
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
        
	L_Override_Previous_Frame_Loop_45:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_45);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_45);
		
	L_Override_Previous_Frame_Loop_Exit_45:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		JUMP(L_END_IF_44);
		L_DIF_44:
		MOV(R0,IMM(384));

		/* push on stack the codegen of the parameter: (QUOTE NOT-A-NUMBER!) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(4));
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
        
	L_Override_Previous_Frame_Loop_46:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_46);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_46);
		
	L_Override_Previous_Frame_Loop_Exit_46:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		L_END_IF_44:
		JUMP(L_END_IF_43);
		L_DIF_43:
		MOV(R0,FPARG(4));

		/* push on stack the codegen of the parameter: FAIL */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(1));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_48);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_48:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_48);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_48);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_48);
	L_Expansion_Of_Empty_Env_48:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_48);

	L_Shallow_Copy_OldEnv_Exit_48:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_48:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_48);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_48);

	L_Copy_Params_To_NewEnv_Exit_48:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_48:
		PUSH(LABEL(L_CLOS_CODE_48));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_48);
	L_CLOS_CODE_48:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (MUL-CAR) (MUL-LIST$ (CDR LS) (LAMBDA (MUL-CDR) (SUCC (* MUL-CAR MUL-CDR))) FAIL)) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (MUL-LIST$ (CDR LS) (LAMBDA (MUL-CDR) (SUCC (* MUL-CAR MUL-CDR))) FAIL) */
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,0));
		MOV(R0,INDD(R0,2));

		/* push on stack the codegen of the parameter: FAIL */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(2));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_50);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_50:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_50);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_50);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_50);
	L_Expansion_Of_Empty_Env_50:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_50);

	L_Shallow_Copy_OldEnv_Exit_50:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_50:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_50);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_50);

	L_Copy_Params_To_NewEnv_Exit_50:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_50:
		PUSH(LABEL(L_CLOS_CODE_50));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_50);
	L_CLOS_CODE_50:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (MUL-CDR) (SUCC (* MUL-CAR MUL-CDR))) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* (SUCC (* MUL-CAR MUL-CDR)) */
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: MUL-CDR */
		PUSH(R0);
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,0));
		MOV(R0,INDD(R0,0));

		/* push on stack the codegen of the parameter: MUL-CAR */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(2));
		MOV(R0,IMM(395));
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
        
		/* push on stack the codegen of the parameter: (* MUL-CAR MUL-CDR) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,1));
		MOV(R0,INDD(R0,1));
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
        
	L_Override_Previous_Frame_Loop_51:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_51);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_51);
		
	L_Override_Previous_Frame_Loop_Exit_51:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(1));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_50:

		/* push on stack the codegen of the parameter: (LAMBDA (MUL-CDR) (SUCC (* MUL-CAR MUL-CDR))) */
		PUSH(R0);
		MOV(R0,FPARG(0));
		MOV(R0,INDD(R0,0));
		MOV(R0,INDD(R0,0));

		/* push on stack the codegen of the parameter: LS */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(1));
		MOV(R0,IMM(101));
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
        
		/* push on stack the codegen of the parameter: (CDR LS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(332));
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
        
	L_Override_Previous_Frame_Loop_49:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_49);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_49);
		
	L_Override_Previous_Frame_Loop_Exit_49:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(3));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_48:

		/* push on stack the codegen of the parameter: (LAMBDA (MUL-CAR) (MUL-LIST$ (CDR LS) (LAMBDA (MUL-CDR) (SUCC (* MUL-CAR MUL-CDR))) FAIL)) */
		PUSH(R0);
		MOV(R0,FPARG(2));

		/* push on stack the codegen of the parameter: LS */
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
        
		/* push on stack the codegen of the parameter: (CAR LS) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(332));
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
        
	L_Override_Previous_Frame_Loop_47:
		CMP(R3,R2);
		JUMP_GT(L_Override_Previous_Frame_Loop_Exit_47);

        MOV(FPARG(R4),LOCAL(R3));
        DECR(R4);
        INCR(R3);
        		JUMP(L_Override_Previous_Frame_Loop_47);
		
	L_Override_Previous_Frame_Loop_Exit_47:
MOV(R4,FP);
SUB(R4,R5);
SUB(R4,IMM(1));
ADD(R4,IMM(3));

        MOV(SP,R4);

        MOV(FP,R1);

        /* finally code jumps to closure code */
        JUMPA(INDD(R0,2));
		L_END_IF_43:
		L_END_IF_41:
		POP(FP);
		RETURN;
	L_CLOS_EXIT_40:

        /* add the expression's value from R0 to the bucket */
        MOV(INDD(R15,2), R0);
        /* return #void to user */
        MOV(R0, IMM(1));
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_52);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_52:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_52);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_52);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_52);
	L_Expansion_Of_Empty_Env_52:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_52);

	L_Shallow_Copy_OldEnv_Exit_52:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_52:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_52);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_52);

	L_Copy_Params_To_NewEnv_Exit_52:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_52:
		PUSH(LABEL(L_CLOS_CODE_52));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_52);
	L_CLOS_CODE_52:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) X) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* X */
		MOV(R0,FPARG(2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_52:

		/* push on stack the codegen of the parameter: (LAMBDA (X) X) */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_53);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_53:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_53);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_53);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_53);
	L_Expansion_Of_Empty_Env_53:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_53);

	L_Shallow_Copy_OldEnv_Exit_53:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_53:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_53);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_53);

	L_Copy_Params_To_NewEnv_Exit_53:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_53:
		PUSH(LABEL(L_CLOS_CODE_53));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_53);
	L_CLOS_CODE_53:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) X) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* X */
		MOV(R0,FPARG(2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_53:

		/* push on stack the codegen of the parameter: (LAMBDA (X) X) */
		PUSH(R0);
		MOV(R0,IMM(397));

		/* push on stack the codegen of the parameter: 10 */
		PUSH(R0);
		MOV(R0,IMM(125));

		/* push on stack the codegen of the parameter: 7 */
		PUSH(R0);
		MOV(R0,IMM(130));

		/* push on stack the codegen of the parameter: 6 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(173));
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
        
		/* push on stack the codegen of the parameter: (LIST 6 7 10) */
		PUSH(R0);
		MOV(R0,IMM(399));

		/* push on stack the codegen of the parameter: 5 */
		PUSH(R0);
		MOV(R0,IMM(135));

		/* push on stack the codegen of the parameter: 4 */
		PUSH(R0);
		MOV(R0,IMM(143));

		/* push on stack the codegen of the parameter: 3 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(173));
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
        
		/* push on stack the codegen of the parameter: (LIST 3 4 5) */
		PUSH(R0);
		MOV(R0,IMM(148));

		/* push on stack the codegen of the parameter: 2 */
		PUSH(R0);
		MOV(R0,IMM(153));

		/* push on stack the codegen of the parameter: 1 */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(4));
		MOV(R0,IMM(173));
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
        
		/* push on stack the codegen of the parameter: (LIST 1 2 (LIST 3 4 5) (LIST 6 7 10)) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(332));
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
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_54);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_54:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_54);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_54);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_54);
	L_Expansion_Of_Empty_Env_54:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_54);

	L_Shallow_Copy_OldEnv_Exit_54:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_54:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_54);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_54);

	L_Copy_Params_To_NewEnv_Exit_54:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_54:
		PUSH(LABEL(L_CLOS_CODE_54));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_54);
	L_CLOS_CODE_54:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) X) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* X */
		MOV(R0,FPARG(2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_54:

		/* push on stack the codegen of the parameter: (LAMBDA (X) X) */
		PUSH(R0);
		/* checking the lambda depth*/
		MOV(R1,IMM(0));
		CMP(R1,IMM(0));
		JUMP_EQ(L_After_Env_Expansion_55);

        MOV(R3,R1);             /* remember envSize */
        ADD(R1,IMM(1));         /* increment env size by 1 */
        PUSH(R1);
        CALL(MALLOC);           /* malloc space for new env */
        DROP(1);
        MOV(R1,R0);              /* move new env to R1 */
        MOV(R2,FPARG(0));        /* get old env from stack */
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(1));          /* j = 1 */

	L_Shallow_Copy_OldEnv_55:
		CMP(R4,R3);
		JUMP_EQ(L_Shallow_Copy_OldEnv_Exit_55);		CMP(R2,IMM(0));
		JUMP_EQ(L_Expansion_Of_Empty_Env_55);

        MOV(INDD(R1,R5),INDD(R2,R4));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_55);
	L_Expansion_Of_Empty_Env_55:
        MOV(INDD(R1,R5),IMM(0));
        INCR(R4);
        INCR(R5);
        JUMP(L_Shallow_Copy_OldEnv_55);

	L_Shallow_Copy_OldEnv_Exit_55:
        MOV(R3,FPARG(1));       /* get the number of parameters from stack */
        PUSH(R3);
        CALL(MALLOC);           /* malloc size for parameters to add new env */
        DROP(1);
        MOV(R4,IMM(0));          /* i = 0 */
        MOV(R5,IMM(2));          /* j = 2 */
        
	L_Copy_Params_To_NewEnv_55:
		CMP(R4,R3);
		JUMP_EQ(L_Copy_Params_To_NewEnv_Exit_55);
        MOV(INDD(R0,R4),FPARG(R5));
        INCR(R4);
        INCR(R5);
        JUMP(L_Copy_Params_To_NewEnv_55);

	L_Copy_Params_To_NewEnv_Exit_55:
		/* move the params to new env before calling make_sob_closure */
		MOV(IND(R1),R0);

	L_After_Env_Expansion_55:
		PUSH(LABEL(L_CLOS_CODE_55));
		PUSH(R1);
		CALL(MAKE_SOB_CLOSURE);
		DROP(2);
		JUMP(L_CLOS_EXIT_55);
	L_CLOS_CODE_55:
		PUSH(FP);
		MOV(FP,SP);
		/* (LAMBDA (X) X) */
		MOV(R1,IMM(1));
		CMP(R1,FPARG(1));
		JUMP_NE(L_error_not_enough_params_given);
		/* CodeGen Body Of Lambda */
		/* X */
		MOV(R0,FPARG(2));
		POP(FP);
		RETURN;
	L_CLOS_EXIT_55:

		/* push on stack the codegen of the parameter: (LAMBDA (X) X) */
		PUSH(R0);
		MOV(R0,IMM(454));

		/* push on stack the codegen of the parameter: (QUOTE (1 2 (3 4 5) (6 7 (QUOTE A)))) */
		PUSH(R0);

		/* push to stack the number of parameters */
		PUSH(IMM(3));
		MOV(R0,IMM(332));
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
        
        PUSH(R0);
        CALL(L_CHECK_MAGIC);
        POP(R0);

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
