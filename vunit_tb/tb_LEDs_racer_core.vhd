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
  signal green_wins_end : std_logic;
  signal green_wins_res : std_logic;
  signal red_wins_end : std_logic;
  signal red_wins_res : std_logic;
  signal yellow_wins_end : std_logic;
  signal yellow_wins_res : std_logic;
begin

  MAIN_SIM: entity work.LEDs_racer_core_sim
    port map(
      test_status => main_test_status
    );

  SIM1 : entity work.LEDs_racer_core_blue_wins_sim
    port map(
      test_status => blue_wins_test_status
    );

  SIM2 : entity work.LEDs_racer_core_green_wins_sim
    port map(
      tb_end => green_wins_end,
      tb_res => green_wins_res
    );

  SIM_RED : entity work.LEDs_racer_core_red_wins_sim
    port map(
      tb_end => red_wins_end,
      tb_res => red_wins_res
    );

  SIM_YELLOW : entity work.LEDs_racer_core_yellow_wins_sim
    port map(
      tb_end => yellow_wins_end,
      tb_res => yellow_wins_res
    );
  
  MAIN : process
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop
      if run("main") then
        wait until main_test_status.is_finished;

        assert main_test_status.result_status report "It fails" severity failure;

      elsif run("blue_wins") then
  
        wait until blue_wins_test_status.is_finished;

        assert blue_wins_test_status.result_status report "It fails" severity failure;

      elsif run("green_wins") then
        wait until green_wins_end = '1';

        assert green_wins_res = '1' report "It fails" severity failure;

      elsif run("red_wins") then
        wait until red_wins_end = '1';

        assert red_wins_res = '1' report "It fails" severity failure;

      elsif run("yellow_wins") then
        wait until yellow_wins_end = '1';

        assert yellow_wins_res = '1' report "It fails" severity failure;

      end if;
    end loop;

    test_runner_cleanup(runner);
  end process;
end architecture;
