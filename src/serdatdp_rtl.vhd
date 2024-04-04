-- Type test file
library ieee;
use ieee.std_logic_1164.all; 

entity serdatdp is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_i    : in std_ulogic;
    en_i    : in std_ulogic;
    pd_i    : in std_ulogic;
    sel_i   : in std_ulogic;
    d_i     : in std_ulogic_vector(7 downto 0);
    s_o     : out std_ulogic);
end entity;

architecture rtl of serdatdp is
  
begin
  
end architecture rtl; 




