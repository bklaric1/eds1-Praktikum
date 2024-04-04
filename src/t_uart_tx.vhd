library ieee;
use ieee.std_logic_1164.all; 

entity t_uart_tx is
end entity;


architecture tbench of t_uart_tx is
component uart_tx is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Data
    d_i     : in std_ulogic_vector(7 downto 0);
    ser_o   : out std_ulogic; 
    -- Control signals
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
end component;

signal clk, rst_n : std_ulogic;
signal start, done : std_ulogic;
signal d : std_ulogic_vector(7 downto 0);
signal ser : std_ulogic;

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
    start <= '0';
    wait for 100 ns;
    wait until falling_edge(clk);
    rst_n <= '1';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    start <= '1';
    d <= x"AB";
    wait until falling_edge(clk);
    start <= '0';
    d <= (others => 'X');
    wait for 500 ns;
    assert false report "Simulation time finished";
    simstop <= true;
    wait;
  end process;

  check_p : process
  variable rx : std_ulogic_vector(7 downto 0);
  begin
    wait until falling_edge(ser);
    wait for bt/2;
    assert ser = '0' report "Start Bit is Wrong";
    for i in 0 to 7 loop
      wait for bt;
      rx(i) := ser;
    end loop;
    assert rx = x"AB" report "RX: Wrong Data";
    wait for bt;
    assert ser = '1' report "Stop Bit is Wrong";
    
    wait for 200 ns;
    assert false report "Simulation done! No Errors";
  end process check_p;
  
  
  uart_tx_i0 : uart_tx
    port map (
      clk     => clk,
      rst_n   => rst_n,
      start_i => start,
      done_o  => done,
      ser_o   => ser,
      d_i     => d); 

end architecture; 




