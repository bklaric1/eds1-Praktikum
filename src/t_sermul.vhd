-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity t_sermul is
end entity;

architecture tbench of t_sermul is

  component sermul is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Datapath signals
    x_i     : in unsigned(4 downto 0);
    y_i     : in unsigned(4 downto 0); 
    res_o   : out unsigned(9 downto 0);
    -- Control signals
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
  end component;

  signal x,y : unsigned(4 downto 0);
  signal res : unsigned(9 downto 0);
  
  signal clk, rst_n, start, done : std_ulogic; 

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

  simstop <= false, true after 500 ns;
  
  rst_n <= '0', '1' after 20 ns;

  x <= to_unsigned(5,x'length);
  y <= to_unsigned(18,x'length);
  
  start    <= '0', '1' after 100 ns, '0' after 120 ns;
  
  sermul_i0 : sermul
    port map (
      clk     => clk,
      rst_n   => rst_n,
      start_i    => start,
      done_o => done,
      x_i     => x,
      y_i     => y,
      res_o   => res); 
  
end architecture; 




