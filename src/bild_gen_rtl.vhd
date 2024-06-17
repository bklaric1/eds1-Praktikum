library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bild_gen_rtl is
  port (clk       : in  std_ulogic;
        rst_n     : in  std_ulogic;
        x         : in  std_ulogic_vector(9 downto 0);
        y         : in  std_ulogic_vector(9 downto 0);
        r         : out std_ulogic;
        g         : out std_ulogic;
        b         : out std_ulogic);
end entity;

architecture rtl of bild_gen_rtl is

  signal d, q     :   integer;

begin

  g <= '0';
  b <= '0';

  q <= 0 when rst_n = '0' else d when rising_edge(clk);
  d <= 1 when x > 47 and x < 688 else 0;
  r <= std_ulogic(q);

end architecture rtl;