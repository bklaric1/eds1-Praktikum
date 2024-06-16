library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity line_cnt is
  port (clk       : in  std_ulogic;
        rst_n     : in  std_ulogic;
        pixel_cnt : in  std_ulogic_vector(9 downto 0);
        hsync     : out std_ulogic);
end entity;

architecture rtl of hsync_gen_rtl is

    variable cnt_value    :   integer;

begin

    process (clk, rst_n)
    begin
      cnt_value <= pixel_cnt;
      if rst_n = '0' then
        hsync <= '1';
      elsif rising_edge(clk) then
        if pixel_cnt = 800 then
          hsync <= '0';
        else
          hsync <= '1';
        end if;
      end if;
    end process;

end architecture rtl;