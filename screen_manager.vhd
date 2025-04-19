library ieee;
use ieee.std_logic_1164.all;

entity is_game_finished is
  generic (
    max_pos : integer := 109
  );

  port(
    green_cur_pos : in integer range 0 to max_pos-1;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_cur_pos : in integer range 0 to max_pos-1;
    yellow_cur_pos : in integer range 0 to max_pos-1;
  
    result : out std_logic
  );
end entity;

architecture behaviour of is_game_finished is
begin
  result <= '1' when green_cur_pos = max_pos-1 or red_cur_pos = max_pos-1 or blue_cur_pos = max_pos-1 or yellow_cur_pos = max_pos-1 else '0';
end architecture;




library ieee;
use ieee.std_logic_1164.all;

entity screen_manager is
  generic (
    max_pos : integer := 109
  );

  port(
    green_cur_pos : in integer range 0 to max_pos-1;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_cur_pos : in integer range 0 to max_pos-1;
    yellow_cur_pos : in integer range 0 to max_pos-1;
  
    menu_screen : out std_logic := '0';
    game_in_progress_screen : out std_logic := '1';
    game_finished_screen : out std_logic := '0'
  );
end entity;

architecture behaviour of screen_manager is
begin

  is_game_finished : entity work.is_game_finished
    generic map(max_pos => max_pos)
    port map (
      green_cur_pos => green_cur_pos,
      red_cur_pos => red_cur_pos,
      blue_cur_pos => blue_cur_pos,
      yellow_cur_pos => yellow_cur_pos,

      result => game_finished_screen
    );

  game_in_progress_screen <= '1' when green_cur_pos < max_pos-1 and red_cur_pos < max_pos-1 and blue_cur_pos < max_pos-1 and yellow_cur_pos < max_pos-1 else '0';
end architecture;
