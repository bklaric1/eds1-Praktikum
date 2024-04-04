library ieee;
use ieee.std_logic_1164.all; 

entity t_ledws2815 is
end entity;


architecture tbench of t_ledws2815 is
component ledws2815 is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Data
    d_i     : in std_ulogic_vector(7 downto 0);
    led_o   : out std_ulogic; 
    -- Control signals
    dv_i    : in std_ulogic;
    done_o  : out std_ulogic);
end component;
signal clk, rst_n : std_ulogic;
signal dv, done : std_ulogic;
signal d : std_ulogic_vector(7 downto 0);
signal led : std_ulogic;

constant bt : time := 17361 ns; -- Bit Time for 57600 Baud

signal simstop : boolean := false;

begin

  process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    if simstop then
      wait;
    end if;
  end process;

  process
  begin
    d <= (others => 'X');
    rst_n <= '0';
    dv <= '0';
    wait for 100 ns;
    wait until falling_edge(clk);
    rst_n <= '1';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    dv <= '1';
    d <= x"AB";
    wait until falling_edge(clk);
    dv <= '0';
    d <= (others => 'X');
    wait until falling_edge(clk) and done = '1';
    d <= x"03";
    dv <= '1';
    wait until falling_edge(clk);
    d <= (others => 'X');
    dv <= '0';
    wait for 14 us;
    assert false report "Simulation time finished";
    simstop <= true;
    wait;
  end process;

  
  ledws2815_i0 : ledws2815
    port map (
      clk     => clk,
      rst_n   => rst_n,
      dv_i => dv,
      done_o  => done,
      led_o   => led,
      d_i     => d); 

end architecture; 




