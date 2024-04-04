library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity ringbuf is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    d_i     : in std_ulogic_vector(7 downto 0);
    we_i    : in std_ulogic;
    re_i    : in std_ulogic;
    e_ofl_o : out std_ulogic; -- Buffer overflow
    e_ufl_o : out std_ulogic;
    d_o     : out std_ulogic_vector(7 downto 0));
end entity;

architecture rtl of ringbuf is

begin
  
end architecture rtl; 




