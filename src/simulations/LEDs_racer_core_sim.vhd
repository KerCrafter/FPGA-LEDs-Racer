library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.players_commands_pkg.all;
use work.sut_pkg.all;
use work.assertions_pkg.all;
use work.player_interactions_test_pkg.all;

entity LEDs_racer_core_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_sim is
  signal SUT : LEDs_racer_core_sut_interface := SUT_INIT;
begin
  UUT: entity work.LEDs_racer_core_SUT
    port map (
      sut_interface => SUT
    );
  
  SIMULATION: process
  begin

    wait_until_gameplay_start_for_2_players(
      player1 => SUT.players_commands.red,
      player2 => SUT.players_commands.green,
      clk => SUT.clk,
      opt_with_menu => SUT.opt_with_menu
    );

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 0);
    
    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 1);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 2);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 3);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 4);
  
    SIMULATION_END(test_status);
  end process;

end architecture;
