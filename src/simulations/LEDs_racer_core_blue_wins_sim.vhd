library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.player_interactions_test_pkg.all;
use work.players_commands_pkg.all;
use work.sut_pkg.all;
use work.assertions_pkg.all;

entity LEDs_racer_core_blue_wins_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_blue_wins_sim is
  signal SUT : LEDs_racer_core_sut_interface := SUT_INIT;
begin
  UUT: entity work.LEDs_racer_core_SUT
    port map (
      sut_interface => SUT
    );
  
  SIMULATION: process
  begin

    wait_until_gameplay_start_for_2_players(
      player1 => SUT.players_commands.blue,
      player2 => SUT.players_commands.green,
      clk => SUT.clk
    );

    for k in 1 to 109 loop
      player_press_his_button_during(20 ns, SUT.clk, SUT.players_commands.blue);
    end loop;
    
    assert_all_LEDs_should_be_BLUE(SUT, SUT.current_led, test_status);
    
    -- Game is END Should lock BLUE actions
    player_press_his_button_during(20 ns, SUT.clk, SUT.players_commands.blue); --BLUE player STAY in position 109

    assert_all_LEDs_should_be_BLUE(SUT, SUT.current_led, test_status);

    SIMULATION_END(test_status);
  end process;
  

end architecture;
