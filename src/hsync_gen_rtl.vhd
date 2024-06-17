library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hsync_gen_rtl is
  port (clk       : in  std_ulogic;
        rst_n     : in  std_ulogic;
        pixel_cnt : in  std_ulogic_vector(9 downto 0);
        hsync     : out std_ulogic);
end entity;

architecture rtl of hsync_gen_rtl is

begin
    
	 hsync <= '0' when pixel_cnt > "1100011111" else '1';

end architecture rtl;