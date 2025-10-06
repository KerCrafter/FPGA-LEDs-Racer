library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.players_commands_pkg.all;

entity LEDs_racer_core is
  generic (
    max_pos : integer := 16;
    MENU_TIMER_CLK_COUNT : integer := 50000000; -- with 50Mhz = 1 second
    END_TIMER_CLK_COUNT : integer := 750000000 -- with 50Mhz = 15 seconds
  );

  port(
    clk : in std_logic;

    players_commands : in t_PLAYERS_COMMANDS;
    
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
  signal menu_activity : std_logic;

  signal current_screen : std_logic_vector(1 downto 0);
  signal is_in_menu : std_logic;
  signal countdown : integer range 0 to 7;

  signal end_timer_enable : std_logic;
  signal reset_all : std_logic;
begin
  red_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      clk => clk,
      btn => players_commands.red,
      cur_pos => red_cur_pos,
      activity => red_activity,
      current_screen => current_screen,
      ready_to_play => red_ready_to_play,
      reset => reset_all
    );
  
  blue_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      clk => clk,
      btn => players_commands.blue,
      cur_pos => blue_cur_pos,
      activity => blue_activity,
      current_screen => current_screen,
      ready_to_play => blue_ready_to_play,
      reset => reset_all
    );
  
  green_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      clk => clk,
      btn => players_commands.green,
      cur_pos => green_cur_pos,
      activity => green_activity,
      current_screen => current_screen,
      ready_to_play => green_ready_to_play,
      reset => reset_all
    );
  
  yellow_btn: entity work.player_button
    generic map(max_pos => max_pos)
    port map (
      clk => clk,
      btn => players_commands.yellow,
      cur_pos => yellow_cur_pos,
      activity => yellow_activity,
      current_screen => current_screen,
      ready_to_play => yellow_ready_to_play,
      reset => reset_all
    );

  menu_manager: entity work.menu_manager
    generic map(
      MENU_TIMER_CLK_COUNT => MENU_TIMER_CLK_COUNT
    )
    port map (
      clk => clk,
      green_ready_to_play => green_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,

      reset => reset_all,

      is_in_menu => is_in_menu,
      countdown => countdown,
      activity => menu_activity
    );

  end_timer: entity work.timer
    generic map(
      CLK_COUNT => END_TIMER_CLK_COUNT,
      FIRST_TICK_AFTER_DELAY => true
    )
    port map(
      clk => clk,
      enable => end_timer_enable,
      tick => reset_all
    );
  
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

  end_timer_enable <= '1' when current_screen = "10" else '0';

end architecture;
