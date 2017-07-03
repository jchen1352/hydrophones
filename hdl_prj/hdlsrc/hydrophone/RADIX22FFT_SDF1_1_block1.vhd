-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\hydrophone\RADIX22FFT_SDF1_1_block1.vhd
-- Created: 2017-07-03 12:54:48
-- 
-- Generated by MATLAB 9.2 and HDL Coder 3.10
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: RADIX22FFT_SDF1_1_block1
-- Source Path: hydrophone/Subsystem/FFT HDL Optimized2/RADIX22FFT_SDF1_1
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RADIX22FFT_SDF1_1_block1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        din_1_1_re_dly                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        din_1_1_im_dly                    :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        din_1_vld_dly                     :   IN    std_logic;
        rd_1_Addr                         :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
        rd_1_Enb                          :   IN    std_logic;
        twdl_1_1_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_1_1_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_1_1_vld                      :   IN    std_logic;
        proc_1_enb                        :   IN    std_logic;
        softReset                         :   IN    std_logic;
        dout_1_1_re                       :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        dout_1_1_im                       :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
        dout_1_1_vld                      :   OUT   std_logic;
        dinXTwdl_1_1_vld                  :   OUT   std_logic
        );
END RADIX22FFT_SDF1_1_block1;


ARCHITECTURE rtl OF RADIX22FFT_SDF1_1_block1 IS

  -- Component Declarations
  COMPONENT SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  COMPONENT SDFCommutator1_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          din_1_vld_dly                   :   IN    std_logic;
          xf_re                           :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          xf_im                           :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          xf_vld                          :   IN    std_logic;
          dinXTwdlf_re                    :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dinXTwdlf_im                    :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dinxTwdlf_vld                   :   IN    std_logic;
          btf1_re                         :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          btf1_im                         :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          btf2_re                         :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          btf2_im                         :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          btf_vld                         :   IN    std_logic;
          softReset                       :   IN    std_logic;
          wrData_re                       :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          wrData_im                       :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          wrAddr                          :   OUT   std_logic_vector(8 DOWNTO 0);  -- ufix9
          wrEnb                           :   OUT   std_logic;
          dout_1_1_re                     :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dout_1_1_im                     :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dout_1_1_vld                    :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : SimpleDualPortRAM_generic
    USE ENTITY work.SimpleDualPortRAM_generic(rtl);

  FOR ALL : SDFCommutator1_block1
    USE ENTITY work.SDFCommutator1_block1(rtl);

  -- Signals
  SIGNAL din_1_1_re_dly_signed            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL din_re                           : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL dinXTwdl_re                      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL din_1_1_im_dly_signed            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL din_im                           : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL dinXTwdl_im                      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL dinXTwdl_1_1_vld_1               : std_logic;
  SIGNAL x_im                             : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL x_vld                            : std_logic;
  SIGNAL btf2_im                          : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL btf2_re                          : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL btf1_im                          : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL btf1_re                          : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL dinXTwdlf_im                     : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL dinXTwdlf_re                     : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL xf_im                            : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL wrData_re                        : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL wrAddr                           : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL wrEnb                            : std_logic;
  SIGNAL x_re                             : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL x_re_signed                      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Radix22ButterflyG1_btf1_re_reg   : signed(17 DOWNTO 0);  -- sfix18
  SIGNAL Radix22ButterflyG1_btf1_im_reg   : signed(17 DOWNTO 0);  -- sfix18
  SIGNAL Radix22ButterflyG1_btf2_re_reg   : signed(17 DOWNTO 0);  -- sfix18
  SIGNAL Radix22ButterflyG1_btf2_im_reg   : signed(17 DOWNTO 0);  -- sfix18
  SIGNAL Radix22ButterflyG1_x_re_dly1     : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_x_im_dly1     : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_x_vld_dly1    : std_logic;
  SIGNAL Radix22ButterflyG1_dinXtwdl_re_dly1 : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_dinXtwdl_im_dly1 : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_dinXtwdl_re_dly2 : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_dinXtwdl_im_dly2 : signed(16 DOWNTO 0);  -- sfix17
  SIGNAL Radix22ButterflyG1_dinXtwdl_vld_dly1 : std_logic;
  SIGNAL Radix22ButterflyG1_dinXtwdl_vld_dly2 : std_logic;
  SIGNAL Radix22ButterflyG1_btf1_re_reg_next : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_btf1_im_reg_next : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_btf2_re_reg_next : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_btf2_im_reg_next : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_add_cast      : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_add_cast_1    : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_sub_cast      : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_sub_cast_1    : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_add_cast_2    : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_add_cast_3    : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_sub_cast_2    : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL Radix22ButterflyG1_sub_cast_3    : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL xf_re                            : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL xf_vld                           : std_logic;
  SIGNAL dinxTwdlf_vld                    : std_logic;
  SIGNAL btf_vld                          : std_logic;
  SIGNAL wrData_im                        : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL dout_1_1_re_tmp                  : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL dout_1_1_im_tmp                  : std_logic_vector(16 DOWNTO 0);  -- ufix17

