library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity line_cnt is
  port (clk       : in  std_ulogic;
        rst_n     : in  std_ulogic;
        en        : in  std_ulogic;
        cnt_o     : out std_ulogic_vector(9 downto 0));
end entity;

architecture rtl of line_cnt is

    signal d, q   : unsigned(9 downto 0);

begin

    q <= "0000000000" when rst_n = '0' else d when rising_edge(clk);
    d <= "0000000000" when q > 523 else q when en = '0' else q + 1; 

    cnt_o <= std_ulogic_vector(q);

end architecture rtl;