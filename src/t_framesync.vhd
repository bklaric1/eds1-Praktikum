library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.p_4b5b.all;

entity t_framesync is
end entity;

architecture tbench of t_framesync is

  signal clk, rst_n : std_ulogic;
  signal start, serdat : std_ulogic;
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
    wait for 350 ns;
    wait until falling_edge(clk);
    start <= '1';
    wait until falling_edge(clk);
    start <= '0';
    wait for 4000 ns;
    assert false report "Simulation finished with SUCCESS" severity note;
    simstop <= true;
    wait;
  end process;
  
  process
  begin
    search_JK(clk,serdat);
    rx_byte_compare(clk,serdat,'H');
    rx_byte_compare(clk,serdat, 'a');
    rx_byte_compare(clk,serdat, 'l');
    search_JK(clk,serdat);
    rx_byte_compare(clk,serdat, 'a');
    rx_byte_compare(clk,serdat, 'b');
    wait;
  end process;
  
  dut : entity work.framesync(rtl)
    port map (
      clk          => clk,
      rst_n        => rst_n,
      start_i      => start,
      ser_o        => serdat);
  
end architecture;
