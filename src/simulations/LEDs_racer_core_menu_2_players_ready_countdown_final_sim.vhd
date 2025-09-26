library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.players_commands_pkg.all;
use work.player_interactions_test_pkg.all;
use work.timer_pkg.all;
use work.sut_pkg.all;
use work.assertions_pkg.all;

entity LEDs_racer_core_menu_2_players_ready_countdown_final_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_menu_2_players_ready_countdown_final_sim is
  signal SUT : LEDs_racer_core_sut_interface := SUT_INIT;
begin
  UUT: entity work.LEDs_racer_core_SUT
    port map (
      sut_interface => SUT
    );
  
  SIMULATION: process
  begin
    SUT.opt_with_menu <= '1';

    wait for 1 ps; 

    player_press_his_button_during(20 ns, SUT.players_commands.red);
    player_press_his_button_during(20 ns, SUT.players_commands.green);

    generate_clk_edges(
      count => 1,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 50000000,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 50000000,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 50000000,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 50000000,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 50000000,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 50000000,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 50000000,
      clk => SUT.clk
    );

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 0);

    assert_LED_should_lightoff_for_range(
      from_led => 1,
      to_led => 108,
      sut => SUT,
      current_led_sig => SUT.current_led,
      test_status => test_status
    );

    SIMULATION_END(test_status);
  end process;

end architecture;
