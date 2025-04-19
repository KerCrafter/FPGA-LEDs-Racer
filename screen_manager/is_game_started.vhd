library ieee;
use ieee.std_logic_1164.all;

entity is_game_started is
  generic (
    max_pos : integer := 109
  );

  port(
    is_in_menu : in std_logic;
    green_cur_pos : in integer range 0 to max_pos-1;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_cur_pos : in integer range 0 to max_pos-1;
    yellow_cur_pos : in integer range 0 to max_pos-1;
  
    result : out std_logic
  );
end entity;

architecture behaviour of is_game_started is
begin
  result <= '1' when is_in_menu = '0' and green_cur_pos < max_pos-1 and red_cur_pos < max_pos-1 and blue_cur_pos < max_pos-1 and yellow_cur_pos < max_pos-1 else '0';
end architecture;
