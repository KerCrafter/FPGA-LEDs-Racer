library ieee;
use ieee.std_logic_1164.all;

entity menu_manager is
  port (
    clk: in std_logic;
    green_ready_to_play: in std_logic;
    red_ready_to_play: in std_logic;
    blue_ready_to_play: in std_logic;
    yellow_ready_to_play: in std_logic;

    is_in_menu: out std_logic
  );
end entity;

architecture beh of menu_manager is
begin
  is_in_menu <= '0';
end architecture;
