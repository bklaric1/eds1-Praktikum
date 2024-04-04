library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Altera Cyclone II Dual Ported RAM
-- * Synchronous RAM with one clock
-- * Read during Write on same port gives NEW data
-- * Read on one port with Write on other port with
--   the same address gives UNDEFINED data.
-- * Write to same address  on both ports with
--   different data results in undefined data in mem as
--   the two processes have no defined execution sequence

entity dpmem is
  port (
    clk     : in std_ulogic;
    d_i     : in std_ulogic_vector(7 downto 0);
    a_i     : in std_ulogic_vector(2 downto 0);
    we_i    : in std_ulogic;
    d_o     : out std_ulogic_vector(7 downto 0);
    d2_i    : in std_ulogic_vector(7 downto 0);
    a2_i    : in std_ulogic_vector(2 downto 0);
    we2_i   : in std_ulogic;
    d2_o    : out std_ulogic_vector(7 downto 0));
end entity;

architecture rtl of dpmem is
  type mem_t is array (0 to 2**a_i'length-1) of std_ulogic_vector(7 downto 0);
  shared variable mem : mem_t;
  signal d, d2: std_ulogic_vector(d_i'range);
  signal a, a2 : integer range 0 to 2**a_i'length-1;
begin

  a <= to_integer(unsigned(a_i));
  mem_p : process (clk)
    begin
      if rising_edge(clk) then
        if we_i = '1' then
          if ((we2_i = '0') or (a /= a2)) then
            mem(a) := d_i;
          else
            assert false report
            "Write to same address on both ports";
            mem(a) := "UUUUUUUU";
          end if;
        end if;
        if ((we2_i = '1') and (a = a2)) then
          d <= "UUUUUUUU";
        else
          d <= mem(a);
        end if;
      end if;
    end process;
  d_o <= d;

  a2 <= to_integer(unsigned(a2_i));
  mem2_p : process (clk)
    begin
      if rising_edge(clk) then
        if we2_i = '1' then
          if ((we_i = '0') or (a /= a2)) then
            mem(a2) := d2_i;
			 else
			   mem(a2) := "UUUUUUUU";
          end if;
        end if;
        if ((we_i = '1') and (a = a2)) then
          d2 <= "UUUUUUUU";
        else
          d2 <= mem(a2);
        end if;
      end if;
    end process;
  d2_o <= d2;

end architecture rtl;
