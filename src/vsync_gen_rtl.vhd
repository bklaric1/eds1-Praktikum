library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity line_cnt is
  port (clk       : in  std_ulogic;
        rst_n     : in  std_ulogic;
        line_cnt  : in  std_ulogic_vector(9 downto 0);
        vsync     : out std_ulogic);
end entity;

architecture rtl of vsync_gen_rtl is

    variable cnt_value    :   integer;

begin

    process (clk, rst_n)
    begin
      cnt_value <= line_cnt;
      if rst_n = '0' then
        vsync <= '1';
      elsif rising_edge(clk) then
        if line_cnt = 525 then
          vsync <= '0';
        else
          vsync <= '1';
        end if;
      end if;
    end process;

end architecture rtl;