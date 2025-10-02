library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipe_tri_bus is
  port(
    enable : in std_logic;

    i_led_green_intensity : in std_logic_vector(7 downto 0) := "00000000";
    i_led_red_intensity : in std_logic_vector(7 downto 0) := "00000000";
    i_led_blue_intensity : in std_logic_vector(7 downto 0) := "00000000";

    d_led_green_intensity : in std_logic_vector(7 downto 0);
    d_led_red_intensity : in std_logic_vector(7 downto 0);
    d_led_blue_intensity : in std_logic_vector(7 downto 0);

    o_led_green_intensity : out std_logic_vector(7 downto 0);
    o_led_red_intensity : out std_logic_vector(7 downto 0);
    o_led_blue_intensity : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of pipe_tri_bus is
begin
  o_led_green_intensity <= d_led_green_intensity when enable = '1' else i_led_green_intensity; 
  o_led_red_intensity <= d_led_red_intensity when enable = '1' else i_led_red_intensity; 
  o_led_blue_intensity <= d_led_blue_intensity when enable = '1' else i_led_blue_intensity; 
end architecture;
