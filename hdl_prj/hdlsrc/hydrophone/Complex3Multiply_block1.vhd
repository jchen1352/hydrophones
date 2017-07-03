-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\hydrophone\Complex3Multiply_block1.vhd
-- Created: 2017-07-03 12:54:47
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Complex3Multiply_block1
-- Source Path: hydrophone/Subsystem/FFT HDL Optimized/RADIX22FFT_SDF1_7/Complex3Multiply
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Complex3Multiply_block1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        din_re                            :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En14
        din_im                            :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En14
        din_7_vld_dly                     :   IN    std_logic;
        twdl_7_1_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_7_1_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        softReset                         :   IN    std_logic;
        dinXTwdl_re                       :   OUT   std_logic_vector(22 DOWNTO 0);  -- sfix23_En14
        dinXTwdl_im                       :   OUT   std_logic_vector(22 DOWNTO 0);  -- sfix23_En14
        dinXTwdl_7_1_vld                  :   OUT   std_logic
        );
END Complex3Multiply_block1;


ARCHITECTURE rtl OF Complex3Multiply_block1 IS

  -- Signals
  SIGNAL din_re_signed                    : signed(22 DOWNTO 0);  -- sfix23_En14
  SIGNAL din_re_reg                       : signed(22 DOWNTO 0);  -- sfix23_En14
  SIGNAL din_im_signed                    : signed(22 DOWNTO 0);  -- sfix23_En14
  SIGNAL din_im_reg                       : signed(22 DOWNTO 0);  -- sfix23_En14
  SIGNAL adder_add_cast                   : signed(23 DOWNTO 0);  -- sfix24_En14
  SIGNAL adder_add_cast_1                 : signed(23 DOWNTO 0);  -- sfix24_En14
  SIGNAL din_sum                          : signed(23 DOWNTO 0);  -- sfix24_En14
  SIGNAL twdl_7_1_re_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_re_reg                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_7_1_im_signed               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_im_reg                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL adder_add_cast_2                 : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL adder_add_cast_3                 : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL twdl_sum                         : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Complex3Multiply_din1_re_pipe1   : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL Complex3Multiply_din1_im_pipe1   : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL Complex3Multiply_din1_sum_pipe1  : signed(23 DOWNTO 0);  -- sfix24
  SIGNAL Complex3Multiply_prodOfRe_pipe1  : signed(38 DOWNTO 0);  -- sfix39
  SIGNAL Complex3Multiply_ProdOfIm_pipe1  : signed(38 DOWNTO 0);  -- sfix39
  SIGNAL Complex3Multiply_prodOfSum_pipe1 : signed(40 DOWNTO 0);  -- sfix41
  SIGNAL Complex3Multiply_twiddle_re_pipe1 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Complex3Multiply_twiddle_im_pipe1 : signed(15 DOWNTO 0);  -- sfix16
  SIGNAL Complex3Multiply_twiddle_sum_pipe1 : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL prodOfRe                         : signed(38 DOWNTO 0);  -- sfix39_En28
  SIGNAL prodOfIm                         : signed(38 DOWNTO 0);  -- sfix39_En28
  SIGNAL prodOfSum                        : signed(40 DOWNTO 0);  -- sfix41_En28
  SIGNAL din_vld_dly1                     : std_logic;
  SIGNAL din_vld_dly2                     : std_logic;
  SIGNAL din_vld_dly3                     : std_logic;
  SIGNAL prod_vld                         : std_logic;
  SIGNAL Complex3Add_tmpResult_reg        : signed(40 DOWNTO 0);  -- sfix41
  SIGNAL Complex3Add_multRes_re_reg1      : signed(39 DOWNTO 0);  -- sfix40
  SIGNAL Complex3Add_multRes_re_reg2      : signed(39 DOWNTO 0);  -- sfix40
  SIGNAL Complex3Add_multRes_im_reg       : signed(41 DOWNTO 0);  -- sfix42
  SIGNAL Complex3Add_prod_vld_reg1        : std_logic;
  SIGNAL Complex3Add_prodOfSum_reg        : signed(40 DOWNTO 0);  -- sfix41
  SIGNAL Complex3Add_tmpResult_reg_next   : signed(40 DOWNTO 0);  -- sfix41_En28
  SIGNAL Complex3Add_multRes_re_reg1_next : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL Complex3Add_multRes_re_reg2_next : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL Complex3Add_multRes_im_reg_next  : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL Complex3Add_sub_cast             : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL Complex3Add_sub_cast_1           : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL Complex3Add_sub_cast_2           : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL Complex3Add_sub_cast_3           : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL Complex3Add_add_cast             : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL Complex3Add_add_cast_1           : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL Complex3Add_add_temp             : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL multResFP_re                     : signed(39 DOWNTO 0);  -- sfix40_En28
  SIGNAL multResFP_im                     : signed(41 DOWNTO 0);  -- sfix42_En28
  SIGNAL dinXTwdl_re_tmp                  : signed(22 DOWNTO 0);  -- sfix23_En14
  SIGNAL dinXTwdl_im_tmp                  : signed(22 DOWNTO 0);  -- sfix23_En14

