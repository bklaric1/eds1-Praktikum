library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vsync_gen_rtl is
  port (clk       : in  std_ulogic;
        rst_n     : in  std_ulogic;
        line_cnt  : in  std_ulogic_vector(9 downto 0);
        vsync     : out std_ulogic);
end entity;

architecture rtl of vsync_gen_rtl is

begin

    vsync <= '0' when line_cnt > "1000001100" else '1';

end architecture rtl;