library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_unit is
  generic (
    max_pos : integer
  );

  port (
    clk : in std_logic;

    current_led : in integer range 0 to max_pos-1;

    red_ready_to_play : in std_logic;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_ready_to_play : in std_logic;
    blue_cur_pos : in integer range 0 to max_pos-1;
    green_ready_to_play : in std_logic;
    green_cur_pos : in integer range 0 to max_pos-1;
    yellow_ready_to_play : in std_logic;
    yellow_cur_pos : in integer range 0 to max_pos-1;
  
    red_activity : in std_logic;
    blue_activity : in std_logic;
    green_activity : in std_logic;
    yellow_activity : in std_logic;
    menu_activity : in std_logic;

    is_in_menu : in std_logic;
    countdown : in integer range 0 to 7;
    reset_all : in std_logic;

    current_screen : out std_logic_vector(1 downto 0); 

    led_green_intensity : out std_logic_vector(7 downto 0);
    led_red_intensity : out std_logic_vector(7 downto 0);
    led_blue_intensity : out std_logic_vector(7 downto 0);
    update_frame : out std_logic
  );
end entity;

architecture structural of display_unit is
begin

  activity_detector: entity work.activity_detector port map(
    clk => clk,
    A => green_activity,
    B => red_activity,
    C => blue_activity,
    D => yellow_activity,
    E => menu_activity,
    F => reset_all,
    
    R => update_frame
  );
  
  screen_manager: entity work.screen_manager
    generic map(max_pos => max_pos)
    port map(
      current_screen => current_screen,

      green_ready_to_play => green_ready_to_play,
      green_cur_pos => green_cur_pos,

      red_ready_to_play => red_ready_to_play,
      red_cur_pos => red_cur_pos,

      blue_ready_to_play => blue_ready_to_play,
      blue_cur_pos => blue_cur_pos,

      yellow_ready_to_play => yellow_ready_to_play,
      yellow_cur_pos => yellow_cur_pos,

      is_in_menu => is_in_menu,
      countdown => countdown,
    
      current_led => current_led,
      led_green_intensity => led_green_intensity,
      led_red_intensity => led_red_intensity,
      led_blue_intensity => led_blue_intensity
    );

end architecture;
