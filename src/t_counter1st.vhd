library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t_counter1st is
end entity;

architecture tbench of t_counter1st is

  signal clk, rst_n : std_ulogic;
  signal ld_15, val_is_183 : std_ulogic;
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
    ld_15 <= '0';
    wait until rising_edge(rst_n);
    for i in 0 to 14 loop
      wait until falling_edge(clk);
      assert val_is_183 = '0' report "val_is_183 is wrong after startup" severity error;
    end loop;
    ld_15 <= '1';
    wait until falling_edge(clk);
    ld_15 <= '0';
    for i in 1 to 182-15 loop
      wait until falling_edge(clk);
      assert val_is_183 = '0' report "val_is_183 error after load" severity error;
    end loop;
    wait until falling_edge(clk);
    assert val_is_183 = '1' report "val_is_183 is not asserted" severity error;
    wait for 100 ns;
    assert false report "Simulation finished with SUCCESS" severity note;
    simstop <= true;
    wait;
  end process;
  
  dut : entity work.counter1st(ccint)
    port map (
      clk          => clk,
      rst_n        => rst_n,
      ld_15_i      => ld_15,
      val_is_183_o => val_is_183);
  
end architecture;
