library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.player_interactions_test_pkg.all;
use work.sut_pkg.all;
use work.assertions_pkg.all;

entity LEDs_racer_core_menu_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_menu_sim is
  signal SUT : LEDs_racer_core_sut_interface;
begin
  UUT: entity work.LEDs_racer_core_SUT
    port map (
      sut_interface => SUT
    );
  
  SIMULATION: process
  begin
    SUT.opt_with_menu <= '1';

    wait for 20 ns; 

    assert_all_LEDs_should_lightoff(SUT, SUT.current_led, test_status);
  
    SIMULATION_END(test_status);
  end process;

end architecture;
