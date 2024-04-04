library ieee;
use ieee.std_logic_1164.all;

entity blkcnt is
  port(
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_i    : in std_ulogic;
    done_o  : out std_ulogic);
end entity;

architecture rtl of blkcnt is
  signal cnt, cntnew : integer range 0 to 5;
begin

  cnt <= 0 when rst_n = '0' else cntnew when rising_edge(clk);
  cntnew <= 5 when ld_i = '1' else 0 when cnt = 0 else cnt-1;
  done_o <= '1' when cnt = 0 else '0';
  
end architecture;
