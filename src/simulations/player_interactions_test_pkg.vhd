library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package player_interactions_test_pkg is

  procedure player_press_his_button_during(
    duration: time;
    signal player_input : out std_logic
  );

  procedure generate_clk_edges(
    count : integer;
    signal clk : out std_logic
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

  procedure generate_clk_edges(
    count : integer;
    signal clk : out std_logic
  ) is
  begin
    for i in 1 to count loop
      wait for 1 ps; clk <= '1'; wait for 1 ps; clk <= '0';
    end loop;
  end procedure;

end package body;
