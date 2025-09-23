library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.player_interactions_test_pkg.all;
use work.sut_pkg.all;
use work.assertions_pkg.all;

entity LEDs_racer_core_yellow_wins_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_yellow_wins_sim is
  signal SUT : LEDs_racer_core_sut_interface := SUT_INIT;
begin
  UUT: entity work.LEDs_racer_core_SUT
    port map (
      sut_interface => SUT
    );
  
  SIMULATION: process
  begin 
    for k in 1 to 109 loop
      player_press_his_button_during(20 ns, SUT.players_commands.yellow);
    end loop;
    
    assert_all_LEDs_should_be_YELLOW(SUT, SUT.current_led, test_status);

    -- Game is END Should lock YELLOW actions
    player_press_his_button_during(20 ns, SUT.players_commands.yellow); --YELLOW player STAY in position 109

    assert_all_LEDs_should_be_YELLOW(SUT, SUT.current_led, test_status);


    -- try move GREEN player
    for k in 1 to 109 loop
      player_press_his_button_during(20 ns, SUT.players_commands.green);
    end loop;
    
    assert_all_LEDs_should_be_YELLOW(SUT, SUT.current_led, test_status);

    -- try move RED player
    for k in 1 to 109 loop
      player_press_his_button_during(20 ns, SUT.players_commands.red);
    end loop;
    
    assert_all_LEDs_should_be_YELLOW(SUT, SUT.current_led, test_status);

    -- try move BLUE player
    for k in 1 to 109 loop
      player_press_his_button_during(20 ns, SUT.players_commands.blue);
    end loop;
    
    assert_all_LEDs_should_be_YELLOW(SUT, SUT.current_led, test_status);

    SIMULATION_END(test_status);
  end process;
  
end architecture;