BEGIN
  din_re_signed <= signed(din_re);

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_re_reg <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF softReset = '1' THEN
          din_re_reg <= to_signed(16#000000#, 23);
        ELSE 
          din_re_reg <= din_re_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  din_im_signed <= signed(din_im);

  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_im_reg <= to_signed(16#000000#, 23);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF softReset = '1' THEN
          din_im_reg <= to_signed(16#000000#, 23);
        ELSE 
          din_im_reg <= din_im_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_1_process;


  adder_add_cast <= resize(din_re_reg, 24);
  adder_add_cast_1 <= resize(din_im_reg, 24);
  din_sum <= adder_add_cast + adder_add_cast_1;

  twdl_7_1_re_signed <= signed(twdl_7_1_re);

  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl_re_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF softReset = '1' THEN
          twdl_re_reg <= to_signed(16#0000#, 16);
        ELSE 
          twdl_re_reg <= twdl_7_1_re_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_2_process;


  twdl_7_1_im_signed <= signed(twdl_7_1_im);

  intdelay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl_im_reg <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        IF softReset = '1' THEN
          twdl_im_reg <= to_signed(16#0000#, 16);
        ELSE 
          twdl_im_reg <= twdl_7_1_im_signed;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_3_process;


  adder_add_cast_2 <= resize(twdl_re_reg, 17);
  adder_add_cast_3 <= resize(twdl_im_reg, 17);
  twdl_sum <= adder_add_cast_2 + adder_add_cast_3;

  -- Complex3Multiply
  Complex3Multiply_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        prodOfRe <= Complex3Multiply_prodOfRe_pipe1;
        prodOfIm <= Complex3Multiply_ProdOfIm_pipe1;
        prodOfSum <= Complex3Multiply_prodOfSum_pipe1;
        Complex3Multiply_twiddle_re_pipe1 <= twdl_re_reg;
        Complex3Multiply_twiddle_im_pipe1 <= twdl_im_reg;
        Complex3Multiply_twiddle_sum_pipe1 <= twdl_sum;
        Complex3Multiply_din1_re_pipe1 <= din_re_reg;
        Complex3Multiply_din1_im_pipe1 <= din_im_reg;
        Complex3Multiply_din1_sum_pipe1 <= din_sum;
        Complex3Multiply_prodOfRe_pipe1 <= Complex3Multiply_din1_re_pipe1 * Complex3Multiply_twiddle_re_pipe1;
        Complex3Multiply_ProdOfIm_pipe1 <= Complex3Multiply_din1_im_pipe1 * Complex3Multiply_twiddle_im_pipe1;
        Complex3Multiply_prodOfSum_pipe1 <= Complex3Multiply_din1_sum_pipe1 * Complex3Multiply_twiddle_sum_pipe1;
      END IF;
    END IF;
  END PROCESS Complex3Multiply_process;


  intdelay_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_vld_dly1 <= din_7_vld_dly;
      END IF;
    END IF;
  END PROCESS intdelay_4_process;


  intdelay_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly2 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_vld_dly2 <= din_vld_dly1;
      END IF;
    END IF;
  END PROCESS intdelay_5_process;


  intdelay_6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      din_vld_dly3 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        din_vld_dly3 <= din_vld_dly2;
      END IF;
    END IF;
  END PROCESS intdelay_6_process;


  intdelay_7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      prod_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        prod_vld <= din_vld_dly3;
      END IF;
    END IF;
  END PROCESS intdelay_7_process;


  -- Complex3Add
  Complex3Add_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Complex3Add_prodOfSum_reg <= to_signed(0, 41);
      Complex3Add_tmpResult_reg <= to_signed(0, 41);
      Complex3Add_multRes_re_reg1 <= to_signed(0, 40);
      Complex3Add_multRes_re_reg2 <= to_signed(0, 40);
      Complex3Add_multRes_im_reg <= to_signed(0, 42);
      Complex3Add_prod_vld_reg1 <= '0';
      dinXTwdl_7_1_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Complex3Add_tmpResult_reg <= Complex3Add_tmpResult_reg_next;
        Complex3Add_multRes_re_reg1 <= Complex3Add_multRes_re_reg1_next;
        Complex3Add_multRes_re_reg2 <= Complex3Add_multRes_re_reg2_next;
        Complex3Add_multRes_im_reg <= Complex3Add_multRes_im_reg_next;
        Complex3Add_prodOfSum_reg <= prodOfSum;
        dinXTwdl_7_1_vld <= Complex3Add_prod_vld_reg1;
        Complex3Add_prod_vld_reg1 <= prod_vld;
      END IF;
    END IF;
  END PROCESS Complex3Add_process;

  Complex3Add_multRes_re_reg2_next <= Complex3Add_multRes_re_reg1;
  Complex3Add_sub_cast <= resize(prodOfRe, 40);
  Complex3Add_sub_cast_1 <= resize(prodOfIm, 40);
  Complex3Add_multRes_re_reg1_next <= Complex3Add_sub_cast - Complex3Add_sub_cast_1;
  Complex3Add_sub_cast_2 <= resize(Complex3Add_prodOfSum_reg, 42);
  Complex3Add_sub_cast_3 <= resize(Complex3Add_tmpResult_reg, 42);
  Complex3Add_multRes_im_reg_next <= Complex3Add_sub_cast_2 - Complex3Add_sub_cast_3;
  Complex3Add_add_cast <= resize(prodOfRe, 40);
  Complex3Add_add_cast_1 <= resize(prodOfIm, 40);
  Complex3Add_add_temp <= Complex3Add_add_cast + Complex3Add_add_cast_1;
  Complex3Add_tmpResult_reg_next <= resize(Complex3Add_add_temp, 41);
  multResFP_re <= Complex3Add_multRes_re_reg2;
  multResFP_im <= Complex3Add_multRes_im_reg;

  dinXTwdl_re_tmp <= multResFP_re(36 DOWNTO 14);

  dinXTwdl_re <= std_logic_vector(dinXTwdl_re_tmp);

  dinXTwdl_im_tmp <= multResFP_im(36 DOWNTO 14);

  dinXTwdl_im <= std_logic_vector(dinXTwdl_im_tmp);

END rtl;

