library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter1st is
port (
  clk : in std_ulogic;
  rst_n : in std_ulogic;
  ld_15_i : in std_ulogic;
  val_is_183_o : out std_ulogic);
end entity;

-- counter1st implementation with
--  * process
--  * integer type

architecture rtl of counter1st is
  signal cnt : integer range 0 to 255;
begin

process (clk, rst_n)
begin
  if rst_n = '0' then
    cnt <= 0;
  elsif rising_edge(clk) then
    if ld_15_i = '1' then
      cnt <= 15;
    elsif cnt = 255 then
      cnt <= 0;
    else
      cnt <= cnt + 1;
    end if;
  end if;
end process;

val_is_183_o <= '1' when cnt = 183 else '0';

end architecture;
