library ieee;
use ieee.std_logic_1164.all;

-- Testbench for the first switch/led module
-- The switches are switched...

entity t_de1_meta is
end; 

architecture tbench of t_de1_meta is

  component de1_meta is 
    port ( SW       : in  std_ulogic_vector(9 downto 0);
           KEY      : in  std_ulogic_vector(3 downto 0); 
           CLOCK_50 : in  std_ulogic;
           CLOCK_27 : in  std_ulogic;
           LEDG     : out std_ulogic_vector(7 downto 0);   -- green LEDs
           LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
  end component;

-- Signal declaration for the switches and the leds
  signal switches, redleds : std_ulogic_vector(9 downto 0);
  signal greenleds : std_ulogic_vector(7 downto 0);
  signal keys : std_ulogic_vector(3 downto 0);
  signal clock50, clock27 : std_ulogic;

  signal simstop : boolean := false;

begin

  -- Here the device under test is instantiated
  -- The ledsw circuit is connected to the signals in the testbench
  de1_meta_i0 : de1_meta
    port map (
      SW                  => switches,
      KEY                 => keys,
      CLOCK_50            => clock50,
      CLOCK_27            => clock27,
      LEDG                => greenleds, 
      LEDR                => redleds);

  -- This is the process where the switches are switched.
  schalter : process
  begin
    wait for 1 us; 
    switches <= "0000000001";
    wait for 3 us;
    switches <= "1000000000";
    wait for 2 us; 
    switches <= "0000000001";
    wait for 5 us;
    switches <= "1000000000"; 
    wait for 4 us;
    switches <= "1111111111";
    wait for 1 us; 
    wait;                               -- wait forever
  end process schalter;

  keys <= "0000", "1111" after 10 ns;

  clk50_p : process
  begin
    clock50 <= '0', '1' after 10 ns;
    wait for 20 ns;
    if simstop then
      wait;
    end if;
  end process clk50_p;

  clk27_p : process
  begin
    clock27 <= '0', '1' after 18 ns;
    wait for 37 ns;
    if simstop then
      wait;
    end if;
  end process clk27_p;

  simstop <= true after 300 us; 
      

end; -- architecture
