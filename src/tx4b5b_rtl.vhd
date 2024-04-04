library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tx4b5b is
port (
  clk       : in std_ulogic;
  rst_n     : in std_ulogic;
  ld_data_i : in std_ulogic;
  d_i       : in std_ulogic_vector(7 downto 0);
  ser_o     : out std_ulogic;
  done_o    : out std_ulogic);
end entity;

architecture rtl of tx4b5b is

  type state_t is (IDLE, JK, TT, DAT);
  signal state, newstate : state_t;

  signal cnt, cntnew : integer range 0 to 9;
  signal cnt_load, cnt_done, cnt_last : std_ulogic;
  signal sr, srnew  : std_ulogic_vector(9 downto 0);

  function conv4b5b_f (x : std_ulogic_vector) return std_ulogic_vector is
  begin
    case x is
      when "0000" => return "11110";
      when "0001" => return "01001";
      when "0010" => return "10100";
      when "0011" => return "10101";
      when "0100" => return "01010";
      when "0101" => return "01011";
      when "0110" => return "01110";
      when "0111" => return "01111";
      when "1000" => return "10010";
      when "1001" => return "10011";
      when "1010" => return "10110";
      when "1011" => return "10111";
      when "1100" => return "11010";
      when "1101" => return "11011";
      when "1110" => return "11100";
      when "1111" => return "11101";
      when others => return "XXXXX";
     end case;
  end function;

  signal sr_load_data, sr_load_jk, sr_load_tt : std_ulogic;

begin

  -- Shift register
  sr <= (others => '1') when rst_n = '0' else srnew when rising_edge(clk);
  srnew <= conv4b5b_f(d_i(7 downto 4)) & conv4b5b_f(d_i(3 downto 0)) when sr_load_data = '1' else
           "1100010001" when sr_load_jk = '1' else
           "0110101101" when sr_load_tt = '1' else
           sr(8 downto 0) & '1';
  ser_o <= sr(9);

  -- Bit counter
  cnt <= 0 when rst_n = '0' else cntnew when rising_edge(clk);
  cntnew <= 9 when cnt_load = '1' else
            0 when cnt = 0 else
            cnt - 1;
  cnt_done <= '1' when cnt = 0 else '0';
  cnt_last <= '1' when cnt = 1 else '0';

  -- State Machine
  state <= IDLE when rst_n = '0' else newstate when rising_edge(clk);
  process(state, cnt_done, cnt_last, ld_data_i)
  begin
    newstate <= state;
    done_o <= '0';
    cnt_load <= '0';
    sr_load_data <= '0';
    sr_load_jk <= '0';
    sr_load_tt <= '0';
    case state is
      when IDLE =>
        if ld_data_i = '1' then
          newstate <= JK;
          cnt_load <= '1';
          sr_load_jk <= '1';
        end if;
      when JK =>
        if cnt_done = '1' then
          newstate <= DAT;
          cnt_load <= '1';
          sr_load_data <= '1';
        end if;
      when DAT =>
        if cnt_last = '1' then
          done_o <= '1';
        end if;
        if cnt_done = '1' then
          if ld_data_i = '1' then
            sr_load_data <= '1';
          else
            newstate <= TT;
            sr_load_tt <= '1';                
          end if;   
          cnt_load <= '1';
        end if;
      when TT =>
        if cnt_done = '1' then
          newstate <= IDLE;
        end if;
    end case;   
  end process;

end architecture;
