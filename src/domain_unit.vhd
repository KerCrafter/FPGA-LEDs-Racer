library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.players_commands_pkg.all;

entity domain_unit is
  generic (
    max_pos : integer := 16;
    MENU_TIMER_CLK_COUNT : integer;
    END_TIMER_CLK_COUNT : integer
  );

  port(
    clk : in std_logic;

    players_commands : in t_PLAYERS_COMMANDS;

    current_screen : in std_logic_vector(1 downto 0);

    red_ready_to_play : buffer std_logic;
    red_cur_pos : out integer range 0 to max_pos-1;
    blue_ready_to_play : buffer std_logic;
    blue_cur_pos : out integer range 0 to max_pos-1;
    green_ready_to_play : buffer std_logic;
    green_cur_pos : out integer range 0 to max_pos-1;
    yellow_ready_to_play : buffer std_logic;
    yellow_cur_pos : out integer range 0 to max_pos-1;
  
    red_activity : out std_logic;
    blue_activity : out std_logic;
    green_activity : out std_logic;
    yellow_activity : out std_logic;
    menu_activity : out std_logic;

    is_in_menu : out std_logic;
    countdown : out integer range 0 to 7;
    reset_all : buffer std_logic
  );
end entity;

architecture structural of domain_unit is
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

  end_game_logics : entity work.end_game_logics
    generic map(END_TIMER_CLK_COUNT => END_TIMER_CLK_COUNT)
    port map(
      clk => clk,
      current_screen => current_screen,
      trigger_reset_all => reset_all
    );

end architecture;
