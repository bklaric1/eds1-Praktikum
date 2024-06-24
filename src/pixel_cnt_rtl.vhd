library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixel_cnt is
    port(clk        : in    std_ulogic;
         rst_n      : in    std_ulogic;
         en_i       : in    std_ulogic;
         cnt_o      : out   std_ulogic_vector(9 downto 0);
         done_o     : out   std_ulogic);
end entity;

architecture rtl of pixel_cnt is

signal d, q, add, mpx ,  : unsigned(9 downto 0);

begin

    q <= "0000000000" when rst_n = '0' else d when rising_edge(clk);
    d <= mpx when en_i = '1' else q;

    mpx <= to_unsigned(1100011111, q'length) when q = "1100011111" else add;
    add <= q - 1;

    cnt_o <= std_ulogic_vector(q);
    done_o <= '1' when q = "1100100000" else '0';

end architecture rtl;