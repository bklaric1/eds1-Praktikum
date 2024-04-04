library ieee;
use ieee.std_logic_1164.all;

-- Convert a binary number to control signals for HEX Display
entity bin2seg is 
port ( bin_i   : in      std_ulogic_vector(3 downto 0);
       seg_o   : out     std_ulogic_vector(6 downto 0));  
end entity;

architecture rtl of bin2seg is 

  -- seven-segment positions
  -- 
  -- segment positions    input vector index     segment name
  --      a                      0            =>     a
  --     ---                     1            =>     b
  --  f |   | b                  2            =>     c
  --     ---   <- g              3            =>     d 
  --  e |   | c                  4            =>     e 
  --     ---                     5            =>     f 
  --      d                      6            =>     g


  -- The segment LED will be switched on when the output is '0' and off when
  -- output is '1'
  
begin
    
  with bin_i select
    seg_o <=
--   gfedcba segment
    "1000000" when "0000",              -- 0
    "1111001" when "0001",              -- 1
    "0100100" when "0010",              -- 2
    "0110000" when "0011",
    "0011001" when "0100",
    "0010010" when "0101",
    "0000010" when "0110",
    "1111000" when "0111",
    "0000000" when "1000",
    "0010000" when "1001",
    "0001000" when "1010",
    "0000011" when "1011",
    "1000110" when "1100",
    "0100001" when "1101",              -- 13
    "0000110" when "1110",              -- 14
    "0001110" when others;              -- 15

end architecture rtl; 
