library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- counter1st implementation with
--  * process
--  * unsigned type

architecture prus of counter1st is
  signal cnt : unsigned(7 downto 0);
begin

process (clk, rst_n)
begin
  if rst_n = '0' then
    cnt <= to_unsigned(0, cnt'length);
  elsif rising_edge(clk) then
    if ld_15_i = '1' then
      cnt <= to_unsigned(15, cnt'length);
    else
      cnt <= cnt + 1;
    end if;
  end if;
end process;

val_is_183_o <= '1' when cnt = 183 else '0';

end architecture;