BEGIN
  u_dataMEM_re_0_1 : SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 9,
                 DataWidth => 17
                 )
    PORT MAP( clk => clk,
              enb => enb,
              wr_din => wrData_re,
              wr_addr => wrAddr,
              wr_en => wrEnb,
              rd_addr => rd_1_Addr,
              rd_dout => x_re
              );

  u_SDFCOMMUTATOR_1 : SDFCommutator1_block1
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              din_1_vld_dly => din_1_vld_dly,
              xf_re => std_logic_vector(xf_re),  -- sfix17_En14
              xf_im => std_logic_vector(xf_im),  -- sfix17_En14
              xf_vld => xf_vld,
              dinXTwdlf_re => std_logic_vector(dinXTwdlf_re),  -- sfix17_En14
              dinXTwdlf_im => std_logic_vector(dinXTwdlf_im),  -- sfix17_En14
              dinxTwdlf_vld => dinxTwdlf_vld,
              btf1_re => std_logic_vector(btf1_re),  -- sfix17_En14
              btf1_im => std_logic_vector(btf1_im),  -- sfix17_En14
              btf2_re => std_logic_vector(btf2_re),  -- sfix17_En14
              btf2_im => std_logic_vector(btf2_im),  -- sfix17_En14
              btf_vld => btf_vld,
              softReset => softReset,
              wrData_re => wrData_re,  -- sfix17_En14
              wrData_im => wrData_im,  -- sfix17_En14
              wrAddr => wrAddr,  -- ufix9
              wrEnb => wrEnb,
              dout_1_1_re => dout_1_1_re_tmp,  -- sfix17_En14
              dout_1_1_im => dout_1_1_im_tmp,  -- sfix17_En14
              dout_1_1_vld => dout_1_1_vld
              );

  din_1_1_re_dly_signed <= signed(din_1_1_re_dly);

  din_re <= resize(din_1_1_re_dly_signed, 17);

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dinXTwdl_re <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        dinXTwdl_re <= din_re;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  din_1_1_im_dly_signed <= signed(din_1_1_im_dly);

  din_im <= resize(din_1_1_im_dly_signed, 17);

  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dinXTwdl_im <= to_signed(16#00000#, 17);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        dinXTwdl_im <= din_im;
      END IF;
    END IF;
  END PROCESS intdelay_1_process;


  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dinXTwdl_1_1_vld_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        dinXTwdl_1_1_vld_1 <= din_1_vld_dly;
      END IF;
    END IF;
  END PROCESS intdelay_2_process;


  x_im <= to_signed(16#00000#, 17);

  intdelay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      x_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        x_vld <= rd_1_Enb;
      END IF;
    END IF;
  END PROCESS intdelay_3_process;


  x_re_signed <= signed(x_re);

  -- Radix22ButterflyG1
  Radix22ButterflyG1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Radix22ButterflyG1_btf1_re_reg <= to_signed(16#00000#, 18);
      Radix22ButterflyG1_btf1_im_reg <= to_signed(16#00000#, 18);
      Radix22ButterflyG1_btf2_re_reg <= to_signed(16#00000#, 18);
      Radix22ButterflyG1_btf2_im_reg <= to_signed(16#00000#, 18);
      Radix22ButterflyG1_x_re_dly1 <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_x_im_dly1 <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_x_vld_dly1 <= '0';
      xf_re <= to_signed(16#00000#, 17);
      xf_im <= to_signed(16#00000#, 17);
      xf_vld <= '0';
      Radix22ButterflyG1_dinXtwdl_re_dly1 <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_dinXtwdl_im_dly1 <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_dinXtwdl_re_dly2 <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_dinXtwdl_im_dly2 <= to_signed(16#00000#, 17);
      Radix22ButterflyG1_dinXtwdl_vld_dly1 <= '0';
      Radix22ButterflyG1_dinXtwdl_vld_dly2 <= '0';
      btf_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Radix22ButterflyG1_btf1_re_reg <= Radix22ButterflyG1_btf1_re_reg_next;
        Radix22ButterflyG1_btf1_im_reg <= Radix22ButterflyG1_btf1_im_reg_next;
        Radix22ButterflyG1_btf2_re_reg <= Radix22ButterflyG1_btf2_re_reg_next;
        Radix22ButterflyG1_btf2_im_reg <= Radix22ButterflyG1_btf2_im_reg_next;
        xf_re <= Radix22ButterflyG1_x_re_dly1;
        xf_im <= Radix22ButterflyG1_x_im_dly1;
        xf_vld <= Radix22ButterflyG1_x_vld_dly1;
        btf_vld <= Radix22ButterflyG1_dinXtwdl_vld_dly2;
        Radix22ButterflyG1_dinXtwdl_vld_dly2 <= Radix22ButterflyG1_dinXtwdl_vld_dly1;
        Radix22ButterflyG1_dinXtwdl_re_dly2 <= Radix22ButterflyG1_dinXtwdl_re_dly1;
        Radix22ButterflyG1_dinXtwdl_im_dly2 <= Radix22ButterflyG1_dinXtwdl_im_dly1;
        Radix22ButterflyG1_dinXtwdl_re_dly1 <= dinXTwdl_re;
        Radix22ButterflyG1_dinXtwdl_im_dly1 <= dinXTwdl_im;
        Radix22ButterflyG1_x_re_dly1 <= x_re_signed;
        Radix22ButterflyG1_x_im_dly1 <= x_im;
        Radix22ButterflyG1_x_vld_dly1 <= x_vld;
        Radix22ButterflyG1_dinXtwdl_vld_dly1 <= proc_1_enb AND dinXTwdl_1_1_vld_1;
      END IF;
    END IF;
  END PROCESS Radix22ButterflyG1_process;

  dinxTwdlf_vld <= ( NOT proc_1_enb) AND dinXTwdl_1_1_vld_1;
  Radix22ButterflyG1_add_cast <= resize(Radix22ButterflyG1_x_re_dly1, 18);
  Radix22ButterflyG1_add_cast_1 <= resize(Radix22ButterflyG1_dinXtwdl_re_dly2, 18);
  Radix22ButterflyG1_btf1_re_reg_next <= Radix22ButterflyG1_add_cast + Radix22ButterflyG1_add_cast_1;
  Radix22ButterflyG1_sub_cast <= resize(Radix22ButterflyG1_x_re_dly1, 18);
  Radix22ButterflyG1_sub_cast_1 <= resize(Radix22ButterflyG1_dinXtwdl_re_dly2, 18);
  Radix22ButterflyG1_btf2_re_reg_next <= Radix22ButterflyG1_sub_cast - Radix22ButterflyG1_sub_cast_1;
  Radix22ButterflyG1_add_cast_2 <= resize(Radix22ButterflyG1_x_im_dly1, 18);
  Radix22ButterflyG1_add_cast_3 <= resize(Radix22ButterflyG1_dinXtwdl_im_dly2, 18);
  Radix22ButterflyG1_btf1_im_reg_next <= Radix22ButterflyG1_add_cast_2 + Radix22ButterflyG1_add_cast_3;
  Radix22ButterflyG1_sub_cast_2 <= resize(Radix22ButterflyG1_x_im_dly1, 18);
  Radix22ButterflyG1_sub_cast_3 <= resize(Radix22ButterflyG1_dinXtwdl_im_dly2, 18);
  Radix22ButterflyG1_btf2_im_reg_next <= Radix22ButterflyG1_sub_cast_2 - Radix22ButterflyG1_sub_cast_3;
  dinXTwdlf_re <= dinXTwdl_re;
  dinXTwdlf_im <= dinXTwdl_im;
  btf1_re <= Radix22ButterflyG1_btf1_re_reg(16 DOWNTO 0);
  btf1_im <= Radix22ButterflyG1_btf1_im_reg(16 DOWNTO 0);
  btf2_re <= Radix22ButterflyG1_btf2_re_reg(16 DOWNTO 0);
  btf2_im <= Radix22ButterflyG1_btf2_im_reg(16 DOWNTO 0);

  dout_1_1_re <= dout_1_1_re_tmp;

  dout_1_1_im <= dout_1_1_im_tmp;

  dinXTwdl_1_1_vld <= dinXTwdl_1_1_vld_1;

END rtl;

