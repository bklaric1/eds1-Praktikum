library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.p_4b5b.all;

entity t_tx4b5b is
end entity;

architecture tbench of t_tx4b5b is

  signal clk, rst_n : std_ulogic;
  signal ld_data, done, serdat : std_ulogic;
  signal d : std_ulogic_vector(7 downto 0);
  constant H  : std_ulogic_vector := "0101010010";
  constant expected_data : std_ulogic_vector := JK & H & TT;
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
    ld_data <= '0';
    d <= std_ulogic_vector(to_unsigned(character'pos('H'),8));
    wait until rising_edge(rst_n);
    for i in 0 to 14 loop
      wait until falling_edge(clk);
    end loop;
    ld_data <= '1';
    wait until falling_edge(clk);
    ld_data <= '0';
    for i in expected_data'range loop 
      assert serdat = expected_data(i) report "ERROR: wrong serial data";
      wait until falling_edge(clk);
    end loop;
    wait for 100 ns;
    wait until falling_edge(clk);
    ld_data <= '1';
    d <= std_ulogic_vector(to_unsigned(character'pos('a'),8));
    wait until falling_edge(clk);
    ld_data <= '0';
    wait until falling_edge(done);
    wait until falling_edge(clk);
    ld_data <= '1';
    d <= std_ulogic_vector(to_unsigned(character'pos('z'),8));
    wait until falling_edge(clk);
    ld_data <= '0';
    wait until falling_edge(done);
    wait for 400 ns;
    assert false report "Simulation finished with SUCCESS" severity note;
    simstop <= true;
    wait;
  end process;
  
  process
    begin
      search_JK(clk,serdat);
      rx_byte_compare(clk,serdat,'H');
      search_JK(clk,serdat);
      rx_byte_compare(clk,serdat, 'a');
      rx_byte_compare(clk,serdat, 'z');
      wait;
    end process;

  dut : entity work.tx4b5b(rtl)
    port map (
      clk          => clk,
      rst_n        => rst_n,
      ld_data_i    => ld_data,
      d_i          => d,
      ser_o        => serdat,
      done_o       => done);
  
end architecture;
