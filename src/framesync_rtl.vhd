library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity framesync is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    start_i : in std_ulogic;
    ser_o   : out std_ulogic;
    done_o  : out std_ulogic);
end entity;

architecture rtl of framesync is

  signal ld_data, done : std_ulogic;
  signal d : std_ulogic_vector(7 downto 0);

begin

  tx4b5b_i0 : entity work.tx4b5b(rtl)
    port map (
      clk   => clk,
      rst_n => rst_n,
      ld_data_i => ld_data,
      done_o    => done,
      d_i       => d,
      ser_o     => ser_o);
  
  stringtx_i0 : entity work.stringtx(rtl)
    port map (
      clk   => clk,
      rst_n => rst_n,
      start_i   => start_i,
      ld_data_o => ld_data,
      done_i    => done,
      d_o       => d);
      
end architecture rtl; 




