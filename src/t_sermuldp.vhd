-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity t_sermuldp is
end entity;

architecture tbench of t_sermuldp is

  component sermuldp is
    port (
      clk     : in std_ulogic;
      rst_n   : in std_ulogic;
      ld_i    : in std_ulogic;
      store_i : in std_ulogic; 
      x_i     : in unsigned(4 downto 0);
      y_i     : in unsigned(4 downto 0); 
      res_o   : out unsigned(9 downto 0));
  end component;

  
  signal x,y : unsigned(4 downto 0);
  signal res : unsigned(9 downto 0);
  
  signal clk, rst_n, store, ld : std_ulogic;

  signal simstop : boolean := false;
  
begin
  
  clk_p : process
  begin
    clk <= '0';
    wait for 10 ns; 
    clk <= '1'; 
    wait for 10 ns;
    if simstop then
      wait; 
    end if;
  end process clk_p;  
  
  rst_n <= '0', '1' after 20 ns;

  simstop <= false, true after 500 ns; 

  x <= to_unsigned(5,x'length);
  y <= to_unsigned(18,x'length);
  
  ld    <= '0', '1' after 100 ns, '0' after 120 ns;
  store <= '0', '1' after 200 ns, '0' after 220 ns; 
  
  sermuldp_i0 : sermuldp
    port map (
      clk     => clk,
      rst_n   => rst_n,
      ld_i    => ld,
      store_i => store,
      x_i     => x,
      y_i     => y,
      res_o   => res); 
  
end architecture; 




