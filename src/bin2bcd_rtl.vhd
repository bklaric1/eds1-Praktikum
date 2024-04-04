library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Convert a binary number to BCD for display on 7-Segment

entity bin2bcd is
  port (clk     : in  std_ulogic;
        rst_n   : in  std_ulogic;
        start_i : in  std_ulogic;
        done_o  : out std_ulogic; 
        bin_i   : in  unsigned(9 downto 0);
        bcd0_o  : out unsigned(3 downto 0);
        bcd1_o  : out unsigned(3 downto 0);
        bcd2_o  : out unsigned(3 downto 0);
        bcd3_o  : out unsigned(3 downto 0));  
end entity;

architecture rtl of bin2bcd is

begin
  
  bcd0_o <= "0000";
  bcd1_o <= "0001";
  bcd2_o <= "0010";
  bcd3_o <= "0011";
  done_o <= '1'; 

end architecture rtl;
