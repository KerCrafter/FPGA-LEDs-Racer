library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.players_commands_pkg.all;
use work.player_interactions_test_pkg.all;
use work.sut_pkg.all;
use work.assertions_pkg.all;

entity LEDs_racer_core_menu_2_players_ready_countdown_5_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_menu_2_players_ready_countdown_5_sim is
  signal SUT : LEDs_racer_core_sut_interface := SUT_INIT;
begin
  UUT: entity work.LEDs_racer_core_SUT
    port map (
      sut_interface => SUT
    );
  
  SIMULATION: process
  begin
    player_press_his_button_during(20 ns, SUT.clk, SUT.players_commands.red);
    player_press_his_button_during(20 ns, SUT.clk, SUT.players_commands.green);

    generate_clk_edges(
      count => 1,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 5,
      clk => SUT.clk
    );

    generate_clk_edges(
      count => 5,
      clk => SUT.clk
    );

    --Wait menu refresh
    generate_clk_edges(
      count => 2,
      clk => SUT.clk
    );

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 0);

    assert_LED_should_be_red(SUT, SUT.current_led, test_status, 1);

    assert_LED_should_be_red(SUT, SUT.current_led, test_status, 2);

    assert_LED_should_be_red(SUT, SUT.current_led, test_status, 3);

    assert_led_should_be_red(SUT, SUT.current_led, test_status, 4);
    
    assert_led_should_be_red(SUT, SUT.current_led, test_status, 5);

    assert_led_should_be_red(SUT, SUT.current_led, test_status, 6);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 7);

    assert_LED_should_be_green(SUT, SUT.current_led, test_status, 8);

    assert_LED_should_be_green(SUT, SUT.current_led, test_status, 9);

    assert_LED_should_be_green(SUT, SUT.current_led, test_status, 10);

    assert_LED_should_be_green(SUT, SUT.current_led, test_status, 11);
    
    assert_LED_should_be_green(SUT, SUT.current_led, test_status, 12);

    assert_LED_should_be_green(SUT, SUT.current_led, test_status, 13);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 14);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 21);

    --Ring 2
    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 28);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 34);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 40);

    assert_LED_should_lightoff(SUT, SUT.current_led, test_status, 46);

    -- Ring 3

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 52);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 57);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 62);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 67);

    -- Ring 4

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 72);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 76);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 80);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 84);

    -- Ring 5

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 88);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 91);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 94);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 97);

    -- Ring 6

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 100);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 102);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 104);

    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 106);

    -- Ring 7
    assert_LED_should_be_white(SUT, SUT.current_led, test_status, 108);


    SIMULATION_END(test_status);
  end process;

end architecture;
