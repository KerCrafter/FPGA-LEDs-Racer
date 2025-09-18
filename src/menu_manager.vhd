library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.timer_pkg.all;

entity menu_manager is
  port (
    clk: in std_logic;

    green_ready_to_play: in std_logic;
    red_ready_to_play: in std_logic;
    blue_ready_to_play: in std_logic;
    yellow_ready_to_play: in std_logic;

    opt_with_menu: in std_logic;

    is_in_menu: out std_logic;
    countdown: out integer range 0 to 7;
    menu_timer: inout t_TIMER
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

  is_in_menu <= opt_with_menu;

  process(menu_timer.tick)
  begin
    if rising_edge(menu_timer.tick) then
      if countdown = 0 then
        countdown <= 7;
      end if;
    end if;

  end process;

  menu_timer.enable <= trigger_countdown;

end architecture;
