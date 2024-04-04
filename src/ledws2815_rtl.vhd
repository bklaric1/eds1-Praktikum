library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ledws2815 is
  port (
    clk     : in std_ulogic;
    rst_n   : in std_ulogic;
    -- Data
    d_i     : in std_ulogic_vector(7 downto 0);
    led_o   : out std_ulogic; 
    -- Control signals
    dv_i    : in std_ulogic;
    done_o  : out std_ulogic);
end entity;

architecture rtl of ledws2815 is
  
  signal dreg : std_ulogic_vector(d_i'range);
  signal dreg_en : std_ulogic;
  signal current_bit : std_ulogic;
  
  constant last_cnt : integer := 64;
  signal cnt, ncnt : unsigned(6 downto 0);
  signal sres_cnt : std_ulogic;
  signal cnt_done : std_ulogic;
  
  signal bcnt, nbcnt : unsigned(2 downto 0);
  signal sres_bcnt, bcnt_en : std_ulogic;
  signal last_bit : std_ulogic;
  
  type state_t is (IDLE, RUN);
  signal cstate, nstate : state_t;
  
begin
  
  dreg <= (others => '0') when rst_n = '0' else
          d_i when rising_edge(clk) and dreg_en = '1';
  current_bit <= dreg(to_integer(bcnt));
  
  bcnt <= (others => '0') when rst_n = '0' else
          nbcnt when rising_edge(clk);
  nbcnt <= (others => '0') when sres_bcnt = '1' else
          bcnt + 1 when bcnt_en = '1' else bcnt;
  last_bit <= '1' when bcnt = 7 else '0';
  
  cnt <= to_unsigned(last_cnt,cnt'length) when rst_n = '0' else
         ncnt when rising_edge(clk);
  ncnt <= (others => '0') when sres_cnt = '1' else
         to_unsigned(last_cnt,cnt'length) when cnt = last_cnt else
         cnt + 1;
  cnt_done <= '1' when cnt = last_cnt else '0';
  
  led_o <= '0' when ((cnt >= 15 and current_bit = '0') or
                    (cnt >= 30 and current_bit = '1')) else '1';
        
  
  cstate <= IDLE when rst_n = '0' else nstate when rising_edge(clk);
  
  nstate_p : process(cstate, dv_i, cnt_done, last_bit)
  begin
    nstate <= cstate;
    sres_cnt <= '0';
    sres_bcnt <= '0';
    dreg_en <= '0';
    bcnt_en <= '0';
    done_o <= '0';
    case cstate is
    when IDLE =>
      if dv_i = '1' then
        nstate <= RUN;
        dreg_en <= '1';
        sres_cnt <= '1';
      end if;
    when RUN =>
      if cnt_done then
        if last_bit then
          if dv_i = '1' then
            dreg_en <= '1';
            sres_cnt <= '1';
          else  
            nstate <= IDLE;
          end if;
          done_o <= '1';
          sres_bcnt <= '1';
        else
          sres_cnt <= '1';
          bcnt_en <= '1';
        end if;
      end if;
    when others =>
    end case;
  end process;
  
  

end architecture rtl; 




