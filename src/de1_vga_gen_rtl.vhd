library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_vga_gen is
    port(clk    : in    std_ulogic;
         rst_n  : in    std_ulogic;
         r_o    : out   std_ulogic_vector(3 downto 0);
         g_o    : out   std_ulogic_vector(3 downto 0);
         b_o    : out   std_ulogic_vector(3 downto 0);
         hsync  : out   std_ulogic;
         vsync  : out   std_ulogic);

architecture rtl of de1_vga_gen is

component line_cnt is
    port (clk       : in  std_ulogic;
          rst_n     : in  std_ulogic;
          en        : in  std_ulogic;
          cnt_o     : out std_ulogic_vector(9 downto 0));
end component;

component pixel_cnt is
    port();

end component;

begin

end architecture rtl;
