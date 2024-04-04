library ieee;
use ieee.std_logic_1164.all; 

entity blk is
  port(
    clk       : in std_ulogic;
    rst_n     : in std_ulogic;
    start_i   : in std_ulogic;
    led_o     : out std_ulogic_vector(3 downto 0));
end entity;

architecture rtl of blk is
  signal load, done : std_ulogic;
begin

  sm_i0 : entity work.blksm(rtl)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      start_i  => start_i,
      led_o    => led_o,
      done_i   => done,
      ld_o     => load);

  cnt_i0 : entity work.blkcnt(rtl)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      done_o   => done,
      ld_i     => load);
end architecture;


