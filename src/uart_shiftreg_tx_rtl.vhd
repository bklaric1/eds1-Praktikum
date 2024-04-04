library ieee;
use ieee.std_logic_1164.all; 

entity uart_shiftreg_tx is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_i    : in std_ulogic;
    shift_i : in std_ulogic; 
    d_i     : in std_ulogic_vector(7 downto 0);
    ser_o   : out std_ulogic);
end entity;

architecture rtl of uart_shiftreg_tx is
  
  signal sr : std_ulogic_vector(8 downto 0); 
      
begin

  process (clk, rst_n)
  begin
    if rst_n = '0' then
      sr <= (others => '1');
    elsif rising_edge(clk) then
      if ld_i = '1' then
        sr <= d_i & '0';
      elsif shift_i = '1' then
        sr <= '1' & sr(8 downto 1);
      end if;
    end if;
  end process;

  ser_o <= sr(0);

end architecture rtl; 




