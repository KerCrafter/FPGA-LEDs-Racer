library ieee;
use ieee.std_logic_1164.all;

entity end_game_logics is
  generic (
    END_TIMER_CLK_COUNT : integer
  );

  port(
    clk : in std_logic;
    current_screen : in std_logic_vector(1 downto 0);

    trigger_reset_all : out std_logic
  );
end entity;

architecture rtl of end_game_logics is
  signal end_timer_enable : std_logic;
begin

  TIMER: entity work.timer
    generic map(
      CLK_COUNT => END_TIMER_CLK_COUNT,
      FIRST_TICK_AFTER_DELAY => true
    )
    port map(
      clk => clk,
      enable => end_timer_enable,
      tick => trigger_reset_all
    );

  end_timer_enable <= '1' when current_screen = "10" else '0';

end architecture;
