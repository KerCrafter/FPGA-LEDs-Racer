library ieee;
use ieee.std_logic_1164.all;

entity screen_manager is
  generic (
    max_pos : integer := 109
  );

  port(
    green_ready_to_play : in std_logic;
    green_cur_pos : in integer range 0 to max_pos-1;
    red_ready_to_play : in std_logic;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_ready_to_play : in std_logic;
    blue_cur_pos : in integer range 0 to max_pos-1;
    yellow_ready_to_play : in std_logic;
    yellow_cur_pos : in integer range 0 to max_pos-1;

    is_in_menu : in std_logic;

    current_led : in integer range 0 to max_pos-1;
  
    current_screen : buffer std_logic_vector(1 downto 0);

    led_green_intensity : out std_logic_vector(7 downto 0);
    led_red_intensity : out std_logic_vector(7 downto 0);
    led_blue_intensity : out std_logic_vector(7 downto 0)
  );
end entity;

architecture structural of screen_manager is
begin

  router: entity work.router
    generic map(max_pos => max_pos)
    port map (
      green_cur_pos => green_cur_pos,
      red_cur_pos => red_cur_pos,
      blue_cur_pos => blue_cur_pos,
      yellow_cur_pos => yellow_cur_pos,

      is_in_menu => is_in_menu,
    
      current_screen => current_screen
    );

  screens: entity work.screens
    generic map(max_pos => max_pos)
    port map (
      green_ready_to_play => green_ready_to_play,
      green_cur_pos => green_cur_pos,
      red_ready_to_play => red_ready_to_play,
      red_cur_pos => red_cur_pos,
      blue_ready_to_play => blue_ready_to_play,
      blue_cur_pos => blue_cur_pos,
      yellow_ready_to_play => yellow_ready_to_play,
      yellow_cur_pos => yellow_cur_pos,
    
      current_led => current_led,

      current_screen => current_screen,

      led_green_intensity => led_green_intensity,
      led_red_intensity => led_red_intensity,
      led_blue_intensity => led_blue_intensity
    );

end architecture;
