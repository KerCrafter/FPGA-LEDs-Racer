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
  signal SUT : LEDs_racer_core_sut_interface;
begin
  UUT: entity work.LEDs_racer_core_SUT
    port map (
      sut_interface => SUT
    );
  
  PLAYS_STIM: process
    procedure assert_all_LEDs_should_be_BLUE is
    begin
      for led_number in 0 to 108 loop
        wait for 20 ns; SUT.current_led <= led_number; wait for 1 ps; assert_GRB(SUT, test_status, 0, 0, 10, "LED " & to_string(led_number) & ": should be BLUE");
      end loop;
    end procedure;
  begin

    for k in 1 to 109 loop
      player_press_his_button_during(20 ns, SUT.players_commands.blue);
    end loop;
    
    assert_all_LEDs_should_be_BLUE;
    
    -- Game is END Should lock BLUE actions
    player_press_his_button_during(20 ns, SUT.players_commands.blue); --BLUE player STAY in position 109

    assert_all_LEDs_should_be_BLUE;

    SIMULATION_END(test_status);
  end process;
  
  CLK_STIM: process
  begin
    -- Inverse CLK every 10ns = 20ns per cycle = 50MHz
    SUT.clk <= not SUT.clk; wait for 10 ns;
  end process;

end architecture;
