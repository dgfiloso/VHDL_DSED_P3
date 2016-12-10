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
extern char *IEEE_P_2592010699;



void rs232_test_p_2014940703_sub_4226975077_3878680290(char *t0, char *t1, char *t2, unsigned int t3, unsigned int t4, char *t5, char *t6)
{
    char t8[24];
    char t9[16];
    char *t10;
    char *t11;
    int t12;
    unsigned int t13;
    unsigned char t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    int64 t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    int t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;

LAB0:    t10 = (t9 + 0U);
    t11 = (t10 + 0U);
    *((int *)t11) = 7;
    t11 = (t10 + 4U);
    *((int *)t11) = 0;
    t11 = (t10 + 8U);
    *((int *)t11) = -1;
    t12 = (0 - 7);
    t13 = (t12 * -1);
    t13 = (t13 + 1);
    t11 = (t10 + 12U);
    *((unsigned int *)t11) = t13;
    t11 = (t8 + 4U);
    t14 = (t6 != 0);
    if (t14 == 1)
        goto LAB3;

LAB2:    t15 = (t8 + 12U);
    *((char **)t15) = t9;
    t13 = (0 + t3);
    t16 = (t5 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_delta(t5, t13, 1, 0LL);
    t20 = (8680.6000000000004 * 1000LL);
    xsi_process_wait(t1, t20);

LAB7:    t10 = (t1 + 88U);
    t16 = *((char **)t10);
    t17 = (t16 + 2480U);
    *((unsigned int *)t17) = 1U;
    t18 = (t1 + 88U);
    t19 = *((char **)t18);
    t21 = (t19 + 0U);
    getcontext(t21);
    t22 = (t1 + 88U);
    t23 = *((char **)t22);
    t24 = (t23 + 2480U);
    t13 = *((unsigned int *)t24);
    if (t13 == 1)
        goto LAB8;

LAB9:    t25 = (t1 + 88U);
    t26 = *((char **)t25);
    t27 = (t26 + 2480U);
    *((unsigned int *)t27) = 3U;

LAB5:
LAB6:
LAB4:    t12 = 0;
    t28 = 7;

LAB10:    if (t12 <= t28)
        goto LAB11;

LAB13:    t13 = (0 + t3);
    t10 = (t5 + 56U);
    t16 = *((char **)t10);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)3;
    xsi_driver_first_trans_delta(t5, t13, 1, 0LL);
    t20 = (8680.6000000000004 * 1000LL);
    xsi_process_wait(t1, t20);

LAB24:    t10 = (t1 + 88U);
    t16 = *((char **)t10);
    t17 = (t16 + 2480U);
    *((unsigned int *)t17) = 1U;
    t18 = (t1 + 88U);
    t19 = *((char **)t18);
    t21 = (t19 + 0U);
    getcontext(t21);
    t22 = (t1 + 88U);
    t23 = *((char **)t22);
    t24 = (t23 + 2480U);
    t13 = *((unsigned int *)t24);
    if (t13 == 1)
        goto LAB25;

LAB26:    t25 = (t1 + 88U);
    t26 = *((char **)t25);
    t27 = (t26 + 2480U);
    *((unsigned int *)t27) = 3U;

LAB22:
LAB23:
LAB21:    t13 = (0 + t3);
    t10 = (t5 + 56U);
    t16 = *((char **)t10);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    *((unsigned char *)t18) = (unsigned char)3;
    xsi_driver_first_trans_delta(t5, t13, 1, 0LL);

LAB1:    return;
LAB3:    *((char **)t11) = t6;
    goto LAB2;

LAB8:    xsi_saveStackAndSuspend(t1);
    goto LAB9;

LAB11:    t10 = (t9 + 0U);
    t29 = *((int *)t10);
    t16 = (t9 + 8U);
    t30 = *((int *)t16);
    t31 = (t12 - t29);
    t13 = (t31 * t30);
    t17 = (t9 + 4U);
    t32 = *((int *)t17);
    xsi_vhdl_check_range_of_index(t29, t32, t30, t12);
    t33 = (1U * t13);
    t34 = (0 + t33);
    t18 = (t6 + t34);
    t14 = *((unsigned char *)t18);
    t35 = (0 + t3);
    t19 = (t5 + 56U);
    t21 = *((char **)t19);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    *((unsigned char *)t23) = t14;
    xsi_driver_first_trans_delta(t5, t35, 1, 0LL);
    t20 = (8680.6000000000004 * 1000LL);
    xsi_process_wait(t1, t20);

LAB17:    t10 = (t1 + 88U);
    t16 = *((char **)t10);
    t17 = (t16 + 2480U);
    *((unsigned int *)t17) = 1U;
    t18 = (t1 + 88U);
    t19 = *((char **)t18);
    t21 = (t19 + 0U);
    getcontext(t21);
    t22 = (t1 + 88U);
    t23 = *((char **)t22);
    t24 = (t23 + 2480U);
    t13 = *((unsigned int *)t24);
    if (t13 == 1)
        goto LAB18;

LAB19:    t25 = (t1 + 88U);
    t26 = *((char **)t25);
    t27 = (t26 + 2480U);
    *((unsigned int *)t27) = 3U;

LAB15:
LAB16:
LAB14:
LAB12:    if (t12 == t28)
        goto LAB13;

LAB20:    t29 = (t12 + 1);
    t12 = t29;
    goto LAB10;

LAB18:    xsi_saveStackAndSuspend(t1);
    goto LAB19;

LAB25:    xsi_saveStackAndSuspend(t1);
    goto LAB26;

}

