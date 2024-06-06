library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_sta is
  port (clk      : in std_ulogic;
        LEDR0    : out std_ulogic);
end entity;

architecture rtl of de1_sta is
  function ones_f (x : unsigned) return integer is
    variable no_of_ones : integer range 0 to x'length;
  begin
    for i in x'range loop
      if x(i) = '1' then
        no_of_ones := no_of_ones + 1;
      end if;
    end loop;
    return no_of_ones;
  end function;
  signal cnt : unsigned(63 downto 0);
  signal no_of_ones : integer range 0 to cnt'length;
  signal res, res_reg : std_ulogic;
begin
  cnt <= cnt + 1 when rising_edge(clk);
  no_of_ones <= ones_f(cnt) when rising_edge(clk);
  res <= '1' when no_of_ones > cnt'length/2 else '0';
  res_reg <= res when rising_edge(clk);
  LEDR0 <= res_reg;
end architecture;
