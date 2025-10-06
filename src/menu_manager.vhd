library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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

    reset: in std_logic;

    is_in_menu: out std_logic;
    countdown: buffer integer range 0 to 7;
    activity: out std_logic
  );
end entity;

architecture structural of menu_manager is
  signal trigger_countdown : std_logic;
  signal countdown_finished : std_logic := '0';

  signal menu_timer_tick : std_logic;

  type state_t is (WAIT_INTERACT, WHEN_RESET, WHEN_TIMER_TICK);
  signal state : state_t := WAIT_INTERACT;
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

  process(clk)
  begin
    if rising_edge(clk) then
      case state is
        when WAIT_INTERACT =>
          if menu_timer_tick = '1' then
            state <= WHEN_TIMER_TICK;
          end if;

          if reset = '1' then
            state <= WHEN_RESET;
          end if;

        when WHEN_TIMER_TICK =>
          state <= WAIT_INTERACT;

          if countdown = 0 then
            countdown <= 7;
          elsif countdown = 1 then
            countdown_finished <= '1';
          else
            countdown <= countdown - 1;
          end if;

        when WHEN_RESET =>
          state <= WAIT_INTERACT;

          countdown <= 0;
          countdown_finished <= '0';
      end case;
    end if;
  end process;

  is_in_menu <= '1' when countdown_finished = '0' else '0';
  activity <= menu_timer_tick;

end architecture;
