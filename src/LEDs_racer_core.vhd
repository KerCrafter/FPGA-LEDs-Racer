library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_core is
  generic (
    max_pos : integer := 16
  );

  port(
    clk : in std_logic;
    
    green_input : in std_logic;
    red_input : in std_logic;
    blue_input : in std_logic;
    yellow_input : in std_logic;
    
    current_led : in integer range 0 to max_pos-1;
    led_green_intensity : out std_logic_vector(7 downto 0);
    led_red_intensity : out std_logic_vector(7 downto 0);
    led_blue_intensity : out std_logic_vector(7 downto 0);
    update_frame : out std_logic
    
  );
end entity;

architecture structural of LEDs_racer_core is
  signal red_ready_to_play : std_logic;
  signal red_cur_pos : integer range 0 to max_pos-1;
  signal blue_ready_to_play : std_logic;
  signal blue_cur_pos : integer range 0 to max_pos-1;
  signal green_ready_to_play : std_logic;
  signal green_cur_pos : integer range 0 to max_pos-1;
  signal yellow_ready_to_play : std_logic;
  signal yellow_cur_pos : integer range 0 to max_pos-1;
  
  signal red_activity : std_logic;
  signal blue_activity : std_logic;
  signal green_activity : std_logic;
  signal yellow_activity : std_logic;

  signal current_screen : std_logic_vector(1 downto 0);
  signal is_in_menu : std_logic;

begin
  red_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      btn => red_input,
      cur_pos => red_cur_pos,
      activity => red_activity,
      current_screen => current_screen,
      ready_to_play => red_ready_to_play
    );
  
  blue_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      btn => blue_input,
      cur_pos => blue_cur_pos,
      activity => blue_activity,
      current_screen => current_screen,
      ready_to_play => blue_ready_to_play
    );
  
  green_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      btn => green_input,
      cur_pos => green_cur_pos,
      activity => green_activity,
      current_screen => current_screen,
      ready_to_play => green_ready_to_play
    );
  
  yellow_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      btn => yellow_input,
      cur_pos => yellow_cur_pos,
      activity => yellow_activity,
      current_screen => current_screen,
      ready_to_play => yellow_ready_to_play
    );

  menu_manager: entity work.menu_manager
    port map (
      clk => clk,
      green_ready_to_play => green_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,

      is_in_menu => is_in_menu
    );

  
  activity_detector: entity work.activity_detector port map(
    A => green_activity,
    B => red_activity,
    C => blue_activity,
    D => yellow_activity,
    
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
    
      current_led => current_led,
      led_green_intensity => led_green_intensity,
      led_red_intensity => led_red_intensity,
      led_blue_intensity => led_blue_intensity
    );

end architecture;
