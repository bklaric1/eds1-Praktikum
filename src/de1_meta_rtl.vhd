library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library altera_mf;
use altera_mf.all; 
--use altera_mf.altera_mf_components.all;

-- Combinational functions computed from switch values shown at the green leds
entity de1_meta is 
port ( SW       : in  std_ulogic_vector(9 downto 0);
       KEY      : in  std_ulogic_vector(3 downto 0); 
       CLOCK_50 : in  std_ulogic;
       CLOCK_27 : in  std_ulogic;
       LEDG     : out std_ulogic_vector(7 downto 0);   -- green LEDs
       LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
end entity;

architecture rtl of de1_meta is

  signal r0, r1, dat, sync, sync2, sync3 : std_ulogic;

  signal inc : std_ulogic;
  
  signal clk, pllclk : std_ulogic; 

  signal count : unsigned(31 downto 0);

  	COMPONENT altpll
	GENERIC (
		clk0_divide_by		: NATURAL;
		clk0_duty_cycle		: NATURAL;
		clk0_multiply_by		: NATURAL;
--		clk0_phase_shift		: STRING;
--		compensate_clock		: STRING;
		inclk0_input_frequency		: NATURAL;
--		intended_device_family		: STRING;
--		lpm_hint		: STRING;
--		lpm_type		: STRING;
		operation_mode		: STRING;
		port_inclk0		: STRING;
		port_clk0		: STRING
	);
	PORT (
			clk	: OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
			inclk	: IN STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
	END COMPONENT;
  
component pll
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
end component;

signal inclk : std_logic_vector(1 downto 0);
signal outclk : std_logic_vector(5 downto 0);

begin

--  pll_i0 : pll
--  port map (
--    c0  => pllclk,
--	 inclk0 => CLOCK_27
--    ); 

inclk(0) <= CLOCK_27; 
inclk(1) <= '0'; 

pllclk <= outclk(0); 
	 
	 	altpll_component : altpll
	GENERIC MAP (
		clk0_divide_by => 1,
		clk0_duty_cycle => 50,
		clk0_multiply_by => 20,
--		clk0_phase_shift => "0",
--		compensate_clock => "CLK0",
		inclk0_input_frequency => 50000,
		operation_mode => "NORMAL",
		port_inclk0 => "PORT_USED",
		port_clk0 => "PORT_USED"
	)
	PORT MAP (
		inclk => inclk,
		clk => outclk
	);

	 

  -- Show the switch state at the red leds
  LEDR <= SW;
  
  clk <= pllclk; 
  dat <= CLOCK_50;
  
--  sync3 <= dat when rising_edge(clk);
--  sync2 <= sync3 when rising_edge(clk);  
  sync <= dat when rising_edge(clk);
  
--  sync <= CLOCK_27; 

  r0 <= sync and SW(1) when rising_edge(clk);
  r1 <= sync and SW(0) when falling_edge(clk);

  inc <= r0 xor r1 when falling_edge(clk);
  
  LEDG(0) <= r0;
  LEDG(1) <= inc;

  count <= (others => '0') when KEY(0) = '0' else count + 1 when inc = '1' and falling_edge(clk); 

  LEDG(7 downto 2) <= std_ulogic_vector(count(5 downto 0));   
 
end architecture rtl;
