library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.timer_pkg.all;

entity menu_manager is
  generic (
    MENU_TIMER_CLK_COUNT : integer
  );
  port (
    clk: in std_logic;

    green_ready_to_play: in std_logic;
    red_ready_to_play: in std_logic;
    blue_ready_to_play: in std_logic;
    yellow_ready_to_play: in std_logic;

    opt_with_menu: in std_logic;

    is_in_menu: out std_logic;
    countdown: buffer integer range 0 to 7
  );
end entity;

architecture structural of menu_manager is
  signal trigger_countdown : std_logic;
  signal countdown_finished : std_logic := '0';

  signal menu_timer_tick : std_logic;
begin

  ready_trigger_countdown: entity work.ready_trigger_countdown
    port map (
      green_ready_to_play => green_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,
    
      result => trigger_countdown
    );

  menu_timer: entity work.timer
    generic map(
      CLK_COUNT => MENU_TIMER_CLK_COUNT
    )
    port map(
      clk => clk,
      enable => trigger_countdown,
      tick => menu_timer_tick
    );

  process(menu_timer_tick)
  begin
    if rising_edge(menu_timer_tick) then
      if countdown = 0 then
        countdown <= 7;
      elsif countdown = 1 then
        countdown_finished <= '1';
      else
        countdown <= countdown - 1;
      end if;
    end if;

  end process;

  is_in_menu <= '1' when opt_with_menu and not countdown_finished else '0';

end architecture;
