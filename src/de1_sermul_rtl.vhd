library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_sermul is
  port (SW    : in  std_ulogic_vector(9 downto 0);
         KEY  : in  std_ulogic_vector(3 downto 0);
         HEX0 : out std_ulogic_vector(6 downto 0);
         HEX1 : out std_ulogic_vector(6 downto 0);
         HEX2 : out std_ulogic_vector(6 downto 0);
         HEX3 : out std_ulogic_vector(6 downto 0);
         LEDG : out std_ulogic_vector(7 downto 0);
         LEDR : out std_ulogic_vector(9 downto 0));
end entity;

architecture rtl of de1_sermul is

  component bin2bcd is
    port (clk     : in  std_ulogic;
          rst_n   : in  std_ulogic;
          start_i : in  std_ulogic;
          done_o  : out std_ulogic; 
          bin_i   : in  unsigned(9 downto 0);
          bcd0_o  : out unsigned(3 downto 0);
          bcd1_o  : out unsigned(3 downto 0);
          bcd2_o  : out unsigned(3 downto 0);
          bcd3_o  : out unsigned(3 downto 0));  
  end component;
  
  component bin2seg is
    port (bin_i  : in  std_ulogic_vector(3 downto 0);
           seg_o : out std_ulogic_vector(6 downto 0));  
  end component;

  component sermul is
    port (
      clk     : in  std_ulogic;
      rst_n   : in  std_ulogic;
      -- Datapath signals
      x_i     : in  unsigned(4 downto 0);
      y_i     : in  unsigned(4 downto 0);
      res_o   : out unsigned(9 downto 0);
      -- Control signals
      start_i : in  std_ulogic;
      done_o  : out std_ulogic);
  end component;

  signal res : unsigned(9 downto 0);
  signal mul_done : std_ulogic;

  signal z0, z1, z2, z3: unsigned(3 downto 0);
  
begin
  
  sermul_i0 : sermul
    port map (
      clk     => KEY(1),
      rst_n   => KEY(0),
      x_i     => unsigned(SW(4 downto 0)),
      y_i     => unsigned(SW(9 downto 5)),
      res_o   => res,
      start_i => KEY(2),
      done_o  => mul_done);

  bin2bcd_i0 : bin2bcd
    port map (
      clk     => KEY(1), 
      rst_n   => KEY(0),
      start_i => mul_done,
      done_o  => LEDG(5),
      bin_i   => res,
      bcd0_o  => z0,
      bcd1_o  => z1,
      bcd2_o  => z2,
      bcd3_o  => z3);

  LEDR <= std_ulogic_vector(res);
  LEDG(3 downto 0) <= KEY;
  LEDG(4) <= mul_done; 
 
  bin2seg_i0 : bin2seg
    port map (
      bin_i => std_ulogic_vector(z0),
      seg_o => HEX0);

  bin2seg_i1 : bin2seg
    port map (
      bin_i => std_ulogic_vector(z1),
      seg_o => HEX1);

  bin2seg_i2 : bin2seg
    port map (
      bin_i => std_ulogic_vector(z2),
      seg_o => HEX2);

  bin2seg_i3 : bin2seg
    port map (
      bin_i => std_ulogic_vector(z3),
      seg_o => HEX3);

end architecture rtl;
