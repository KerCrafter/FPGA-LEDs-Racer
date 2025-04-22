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

architecture structural of menu_manager is
  signal trigger_countdown : std_logic;
begin

  ready_trigger_countdown: entity work.ready_trigger_countdown
    port map (
      green_ready_to_play => green_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,
    
      result => trigger_countdown
    );

  is_in_menu <= '0';

end architecture;
