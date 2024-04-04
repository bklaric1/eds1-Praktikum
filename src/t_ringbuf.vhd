library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity t_ringbuf is
end entity;


architecture tbench of t_ringbuf is
component ringbuf is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    d_i     : in std_ulogic_vector(7 downto 0);
    we_i    : in std_ulogic;
    re_i    : in std_ulogic;
    e_ofl_o : out std_ulogic; -- Buffer overflow
    e_ufl_o : out std_ulogic;
    d_o     : out std_ulogic_vector(7 downto 0));
end component;

signal clk, rst_n : std_ulogic;
signal wd,rd : std_ulogic_vector(7 downto 0);
signal we,re : std_ulogic;
signal e_ofl, e_ufl : std_ulogic;


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
    wd <= (others => 'X');
    rst_n <= '0';
    we <= '0';
    re <= '0';
    wait for 100 ns;
    wait until falling_edge(clk);
    rst_n <= '1';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    for i in 0 to 50 loop
      we <= '1';
      wd <= std_ulogic_vector(to_unsigned(i,wd'length));
      wait until falling_edge(clk);
      we <= '0';
      wd <= (others => 'X');
      for k in 0 to 3 loop
        wait until falling_edge(clk);
      end loop;
    end loop;
    wait for 300 ns;    
    assert false report "Simulation time finished";
    simstop <= true;
    wait;
  end process;
  
  ringbuffer_i0 : ringbuf
    port map (
      clk     => clk,
      rst_n   => rst_n,
      we_i    => we,
      re_i    => re,
      d_i     => wd,
      e_ofl_o => e_ofl,
      e_ufl_o => e_ufl,
      d_o     => rd); 

end architecture; 




