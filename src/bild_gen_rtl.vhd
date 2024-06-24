library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bild_gen_rtl is
  port (clk       : in  std_ulogic;
        rst_n     : in  std_ulogic;
        x         : in  std_ulogic_vector(9 downto 0);
        y         : in  std_ulogic_vector(9 downto 0);
        r         : out std_ulogic_vector(3 downto 0);
        g         : out std_ulogic_vector(3 downto 0);
        b         : out std_ulogic_vector(3 downto 0));
end entity;

architecture rtl of bild_gen_rtl is

  signal d, q     :		unsigned(3 downto 0);

begin

  r <= "1111" when x > "0000101111" and x < "1010110000" else "0000";
  g <= "0000";
  b <= "0000";

end architecture rtl;