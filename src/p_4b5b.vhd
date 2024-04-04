library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package p_4b5b is
  constant JK : std_ulogic_vector := "1100010001";
  constant TT : std_ulogic_vector := "0110101101";
  procedure search_JK (signal clk : in std_ulogic;
                       signal dat : in std_ulogic);
  procedure rx_byte_compare (signal clk : in std_ulogic;
                             signal dat : in std_ulogic;
                             constant refchar : in character);
end package;

package body p_4b5b is

  procedure search_JK (signal clk : in std_ulogic;
                       signal dat : in std_ulogic) is
    variable rx : std_ulogic_vector(9 downto 0) := (others => '0');
  begin
    while rx /= JK loop
      wait until falling_edge(clk);
      rx := rx(8 downto 0) & dat;
    end loop;
  end procedure;
  
  procedure rx_byte_compare (signal clk : in std_ulogic;
                             signal dat : in std_ulogic;
                             constant refchar : in character) is
    variable rx : std_ulogic_vector(9 downto 0) := (others => '0');
    variable ref4b5b : std_ulogic_vector(9 downto 0);
    constant ref : std_ulogic_vector := std_ulogic_vector(to_unsigned(character'pos(refchar),8));
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
  begin
    ref4b5b := conv4b5b_f(ref(7 downto 4)) & conv4b5b_f(ref(3 downto 0));
    for i in rx'range loop
      wait until falling_edge(clk);
      rx(i) := dat;
    end loop;
    assert rx = ref4b5b report "ERROR: Wrong Character received";
  end procedure;
  
end package body;

