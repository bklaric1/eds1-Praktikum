library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_uart is
  port ( CLOCK_50  : in  std_ulogic;
         KEY       : in  std_ulogic_vector(3 downto 0);
         UART_RXD  : in  std_ulogic;
         UART_TXD  : out std_ulogic;
         LEDR      : out std_ulogic_vector(9 downto 0));
end entity;

architecture rtl of de1_uart is

  component stringtx is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    strstart_i    : in std_ulogic;
    start_o       : out std_ulogic;
    d_o           : out std_ulogic_vector(7 downto 0);
    done_i        : in std_ulogic);
  end component;
  
  component uart_tx is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Data
    d_i     : in std_ulogic_vector(7 downto 0);
    ser_o   : out std_ulogic; 
    -- Control signals
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
  end component;

  signal rst_n, done, strstart, start : std_ulogic;
  signal d : std_ulogic_vector(7 downto 0);
  
begin

  rst_n <= KEY(0);
  strstart <= not KEY(1);

  stringtx_i0 : stringtx
    port map(
      clk   => CLOCK_50,
      rst_n => rst_n,
      strstart_i => strstart,
      start_o => start,
      d_o     => d,
      done_i  => done);

  uart_tx_i0 : uart_tx
    port map(
      clk   => CLOCK_50,
      rst_n => rst_n,
      start_i => start,
      done_o  => done,
      d_i     => d,
      ser_o   => UART_TXD);
  
end architecture rtl;
