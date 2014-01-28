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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    unisims_ver_m_00000000003266096158_2593380106_init();
    work_m_00000000000169562412_0924379199_init();
    work_m_00000000002998671861_2068162937_init();
    work_m_00000000002382712537_2181938481_init();
    work_m_00000000000253550959_0408539363_init();
    work_m_00000000002645973598_3115626103_init();
    work_m_00000000004254936665_2171587388_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000004254936665_2171587388");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
