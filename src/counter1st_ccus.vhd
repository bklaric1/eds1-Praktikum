library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Counter1st implementation with
--  * concurrent signal assignments
--  * unsigned type
architecture ccus of counter1st is
  signal cnt, cntnew : unsigned(7 downto 0);
begin

  cnt <= to_unsigned(0,cnt'length)  when rst_n = '0' else cntnew when rising_edge(clk);
  cntnew <= to_unsigned(15,cnt'length) when ld_15_i = '1' else cnt + 1;
  val_is_183_o <= '1' when cnt = 183 else '0';

end architecture;
