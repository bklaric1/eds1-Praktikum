library ieee;
use ieee.std_logic_1164.all; 

entity uart_tx is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Data
    d_i     : in std_ulogic_vector(7 downto 0);
    ser_o   : out std_ulogic; 
    -- Control signals
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
end entity;

architecture rtl of uart_tx is

  component uart_shiftreg_tx is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_i    : in std_ulogic;
    shift_i : in std_ulogic; 
    d_i     : in std_ulogic_vector(7 downto 0);
    ser_o   : out std_ulogic);
  end component;
  
  signal sr_ld, sr_shift : std_ulogic;

begin

  uart_shiftreg_tx_i0 : uart_shiftreg_tx
    port map (
      clk     => clk,
      rst_n   => rst_n,
      ld_i    => sr_ld,
      shift_i => sr_shift,
      ser_o   => ser_o,
      d_i     => d_i); 

end architecture rtl; 




