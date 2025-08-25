-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.
--
-- Copyright (c) 2014-2025, Lars Asplund lars.anders.asplund@gmail.com

library ieee;
use ieee.std_logic_1164.all;
use work.test_status_pkg.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_leds_racer_core is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_leds_racer_core is
  signal main_test_status : t_TEST_STATUS;
  signal blue_wins_test_status : t_TEST_STATUS;
  signal green_wins_test_status : t_TEST_STATUS;
  signal red_wins_test_status : t_TEST_STATUS;
  signal yellow_wins_test_status : t_TEST_STATUS;
begin

  MAIN_SIM: entity work.LEDs_racer_core_sim
    port map(
      test_status => main_test_status
    );

  BLUE_WINS_SIM : entity work.LEDs_racer_core_blue_wins_sim
    port map(
      test_status => blue_wins_test_status
    );

  GREEN_WINS_SIM: entity work.LEDs_racer_core_green_wins_sim
    port map( test_status => green_wins_test_status );

  RED_WINS_SIM : entity work.LEDs_racer_core_red_wins_sim
    port map( test_status => red_wins_test_status );

  YELLOW_WINS_SIM : entity work.LEDs_racer_core_yellow_wins_sim
    port map( test_status => yellow_wins_test_status );
  
  MAIN : process
    procedure declare_simulation (
      signal test_status : t_TEST_STATUS
    ) is
    begin
        wait until test_status.is_finished;

        assert test_status.result_status report "It fails" severity failure;
    end procedure;
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop

      if run("main") then
        declare_simulation(main_test_status);

      elsif run("blue_wins") then
        declare_simulation(blue_wins_test_status);

      elsif run("green_wins") then
        declare_simulation(green_wins_test_status);

      elsif run("red_wins") then
        declare_simulation(red_wins_test_status);

      elsif run("yellow_wins") then
        declare_simulation(yellow_wins_test_status);

      end if;

    end loop;

    test_runner_cleanup(runner);
  end process;
end architecture;
