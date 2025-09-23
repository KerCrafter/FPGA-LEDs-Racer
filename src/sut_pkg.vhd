library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.players_commands_pkg.all;
use work.timer_pkg.all;

package sut_pkg is

  type LEDs_racer_core_SUT_interface is record
    clk : std_logic;

    players_commands : t_PLAYERS_COMMANDS;

    opt_with_menu : std_logic;
    
    current_led : integer range 0 to 108;
    led_green_intensity : std_logic_vector(7 downto 0);
    led_red_intensity : std_logic_vector(7 downto 0);
    led_blue_intensity : std_logic_vector(7 downto 0);
    update_frame : std_logic;

    menu_timer : t_TIMER;
  end record;

  constant SUT_INIT : LEDs_racer_core_SUT_interface := (
    clk => '0',
    players_commands => PLAYERS_COMMANDS_INIT,
    opt_with_menu => '0',
    current_led => 0,
    led_green_intensity => "00000000",
    led_red_intensity => "00000000",
    led_blue_intensity => "00000000",
    update_frame => '0',
    menu_timer => (
      enable => '0',
      tick => '0'
    )
  );

end package;
