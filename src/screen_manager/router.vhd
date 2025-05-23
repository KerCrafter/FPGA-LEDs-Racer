library ieee;
use ieee.std_logic_1164.all;

entity router is
  generic (
    max_pos : integer := 109
  );

  port(
    green_cur_pos : in integer range 0 to max_pos-1;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_cur_pos : in integer range 0 to max_pos-1;
    yellow_cur_pos : in integer range 0 to max_pos-1;

    is_in_menu : in std_logic;
  
    current_screen : out std_logic_vector(1 downto 0)
  );
end entity;

architecture structural of router is
  signal menu_screen : std_logic := '0';
  signal game_in_progress_screen : std_logic := '1';
  signal game_finished_screen : std_logic := '0';
begin
  is_game_finished : entity work.is_game_finished
    generic map(max_pos => max_pos)
    port map (
      is_in_menu => is_in_menu,
      green_cur_pos => green_cur_pos,
      red_cur_pos => red_cur_pos,
      blue_cur_pos => blue_cur_pos,
      yellow_cur_pos => yellow_cur_pos,

      result => game_finished_screen
    );

  is_game_started : entity work.is_game_started
    generic map(max_pos => max_pos)
    port map (
      is_in_menu => is_in_menu,
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
