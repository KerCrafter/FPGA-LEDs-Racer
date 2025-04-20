library ieee;
use ieee.std_logic_1164.all;

entity screen_manager is
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
  
    menu_screen : buffer std_logic := '0';
    game_in_progress_screen : buffer std_logic := '1';
    game_finished_screen : buffer std_logic := '0';
    current_screen : out std_logic_vector(1 downto 0)
  );
end entity;

architecture structural of screen_manager is
begin

  is_in_menu: entity work.is_in_menu
    port map (
      clk => clk,

      green_ready_to_play => green_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,

      result => menu_screen
    );

  is_game_finished : entity work.is_game_finished
    generic map(max_pos => max_pos)
    port map (
      is_in_menu => menu_screen,
      green_cur_pos => green_cur_pos,
      red_cur_pos => red_cur_pos,
      blue_cur_pos => blue_cur_pos,
      yellow_cur_pos => yellow_cur_pos,

      result => game_finished_screen
    );

  is_game_started : entity work.is_game_started
    generic map(max_pos => max_pos)
    port map (
      is_in_menu => menu_screen,
      green_cur_pos => green_cur_pos,
      red_cur_pos => red_cur_pos,
      blue_cur_pos => blue_cur_pos,
      yellow_cur_pos => yellow_cur_pos,

      result => game_in_progress_screen
    );

  current_screen <= "00" when menu_screen = '1' else
                    "01" when game_in_progress_screen = '1' else
                    "10" when game_finished_screen = '1' else
                    "11";

end architecture;
