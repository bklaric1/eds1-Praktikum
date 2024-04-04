library ieee;
use ieee.std_logic_1164.all;

entity blksm is
  port(
    clk       : in std_ulogic;
    rst_n     : in std_ulogic;
    ld_o      : out std_ulogic;
    led_o     : out std_ulogic_vector(3 downto 0);
    start_i   : in std_ulogic;
    done_i    : in std_ulogic);
end entity;

architecture rtl of blksm is
  type sm_t is (idle,blk1_load,blk1,blk2_load,blk2,blk3_load,blk3);
  signal cstate,nstate : sm_t;  
begin

  cstate <= idle when rst_n = '0' else nstate when rising_edge(clk);

  process(cstate,start_i,done_i)
  begin
    led_o <= "0000";
    ld_o  <= '0';
    nstate <= cstate;
    case cstate is
      when idle =>
        if start_i = '1' then
          nstate <= blk1_load;
        end if;
      when blk1_load =>
        nstate <= blk1;
        ld_o <= '1';
        led_o <= "1001";
      when blk1 =>
        led_o <= "1001";
        if done_i = '1' then
          nstate <= blk2_load;
        end if;
      when blk2_load =>
        nstate <= blk2;
        ld_o <= '1';
        led_o <= "0110";
      when blk2 =>
        led_o <= "0110";
        if done_i = '1' then
          nstate <= blk3_load;
        end if;
      when blk3_load =>
        nstate <= blk3;
        ld_o <= '1';
        led_o <= "1111";
      when blk3 =>
        led_o <= "1111";
        if done_i = '1' then
          if start_i = '1' then
            nstate <= blk1_load;
          else
            nstate <= idle;
          end if;
        end if;
      when others =>
        nstate <= idle;
      end case;
  end process;
  
end architecture;
