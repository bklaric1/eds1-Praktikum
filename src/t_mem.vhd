library ieee;
use ieee.std_logic_1164.all; 

entity t_mem is
end entity;


architecture tbench of t_mem is
component mem is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    d_i     : in std_ulogic_vector(7 downto 0);
    a_i     : in std_ulogic_vector(2 downto 0);
    we_i    : in std_ulogic;
    d_o     : out std_ulogic_vector(7 downto 0));
end component;

signal clk, rst_n : std_ulogic;
signal d,rd : std_ulogic_vector(7 downto 0);
signal we : std_ulogic;
signal a : std_ulogic_vector(2 downto 0);

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
    we <= '0';
    a <= "000";
    wait for 100 ns;
    wait until falling_edge(clk);
    rst_n <= '1';
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    we <= '1';
    a <= "110";
    d <= x"AB";
    wait until falling_edge(clk);
    we <= '0';
    d <= (others => 'X');
    a <= (others => 'X');
    wait for 100 ns;
    wait until falling_edge(clk);
    we <= '1';
    d <= x"FF";
    a <= "101";
    wait until falling_edge(clk);
    we <= '0';
    d <= (others => 'X');
    a <= (others => 'X');    
    wait for 500 ns;
    a <= "000";
    wait until falling_edge(clk);
    a <= "110";
    wait until falling_edge(clk);
    a <= "000";
    assert false report "Simulation time finished";
    simstop <= true;
    wait;
  end process;
  
  mem_i0 : mem
    port map (
      clk     => clk,
      rst_n   => rst_n,
      we_i    => we,
      a_i     => a,
      d_i     => d,
      d_o     => rd); 

end architecture; 




