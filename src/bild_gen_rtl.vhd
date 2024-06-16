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


begin


end architecture rtl;