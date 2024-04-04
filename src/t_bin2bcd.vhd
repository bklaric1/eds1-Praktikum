-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity t_bin2bcd is
end entity;

architecture tbench of t_bin2bcd is
  component bin2bcd is
    port (clk     : in  std_ulogic;
          rst_n   : in  std_ulogic;
          start_i : in  std_ulogic;
          done_o  : out std_ulogic; 
          bin_i   : in  unsigned(9 downto 0);
          bcd0_o  : out unsigned(3 downto 0);
          bcd1_o  : out unsigned(3 downto 0);
          bcd2_o  : out unsigned(3 downto 0);
          bcd3_o  : out unsigned(3 downto 0));  
  end component;

  signal number : unsigned(9 downto 0);
  
  signal clk, rst_n, start, done : std_ulogic;
  signal z0, z1, z2, z3: unsigned(3 downto 0);

  signal simstop : boolean := false;
  
begin
  
  clk_p : process
  begin
    clk <= '0';
    wait for 10 ns; 
    clk <= '1'; 
    wait for 10 ns;
    if simstop then
      wait;
    end if;
  end process clk_p;  

  simstop <= false, true after 500 ns;
  
  rst_n <= '0', '1' after 20 ns;

  start    <= '0', '1' after 100 ns, '0' after 120 ns;

  number <= to_unsigned(918,number'length);
  
    bin2bcd_i0 : bin2bcd
    port map (
      clk     => clk, 
      rst_n   => rst_n,
      start_i => start,
      done_o  => done,
      bin_i   => number,
      bcd0_o  => z0,
      bcd1_o  => z1,
      bcd2_o  => z2,
      bcd3_o  => z3);

end architecture; 




