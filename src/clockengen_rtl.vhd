library ieee;
use ieee.std_logic_1164.all;

entity clockengen is 
port ( clk   : in      std_ulogic;
       rst_n   :	in		std_ulogic;
		 en_o   : out     std_ulogic);  
end entity;

architecture rtl of clockengen is 
	signal d,q: std_ulogic;
  
begin
	q <= '0' when rst_n = '0' else d when rising_edge(clk);
	
	d <= not q;
	
	en_o <= q;

end architecture rtl; 
