library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity mem is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    d_i     : in std_ulogic_vector(7 downto 0);
    a_i     : in std_ulogic_vector(2 downto 0);
    we_i    : in std_ulogic;
    d_o     : out std_ulogic_vector(7 downto 0));
end entity;

architecture rtl of mem is
  
  type mem_t is array (0 to 2**a_i'length-1) of std_ulogic_vector(7 downto 0);
  
  signal mem : mem_t;
  
  signal a,a_reg : integer range 0 to 2**a_i'length-1;

begin
  
  a <= to_integer(unsigned(a_i));
  
  mem_p : process (clk, rst_n)
    begin
      if rising_edge(clk) then
		  a_reg <= a;
        if we_i = '1' then
          mem(a) <= d_i;
        end if;
      end if;
    end process;
  
  d_o <= mem(a_reg);  
  --d_o <= mem(a_reg) when rising_edge(clk);
  
end architecture rtl; 




