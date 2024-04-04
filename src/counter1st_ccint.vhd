library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Counter1st implementation with
--  * concurrent signal assignments
--  * integer type
architecture ccint of counter1st is
  signal cnt, cntnew : integer range 0 to 255;
begin

  cnt <= 0 when rst_n = '0' else cntnew when rising_edge(clk);
  cntnew <= 15 when ld_15_i = '1' else
            0  when cnt = 255 else cnt + 1;
  val_is_183_o <= '1' when cnt = 183 else '0';

end architecture;