void rs232_test_p_2014940703_sub_1293599077_3878680290(char *t0, char *t1, char *t2, unsigned int t3, unsigned int t4, char *t5, unsigned int t6, unsigned int t7, char *t8)
{
    char t9[128];
    char t11[16];
    char t16[16];
    char t21[8];
    char *t12;
    char *t13;
    int t14;
    unsigned int t15;
    char *t17;
    int t18;
    char *t19;
    char *t20;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    unsigned char t40;
    unsigned char t41;
    int64 t42;
    int t43;
    int t44;
    int t45;
    int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;

LAB0:    t12 = (t11 + 0U);
    t13 = (t12 + 0U);
    *((int *)t13) = 7;
    t13 = (t12 + 4U);
    *((int *)t13) = 0;
    t13 = (t12 + 8U);
    *((int *)t13) = -1;
    t14 = (0 - 7);
    t15 = (t14 * -1);
    t15 = (t15 + 1);
    t13 = (t12 + 12U);
    *((unsigned int *)t13) = t15;
    t13 = (t16 + 0U);
    t17 = (t13 + 0U);
    *((int *)t17) = 7;
    t17 = (t13 + 4U);
    *((int *)t17) = 0;
    t17 = (t13 + 8U);
    *((int *)t17) = -1;
    t18 = (0 - 7);
    t15 = (t18 * -1);
    t15 = (t15 + 1);
    t17 = (t13 + 12U);
    *((unsigned int *)t17) = t15;
    t17 = (t9 + 4U);
    t19 = ((IEEE_P_2592010699) + 4024);
    t20 = (t17 + 88U);
    *((char **)t20) = t19;
    t22 = (t17 + 56U);
    *((char **)t22) = t21;
    xsi_type_set_default_value(t19, t21, t16);
    t23 = (t17 + 64U);
    *((char **)t23) = t16;
    t24 = (t17 + 80U);
    *((unsigned int *)t24) = 8U;

LAB2:    if ((unsigned char)1 != 0)
        goto LAB3;

LAB5:
LAB1:    return;
LAB3:    xsi_add_dynamic_wait(t1, t2, -1, -1);

LAB9:    t25 = (t1 + 224U);
    t25 = *((char **)t25);
    xsi_wp_set_status(t25, 1);
    t26 = (t1 + 88U);
    t27 = *((char **)t26);
    t28 = (t27 + 2480U);
    *((unsigned int *)t28) = 1U;
    t29 = (t1 + 88U);
    t30 = *((char **)t29);
    t31 = (t30 + 0U);
    getcontext(t31);
    t32 = (t1 + 88U);
    t33 = *((char **)t32);
    t34 = (t33 + 2480U);
    t15 = *((unsigned int *)t34);
    if (t15 == 1)
        goto LAB10;

LAB11:    t35 = (t1 + 88U);
    t36 = *((char **)t35);
    t37 = (t36 + 2480U);
    *((unsigned int *)t37) = 3U;

LAB7:
LAB8:    t38 = (t2 + 40U);
    t39 = *((char **)t38);
    t38 = (t39 + t4);
    t40 = *((unsigned char *)t38);
    t41 = (t40 == (unsigned char)2);
    if (t41 == 1)
        goto LAB6;
    else
        goto LAB9;

LAB4:;
LAB6:    xsi_remove_dynamic_wait(t1, t2);
    t42 = (13021 * 1000LL);
    xsi_process_wait(t1, t42);

LAB15:    t12 = (t1 + 88U);
    t13 = *((char **)t12);
    t19 = (t13 + 2480U);
    *((unsigned int *)t19) = 1U;
    t20 = (t1 + 88U);
    t22 = *((char **)t20);
    t23 = (t22 + 0U);
    getcontext(t23);
    t24 = (t1 + 88U);
    t25 = *((char **)t24);
    t26 = (t25 + 2480U);
    t15 = *((unsigned int *)t26);
    if (t15 == 1)
        goto LAB16;

LAB17:    t27 = (t1 + 88U);
    t28 = *((char **)t27);
    t29 = (t28 + 2480U);
    *((unsigned int *)t29) = 3U;

LAB13:
LAB14:
LAB12:    t14 = 0;
    t18 = 7;

LAB18:    if (t14 <= t18)
        goto LAB19;

LAB21:    t12 = (t17 + 56U);
    t13 = *((char **)t12);
    t15 = (0 + t6);
    t12 = (t8 + 56U);
    t19 = *((char **)t12);
    t20 = (t19 + 56U);
    t22 = *((char **)t20);
    t23 = (t11 + 12U);
    t47 = *((unsigned int *)t23);
    t47 = (t47 * 1U);
    memcpy(t22, t13, t47);
    t24 = (t11 + 12U);
    t48 = *((unsigned int *)t24);
    t49 = (1U * t48);
    xsi_driver_first_trans_delta(t8, t15, t49, 0LL);
    goto LAB2;

LAB10:    xsi_saveStackAndSuspend(t1);
    goto LAB11;

LAB16:    xsi_saveStackAndSuspend(t1);
    goto LAB17;

LAB19:    t12 = (t2 + 40U);
    t13 = *((char **)t12);
    t12 = (t13 + t4);
    t40 = *((unsigned char *)t12);
    t13 = (t17 + 56U);
    t19 = *((char **)t13);
    t13 = (t16 + 0U);
    t43 = *((int *)t13);
    t20 = (t16 + 8U);
    t44 = *((int *)t20);
    t45 = (t14 - t43);
    t15 = (t45 * t44);
    t22 = (t16 + 4U);
    t46 = *((int *)t22);
    xsi_vhdl_check_range_of_index(t43, t46, t44, t14);
    t47 = (1U * t15);
    t48 = (0 + t47);
    t23 = (t19 + t48);
    *((unsigned char *)t23) = t40;
    t42 = (8680.6000000000004 * 1000LL);
    xsi_process_wait(t1, t42);

LAB25:    t12 = (t1 + 88U);
    t13 = *((char **)t12);
    t19 = (t13 + 2480U);
    *((unsigned int *)t19) = 1U;
    t20 = (t1 + 88U);
    t22 = *((char **)t20);
    t23 = (t22 + 0U);
    getcontext(t23);
    t24 = (t1 + 88U);
    t25 = *((char **)t24);
    t26 = (t25 + 2480U);
    t15 = *((unsigned int *)t26);
    if (t15 == 1)
        goto LAB26;

LAB27:    t27 = (t1 + 88U);
    t28 = *((char **)t27);
    t29 = (t28 + 2480U);
    *((unsigned int *)t29) = 3U;

LAB23:
LAB24:
LAB22:
LAB20:    if (t14 == t18)
        goto LAB21;

LAB28:    t43 = (t14 + 1);
    t14 = t43;
    goto LAB18;

LAB26:    xsi_saveStackAndSuspend(t1);
    goto LAB27;

}


extern void rs232_test_p_2014940703_init()
{
	static char *se[] = {(void *)rs232_test_p_2014940703_sub_4226975077_3878680290,(void *)rs232_test_p_2014940703_sub_1293599077_3878680290};
	xsi_register_didat("rs232_test_p_2014940703", "isim/tb_Comunicador_isim_beh.exe.sim/rs232_test/p_2014940703.didat");
	xsi_register_subprogram_executes(se);
}
