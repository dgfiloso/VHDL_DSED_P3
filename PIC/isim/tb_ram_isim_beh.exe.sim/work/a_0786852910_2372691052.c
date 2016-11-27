/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "E:/David/Teleco/Curso_2016-2017/DSED/Practica 3/PIC/tb_ram.vhd";
extern char *WORK_P_1256623257;



static void work_a_0786852910_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(96, ng0);
    t2 = (t0 + 4224);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(97, ng0);
    t2 = (t0 + 2608U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3400);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(98, ng0);
    t2 = (t0 + 4224);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(99, ng0);
    t2 = (t0 + 2608U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 3400);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_0786852910_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int64 t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    int64 t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    int64 t33;
    char *t34;
    char *t35;
    char *t36;
    int64 t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    int64 t44;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    int64 t51;
    char *t52;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;
    char *t58;

LAB0:    t1 = (t0 + 3840U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(106, ng0);
    t2 = (t0 + 4288);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_delta(t2, 0U, 1, 0LL);
    t7 = (125 * 1000LL);
    t8 = (t0 + 4288);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_subsequent_trans_delta(t8, 0U, 1, t7);
    xsi_set_current_line(109, ng0);
    t2 = (t0 + 4352);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)4;
    xsi_driver_first_trans_delta(t2, 0U, 1, 0LL);
    t7 = (75 * 1000LL);
    t8 = (t0 + 4352);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_subsequent_trans_delta(t8, 0U, 1, t7);
    t13 = (300 * 1000LL);
    t14 = (t0 + 4352);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)4;
    xsi_driver_subsequent_trans_delta(t14, 0U, 1, t13);
    xsi_set_current_line(112, ng0);
    t2 = (t0 + 4416);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)4;
    xsi_driver_first_trans_delta(t2, 0U, 1, 0LL);
    t7 = (325 * 1000LL);
    t8 = (t0 + 4416);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_subsequent_trans_delta(t8, 0U, 1, t7);
    t13 = (600 * 1000LL);
    t14 = (t0 + 4416);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)4;
    xsi_driver_subsequent_trans_delta(t14, 0U, 1, t13);
    xsi_set_current_line(115, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t3 = t2;
    memset(t3, (unsigned char)4, 8U);
    t4 = (t0 + 4480);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 8U);
    xsi_driver_first_trans_delta(t4, 0U, 8U, 0LL);
    t7 = (85 * 1000LL);
    t10 = (t0 + 7176);
    t12 = (t0 + 4480);
    t14 = (t12 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t10, 8U);
    xsi_driver_subsequent_trans_delta(t12, 0U, 8U, t7);
    t13 = (135 * 1000LL);
    t18 = (t0 + 7184);
    t20 = (t0 + 4480);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t18, 8U);
    xsi_driver_subsequent_trans_delta(t20, 0U, 8U, t13);
    t25 = (185 * 1000LL);
    t26 = (t0 + 7192);
    t28 = (t0 + 4480);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    memcpy(t32, t26, 8U);
    xsi_driver_subsequent_trans_delta(t28, 0U, 8U, t25);
    xsi_set_current_line(116, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t3 = t2;
    memset(t3, (unsigned char)4, 8U);
    t4 = (t0 + 4544);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 8U);
    xsi_driver_first_trans_delta(t4, 0U, 8U, 0LL);
    t7 = (85 * 1000LL);
    t10 = ((WORK_P_1256623257) + 1168U);
    t11 = *((char **)t10);
    t10 = (t0 + 4544);
    t12 = (t10 + 56U);
    t14 = *((char **)t12);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t11, 8U);
    xsi_driver_subsequent_trans_delta(t10, 0U, 8U, t7);
    t13 = (135 * 1000LL);
    t17 = ((WORK_P_1256623257) + 1288U);
    t18 = *((char **)t17);
    t17 = (t0 + 4544);
    t19 = (t17 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t18, 8U);
    xsi_driver_subsequent_trans_delta(t17, 0U, 8U, t13);
    t25 = (185 * 1000LL);
    t23 = ((WORK_P_1256623257) + 1408U);
    t24 = *((char **)t23);
    t23 = (t0 + 4544);
    t26 = (t23 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t24, 8U);
    xsi_driver_subsequent_trans_delta(t23, 0U, 8U, t25);
    t33 = (330 * 1000LL);
    t30 = ((WORK_P_1256623257) + 1648U);
    t31 = *((char **)t30);
    t30 = (t0 + 4544);
    t32 = (t30 + 56U);
    t34 = *((char **)t32);
    t35 = (t34 + 56U);
    t36 = *((char **)t35);
    memcpy(t36, t31, 8U);
    xsi_driver_subsequent_trans_delta(t30, 0U, 8U, t33);
    t37 = (380 * 1000LL);
    t38 = ((WORK_P_1256623257) + 1768U);
    t39 = *((char **)t38);
    t38 = (t0 + 4544);
    t40 = (t38 + 56U);
    t41 = *((char **)t40);
    t42 = (t41 + 56U);
    t43 = *((char **)t42);
    memcpy(t43, t39, 8U);
    xsi_driver_subsequent_trans_delta(t38, 0U, 8U, t37);
    t44 = (430 * 1000LL);
    t45 = ((WORK_P_1256623257) + 2248U);
    t46 = *((char **)t45);
    t45 = (t0 + 4544);
    t47 = (t45 + 56U);
    t48 = *((char **)t47);
    t49 = (t48 + 56U);
    t50 = *((char **)t49);
    memcpy(t50, t46, 8U);
    xsi_driver_subsequent_trans_delta(t45, 0U, 8U, t44);
    t51 = (500 * 1000LL);
    t52 = xsi_get_transient_memory(8U);
    memset(t52, 0, 8U);
    t53 = t52;
    memset(t53, (unsigned char)4, 8U);
    t54 = (t0 + 4544);
    t55 = (t54 + 56U);
    t56 = *((char **)t55);
    t57 = (t56 + 56U);
    t58 = *((char **)t57);
    memcpy(t58, t52, 8U);
    xsi_driver_subsequent_trans_delta(t54, 0U, 8U, t51);
    xsi_set_current_line(119, ng0);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

}


extern void work_a_0786852910_2372691052_init()
{
	static char *pe[] = {(void *)work_a_0786852910_2372691052_p_0,(void *)work_a_0786852910_2372691052_p_1};
	xsi_register_didat("work_a_0786852910_2372691052", "isim/tb_ram_isim_beh.exe.sim/work/a_0786852910_2372691052.didat");
	xsi_register_executes(pe);
}
