library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 

entity stringtx is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    strstart_i : in std_ulogic;
    start_o     : out std_ulogic;
    d_o           : out std_ulogic_vector(7 downto 0);
    done_i        : in std_ulogic);
end entity;

architecture rtl of stringtx is
  
  constant tx : string := "Hallo!";
  
  signal idx, idx_next : integer range 1 to tx'length;
  signal idx_inc : std_ulogic;

  -- State Machine
  type state_t is (IDLE_S, TX_S);
  signal cstate, nstate : state_t;

begin
  
  -- Index Counter
  idx <= 1 when rst_n = '0' else idx_next when rising_edge(clk);
  
  idx_next <= 1 when idx = tx'length and idx_inc = '1' else
              idx + 1 when idx_inc = '1' else idx;
  
  -- State Machine
  
  cstate <= IDLE_S when rst_n = '0' else nstate when rising_edge(clk);
  
  ns_p : process (cstate, done_i, strstart_i)
  begin
    idx_inc <= '0';
    start_o <= '0';
    nstate  <= cstate;
    case cstate is
    when IDLE_S =>
      if strstart_i = '1' then
        nstate <= TX_S;
        start_o <= '1';
        idx_inc <= '1';
      end if;
    when TX_S =>
      
    
    when others =>
    end case; 
  end process;
  
  -- Data Path
  
  d_o <= std_ulogic_vector(to_unsigned(character'pos(tx(idx)),8));
  
end architecture rtl; 




