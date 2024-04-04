-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity t_serdat is
end entity;

architecture tbench of t_serdat is

  component serdat is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Datapath signals
    d_i     : in std_ulogic_vector(7 downto 0);
    s_o     : out std_ulogic;
    -- Control signals
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
  end component;

  signal d   : std_ulogic_vector(7 downto 0);
  signal s   : std_logic;
  
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

  d <= "11101010";
  
  start    <= '0', '1' after 100 ns, '0' after 120 ns;
  
  serdat_i0 : serdat
    port map (
      clk     => clk,
      rst_n   => rst_n,
      start_i => start,
      done_o  => done,
      d_i     => d,
      s_o     => s); 
  
end architecture; 




