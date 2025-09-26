library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.players_commands_pkg.all;
use work.timer_pkg.all;


entity LEDs_racer_main is
  generic (
    max_pos : integer := 109;
    debounce_clk_cnt : integer := 65536
  );

  port(
    clk : in std_logic;
    green_input : in std_logic;
    red_input : in std_logic;
    blue_input : in std_logic;
    yellow_input : in std_logic;

    leds_line : out std_logic
  );
end entity;

architecture structural of LEDs_racer_main is
  signal led_proceed : integer range 0 to max_pos-1;
  
  signal update_frame : std_logic;
  
  signal red_intensity : std_logic_vector(7 downto 0);
  signal blue_intensity : std_logic_vector(7 downto 0);
  signal green_intensity : std_logic_vector(7 downto 0);

  signal players_commands : t_PLAYERS_COMMANDS;
  signal menu_timer : t_TIMER;
begin

  green_debouncer: entity work.button_debouncer
    generic map(debounce_clk_cnt => debounce_clk_cnt)
    port map (
      clk => clk,
      btn_in => green_input,
      btn_debounced => players_commands.green
    );
    
  red_debouncer: entity work.button_debouncer
    generic map(debounce_clk_cnt => debounce_clk_cnt)
    port map (
      clk => clk,
      btn_in => red_input,
      btn_debounced => players_commands.red
    );
    
  blue_debouncer: entity work.button_debouncer
    generic map(debounce_clk_cnt => debounce_clk_cnt)
    port map (
      clk => clk,
      btn_in => blue_input,
      btn_debounced => players_commands.blue
    );
    
  yellow_debouncer: entity work.button_debouncer
    generic map(debounce_clk_cnt => debounce_clk_cnt)
    port map (
      clk => clk,
      btn_in => yellow_input,
      btn_debounced => players_commands.yellow
    );

  WS2812B_driver: entity work.WS2812B_driver
    generic map(max_pos => max_pos)
    port map(
      clk => clk,
      leds_line => leds_line,
      
      program_led_number => led_proceed,
      program_red_intensity => red_intensity,
      program_blue_intensity => blue_intensity,
      program_green_intensity => green_intensity,
      update_frame => update_frame
    );

  LEDs_racer_core: entity work.LEDs_racer_core
    generic map(max_pos => max_pos)
    port map(
      clk => clk,
      
      update_frame => update_frame,

      players_commands => players_commands,
      
      current_led => led_proceed,
      led_green_intensity => green_intensity,
      led_red_intensity => red_intensity,
      led_blue_intensity => blue_intensity
    );

end architecture;
