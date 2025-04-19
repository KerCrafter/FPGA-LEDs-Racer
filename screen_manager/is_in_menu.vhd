library ieee;
use ieee.std_logic_1164.all;

entity is_in_menu is
  port(
    green_ready_to_play : in std_logic;
    red_ready_to_play : in std_logic;
    blue_ready_to_play : in std_logic;
    yellow_ready_to_play : in std_logic;
  
    result : out std_logic
  );
end entity;

architecture behaviour of is_in_menu is
begin
  result <= '0';
end architecture;
