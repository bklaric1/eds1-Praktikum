-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity sermuldp is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_i    : in std_ulogic;
    store_i : in std_ulogic; 
    x_i     : in unsigned(4 downto 0);
    y_i     : in unsigned(4 downto 0); 
    res_o   : out unsigned(9 downto 0));
end entity;

architecture rtl of sermuldp is
  
  signal sr, newsr : unsigned(4 downto 0); 
  signal sumandr   : unsigned(4 downto 0);
  
  signal newacc, acc, res : unsigned(9 downto 0);  
      
begin
  
  sr <= (others => '0') when rst_n = '0' else newsr when rising_edge(clk); 
  newsr <= x_i when ld_i = '1' else sr(3 downto 0) & '0';
  
  sumandr <= (others => '0') when sr(4) = '0' else y_i; 
  
  res <= sumandr + shift_left(acc,1); 
  
  acc <= (others => '0') when rst_n = '0' else newacc when rising_edge(clk); 
  
  newacc <= (others => '0') when ld_i = '1' else res; 
  
  res_o <= (others => '0') when rst_n = '0' else res when store_i = '1' and rising_edge(clk);  
   
end architecture rtl; 




