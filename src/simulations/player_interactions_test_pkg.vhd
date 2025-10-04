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

  procedure wait_until_gameplay_start_for_2_players(
    signal player1 : out std_logic;
    signal player2 : out std_logic;
    signal clk : out std_logic;
    signal opt_with_menu : out std_logic
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


  procedure wait_until_gameplay_start_for_2_players(
    signal player1 : out std_logic;
    signal player2 : out std_logic;
    signal clk : out std_logic;
    signal opt_with_menu : out std_logic
  ) is
  begin
    player_press_his_button_during(20 ns, player1);
    player_press_his_button_during(20 ns, player2);

    generate_clk_edges(
      count => 1,
      clk => clk
    );

    generate_clk_edges(
      count => 5,
      clk => clk
    );

    generate_clk_edges(
      count => 5,
      clk => clk
    );

    generate_clk_edges(
      count => 5,
      clk => clk
    );

    generate_clk_edges(
      count => 5,
      clk => clk
    );

    generate_clk_edges(
      count => 5,
      clk => clk
    );

    generate_clk_edges(
      count => 5,
      clk => clk
    );

    generate_clk_edges(
      count => 5,
      clk => clk
    );
  end procedure;

end package body;
