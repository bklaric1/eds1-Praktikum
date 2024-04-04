library ieee;
use ieee.std_logic_1164.all; 

entity t_de1_uart is
end entity;


architecture tbench of t_de1_uart is
  
component de1_uart is
  port (
    CLOCK_50     : in std_ulogic;
    KEY          : in std_ulogic_vector;
    LEDR         : out std_ulogic_vector(9 downto 0);
    -- Data
    UART_RXD     : in std_ulogic;
    UART_TXD     : out std_ulogic); 
end component;

signal clk, rst_n : std_ulogic;
signal strstart, rxd, txd : std_ulogic;

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
    rst_n <= '0';
    strstart <= '0';
    wait for 100 ns;
    wait until falling_edge(clk);
    rst_n <= '1';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    strstart <= '1';

    wait until falling_edge(clk);
    strstart <= '0';
    wait for 18*10 us;
    assert false report "Simulation time finished";
    simstop <= true;
    wait;
  end process;

  check_p : process
  variable rx : std_ulogic_vector(7 downto 0);
  begin
    wait until falling_edge(txd);
    wait for bt/2;
    assert txd = '0' report "Start Bit is Wrong";
    for i in 0 to 7 loop
      wait for bt;
      rx(i) := txd;
    end loop;
    assert rx = x"AB" report "RX: Wrong Data";
    wait for bt;
    assert txd = '1' report "Stop Bit is Wrong";
    
    wait for 200 ns;
    assert false report "Simulation done! No Errors";
  end process check_p;
  
  
  de1_uart_i0 : de1_uart
    port map (
      CLOCK_50     => clk,
      KEY(0)   => rst_n,
      KEY(1)   => strstart,
      KEY(3 downto 2) => "00",
      LEDR => open,
      UART_RXD => rxd,
      UART_TXD => txd);

end architecture; 




