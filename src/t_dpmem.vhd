library ieee;
use ieee.std_logic_1164.all;

entity t_dpmem is
end entity;


architecture tbench of t_dpmem is
component dpmem is
  port (
    clk     : in std_ulogic;
    d_i     : in std_ulogic_vector(7 downto 0);
    a_i     : in std_ulogic_vector(2 downto 0);
    we_i    : in std_ulogic;
    d_o     : out std_ulogic_vector(7 downto 0);
    d2_i    : in std_ulogic_vector(7 downto 0);
    a2_i    : in std_ulogic_vector(2 downto 0);
    we2_i   : in std_ulogic;
    d2_o    : out std_ulogic_vector(7 downto 0));
end component;

signal clk : std_ulogic;
signal d,rd : std_ulogic_vector(7 downto 0);
signal we : std_ulogic;
signal a : std_ulogic_vector(2 downto 0);

signal d2,rd2 : std_ulogic_vector(7 downto 0);
signal we2 : std_ulogic;
signal a2 : std_ulogic_vector(2 downto 0);

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
    we2 <= '0';
    a2 <= "101";
    d2 <= x"78";
    we <= '0';
    a <= "000";
    wait for 100 ns;
    wait until falling_edge(clk);
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
    -- Dual port
    wait until falling_edge(clk);
    a2 <= "UUU";
    wait for 100 ns;
    a2 <= "101";
    wait until falling_edge(clk);
    a2 <= "UUU";
    wait for 100 ns;
    wait until falling_edge(clk);
    a2 <= "110";
    we2 <= '1';
    d2 <= x"AB";
    a  <= "110";
    d  <= x"00";
    we <= '1';
    wait until falling_edge(clk);
    a2 <= "UUU";
    we2 <= '0';
    d2 <= "UUUUUUUU";
    a  <= "UUU";
    d  <= "UUUUUUUU";
    we <= '0';
    wait for 100 ns;
    wait until falling_edge(clk);
    a2 <= "101";
    we2 <= '1';
    d2 <= x"34";
    a  <= "101";
    d  <= x"00";
    we <= '0';
    wait until falling_edge(clk);
    a2 <= "UUU";
    we2 <= '0';
    d2 <= "UUUUUUUU";
    a  <= "UUU";
    d  <= "UUUUUUUU";
    we <= '0';
    wait until falling_edge(clk);
    assert false report "Simulation time finished";
    simstop <= true;
    wait;
  end process;

  dpmem_i0 : dpmem
    port map (
      clk     => clk,
      we_i    => we,
      a_i     => a,
      d_i     => d,
      d_o     => rd,
      we2_i   => we2,
      a2_i    => a2,
      d2_i    => d2,
      d2_o    => rd2);

end architecture;
