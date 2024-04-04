-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity sermulctr is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_o    : out std_ulogic;
    store_o : out std_ulogic;
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
end entity;

architecture rtl of sermulctr is
  
begin
  
   
end architecture rtl; 




