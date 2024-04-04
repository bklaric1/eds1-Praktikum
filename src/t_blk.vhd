library ieee;
use ieee.std_logic_1164.all;

entity t_blk is
end entity;

architecture tbench of t_blk is

  signal clk, rst_n : std_ulogic;
  signal start : std_ulogic;
  signal led : std_ulogic_vector(3 downto 0);
  signal simstop : boolean := false;
  
begin

  process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    if simstop then -- simulation stopper
      wait;
    end if;   
  end process;

  rst_n <= '0', '1' after 55 ns;

  process
  begin
    start <= '0';
    wait until rising_edge(rst_n);
    wait for 400 ns;
    wait until falling_edge(clk);
    start <= '1';
    wait for 600 ns;
    wait until falling_edge(clk);
    start <= '0';
    wait for 2 us;
    simstop <= true;
    wait;
  end process;
  
  dut : entity work.blk(rtl)
    port map (
      clk          => clk,
      rst_n        => rst_n,
      start_i      => start,
      led_o        => led);
  
end architecture;
