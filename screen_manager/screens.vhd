library ieee;
use ieee.std_logic_1164.all;

entity screens is
  generic (
    max_pos : integer := 109
  );

  port(
    clk : in std_logic;

    green_ready_to_play : in std_logic;
    green_cur_pos : in integer range 0 to max_pos-1;
    red_ready_to_play : in std_logic;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_ready_to_play : in std_logic;
    blue_cur_pos : in integer range 0 to max_pos-1;
    yellow_ready_to_play : in std_logic;
    yellow_cur_pos : in integer range 0 to max_pos-1;
  
    current_led : in integer range 0 to max_pos-1;
    led_green_intensity : out std_logic_vector(7 downto 0);
    led_red_intensity : out std_logic_vector(7 downto 0);
    led_blue_intensity : out std_logic_vector(7 downto 0)
  );
end entity;

architecture structural of screens is
begin


end architecture;
