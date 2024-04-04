-- Type test file
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity sermul is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Datapath signals
    x_i     : in unsigned(4 downto 0);
    y_i     : in unsigned(4 downto 0); 
    res_o   : out unsigned(9 downto 0);
    -- Control signals
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
end entity;

architecture rtl of sermul is

    component sermuldp is
    port (
      clk     : in std_ulogic;
      rst_n   : in std_ulogic;
      ld_i    : in std_ulogic;
      store_i : in std_ulogic; 
      x_i     : in unsigned(4 downto 0);
      y_i     : in unsigned(4 downto 0); 
      res_o   : out unsigned(9 downto 0));
  end component;

component sermulctr is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    ld_o    : out std_ulogic;
    store_o : out std_ulogic;
    start_i : in std_ulogic;
    done_o  : out std_ulogic);
end component;

  signal ld, store : std_ulogic;

begin

  sermuldp_i0 : sermuldp
    port map (
      clk     => clk,
      rst_n   => rst_n,
      x_i     => x_i,
      y_i     => y_i,
      res_o   => res_o,
      ld_i    => ld,
      store_i => store); 

    sermulctr_i0 : sermulctr
      port map (
        clk     => clk,
        rst_n   => rst_n,
        start_i => start_i,
        done_o  => done_o,
        ld_o    => ld,
        store_o => store);
      
end architecture rtl; 




