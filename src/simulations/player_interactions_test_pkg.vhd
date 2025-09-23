library ieee;
use ieee.std_logic_1164.all;

package player_interactions_test_pkg is

  procedure player_press_his_button_during(
    duration: time;
    signal player_input : out std_logic
  );

end package;

package body player_interactions_test_pkg is

  procedure player_press_his_button_during(
    duration: time;
    signal player_input : out std_logic
  ) is
  begin
    wait for 1 ps;

    player_input <= '1';
    wait for duration;
    player_input <= '0';

  end procedure;

end package body;
