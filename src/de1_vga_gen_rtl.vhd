library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_vga_gen is
    port(clk    : in    std_ulogic;
         rst_n  : in    std_ulogic;
         r_o    : out   std_ulogic_vector(3 downto 0);
         g_o    : out   std_ulogic_vector(3 downto 0);
         b_o    : out   std_ulogic_vector(3 downto 0);
         hsync  : out   std_ulogic;
         vsync  : out   std_ulogic);
end entity;

architecture rtl of de1_vga_gen is

component line_cnt is
    port (clk       : in  std_ulogic;
          rst_n     : in  std_ulogic;
          en        : in  std_ulogic;
          cnt_o     : out std_ulogic_vector(9 downto 0));
end component;

component pixel_cnt is
    port(clk        : in    std_ulogic;
         rst_n      : in    std_ulogic;
         en_i       : in    std_ulogic;
         cnt_o      : out   std_ulogic_vector(9 downto 0);
         done_o     : out   std_ulogic);
end component;

component hsync_gen_rtl is
    port (clk       : in  std_ulogic;
          rst_n     : in  std_ulogic;
          pixel_cnt : in  std_ulogic_vector(9 downto 0);
          hsync     : out std_ulogic);
end component;

component vsync_gen_rtl is
    port (clk       : in  std_ulogic;
          rst_n     : in  std_ulogic;
          line_cnt  : in  std_ulogic_vector(9 downto 0);
          vsync     : out std_ulogic);
end component;

component bild_gen_rtl is
    port (clk       : in  std_ulogic;
    rst_n     : in  std_ulogic;
    x         : in  std_ulogic_vector(9 downto 0);
    y         : in  std_ulogic_vector(9 downto 0);
    r         : out std_ulogic;
    g         : out std_ulogic;
    b         : out std_ulogic);
end component;

begin

    line_cnt_i0 : line_cnt  
    port map(
        clk     => clk;
        rst_n   => rst_n;
        en      => ;
        cnt_o   => ;
    );  

    pixel_cnt_i0 : pixel_cnt
    port map(
        clk        => clk ;
        rst_n      => rst_n ;
        en_i       : ;
        cnt_o      : ;
        done_o     : 
    );

    hsync_gen_rtl_i0 : hsync_gen_rtl
    port map (
        clk       => clk ;
        rst_n     => rst_n ;
        pixel_cnt : ;
        hsync     : 
    );

    vsync_gen_rtl_i0 : vsync_gen_rtl
    port map (
        clk       => clk ;
        rst_n     => rst_n ;
        line_cnt  : ;
        vsync     : 
    );

    bild_gen_rtl_i0 : bild_gen_rtl
    port map (
        clk       => clk ;
        rst_n     => rst_n ;
        x         : ;
        y         : ;
        r         : ;
        g         : ;
        b         : 
    );
    


end architecture rtl;
