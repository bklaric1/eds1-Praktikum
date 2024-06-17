library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_vga_gen is
    port(clk        : in    std_ulogic;
         rst_n      : in    std_ulogic;
         r_o        : out   std_ulogic_vector(3 downto 0);
         g_o        : out   std_ulogic_vector(3 downto 0);
         b_o        : out   std_ulogic_vector(3 downto 0);
         hsync_o    : out   std_ulogic;
         vsync_o    : out   std_ulogic);
end entity;

architecture rtl of de1_vga_gen is

component clockengen is 
    port (
        clk         : in std_ulogic;
        rst_n       : in std_ulogic;
        en_o        : out std_ulogic);
end component;

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

    signal pixel_en, line_en : std_ulogic;
    signal pixel_cnt_o, line_cnt_o : std_ulogic_vector(9 downto 0);


begin

    clockengen_i0 : clockengen
    port map (
        clk     => clk;
        rst_n   => rst_n;
        en_o    => pixel_en 
    );


    line_cnt_i0 : line_cnt  
    port map(
        clk     => clk;
        rst_n   => rst_n;
        en      => line_en;
        cnt_o   => line_cnt_o;
    );  

    pixel_cnt_i0 : pixel_cnt
    port map(
        clk        => clk ;
        rst_n      => rst_n ;
        en_i       => pixel_en;
        cnt_o      => pixel_cnt_o;
        done_o     => line_en
    );

    hsync_gen_rtl_i0 : hsync_gen_rtl
    port map (
        clk       => clk ;
        rst_n     => rst_n ;
        pixel_cnt => pixel_cnt_o ;
        hsync     => hysnc_o
    );

    vsync_gen_rtl_i0 : vsync_gen_rtl
    port map (
        clk       => clk ;
        rst_n     => rst_n ;
        line_cnt  => line_cnt_o ;
        vsync     => vsnyx_o 
    );

    bild_gen_rtl_i0 : bild_gen_rtl
    port map (
        clk       => clk ;
        rst_n     => rst_n ;
        x         => pixel_cnt_o ;
        y         => line_cnt_o ;
        r         => r_o ;
        g         => g_o ;
        b         => b_o 
    );
    


end architecture rtl;
