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
  game_finished_screen <= '1' when green_cur_pos = max_pos-1 or red_cur_pos = max_pos-1 or blue_cur_pos = max_pos-1 or yellow_cur_pos = max_pos-1 else '0';
  game_in_progress_screen <= '1' when green_cur_pos < max_pos-1 and red_cur_pos < max_pos-1 and blue_cur_pos < max_pos-1 and yellow_cur_pos < max_pos-1 else '0';
end architecture;
