-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity serdat is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Datapath signals
    d_i     : in std_ulogic_vector(7 downto 0);
    s_o     : out std_ulogic;
    -- Control signals
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
end entity;

architecture rtl of serdat is

    component serdatdp is
    port (
      clk     : in std_ulogic;
      rst_n   : in std_ulogic;
      ld_i    : in std_ulogic;
      en_i    : in std_ulogic;
      sel_i   : in std_ulogic;
      pd_i    : in std_ulogic;
      d_i     : in std_ulogic_vector(7 downto 0);
      s_o     : out std_ulogic);
  end component;

component serdatctr is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_o    : out std_ulogic;
    en_o    : out std_ulogic;
    sel_o   : out std_ulogic;
    pd_o    : out std_ulogic;
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
end component;

  signal ld, en, pd, sel : std_ulogic;

begin

  serdatdp_i0 : serdatdp
    port map (
      clk     => clk,
      rst_n   => rst_n,
      d_i     => d_i,
      s_o     => s_o,
      ld_i    => ld,
      en_i    => en,
      sel_i   => sel,
      pd_i    => pd); 

    serdatctr_i0 : serdatctr
      port map (
        clk     => clk,
        rst_n   => rst_n,
        start_i => start_i,
        done_o  => done_o,
        ld_o    => ld,
        en_o    => en,
        pd_o    => pd,
        sel_o => sel);
      
end architecture rtl; 




