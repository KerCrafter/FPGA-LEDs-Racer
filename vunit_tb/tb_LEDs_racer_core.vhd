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
  signal main_ts : t_TEST_STATUS;
  signal blue_wins_ts : t_TEST_STATUS;
  signal green_wins_ts : t_TEST_STATUS;
  signal red_wins_ts : t_TEST_STATUS;
  signal yellow_wins_ts : t_TEST_STATUS;
  signal menu_ts : t_TEST_STATUS;
  signal menu_red_ready_to_play_ts : t_TEST_STATUS;
  signal menu_green_ready_to_play_ts : t_TEST_STATUS;
  signal menu_blue_ready_to_play_ts : t_TEST_STATUS;
  signal menu_yellow_ready_to_play_ts : t_TEST_STATUS;
  signal menu_red_and_green_ready_to_play_ts : t_TEST_STATUS;
  signal menu_2_players_ready_countdown_6_ts : t_TEST_STATUS;
  signal menu_2_players_ready_countdown_5_ts : t_TEST_STATUS;
  signal menu_2_players_ready_countdown_4_ts : t_TEST_STATUS;
  signal menu_2_players_ready_countdown_3_ts : t_TEST_STATUS;
  signal menu_2_players_ready_countdown_2_ts : t_TEST_STATUS;
  signal menu_2_players_ready_countdown_1_ts : t_TEST_STATUS;
  signal menu_2_players_ready_countdown_final_ts : t_TEST_STATUS;
  signal menu_red_player_ready_should_trigger_update_frame_ts : t_TEST_STATUS;
  signal menu_green_player_ready_should_trigger_update_frame_ts : t_TEST_STATUS;
  signal menu_blue_player_ready_should_trigger_update_frame_ts : t_TEST_STATUS;
begin

  MAIN_SIM: entity work.LEDs_racer_core_sim
    port map( test_status => main_ts );

  BLUE_WINS_SIM : entity work.LEDs_racer_core_blue_wins_sim
    port map( test_status => blue_wins_ts );

  GREEN_WINS_SIM: entity work.LEDs_racer_core_green_wins_sim
    port map( test_status => green_wins_ts );

  RED_WINS_SIM : entity work.LEDs_racer_core_red_wins_sim
    port map( test_status => red_wins_ts );

  YELLOW_WINS_SIM : entity work.LEDs_racer_core_yellow_wins_sim
    port map( test_status => yellow_wins_ts );

  MENU_SIM : entity work.LEDs_racer_core_menu_sim
    port map( test_status => menu_ts );

  MENU_RED_READY_TO_PLAY_SIM : entity work.LEDs_racer_core_menu_red_ready_to_play_sim
    port map( test_status => menu_red_ready_to_play_ts );

  MENU_GREEN_READY_TO_PLAY_SIM : entity work.LEDs_racer_core_menu_green_ready_to_play_sim
    port map( test_status => menu_green_ready_to_play_ts );

  MENU_BLUE_READY_TO_PLAY_SIM : entity work.LEDs_racer_core_menu_blue_ready_to_play_sim
    port map( test_status => menu_blue_ready_to_play_ts );

  MENU_YELLOW_READY_TO_PLAY_SIM : entity work.LEDs_racer_core_menu_yellow_ready_to_play_sim
    port map( test_status => menu_yellow_ready_to_play_ts );

  MENU_RED_AND_GREEN_READY_TO_PLAY_SIM : entity work.LEDs_racer_core_menu_red_and_green_ready_to_play_sim
    port map( test_status => menu_red_and_green_ready_to_play_ts );

  MENU_2_PLAYERS_READY_COUNTDOWN_6_SIM : entity work.LEDs_racer_core_menu_2_players_ready_countdown_6_sim
    port map( test_status => menu_2_players_ready_countdown_6_ts );

  MENU_2_PLAYERS_READY_COUNTDOWN_5_SIM : entity work.LEDs_racer_core_menu_2_players_ready_countdown_5_sim
    port map( test_status => menu_2_players_ready_countdown_5_ts );

  MENU_2_PLAYERS_READY_COUNTDOWN_4_SIM : entity work.LEDs_racer_core_menu_2_players_ready_countdown_4_sim
    port map( test_status => menu_2_players_ready_countdown_4_ts );

  MENU_2_PLAYERS_READY_COUNTDOWN_3_SIM : entity work.LEDs_racer_core_menu_2_players_ready_countdown_3_sim
    port map( test_status => menu_2_players_ready_countdown_3_ts );

  MENU_2_PLAYERS_READY_COUNTDOWN_2_SIM : entity work.LEDs_racer_core_menu_2_players_ready_countdown_2_sim
    port map( test_status => menu_2_players_ready_countdown_2_ts );

  MENU_2_PLAYERS_READY_COUNTDOWN_1_SIM : entity work.LEDs_racer_core_menu_2_players_ready_countdown_1_sim
    port map( test_status => menu_2_players_ready_countdown_1_ts );

  MENU_2_PLAYERS_READY_COUNTDOWN_FINAL_SIM : entity work.LEDs_racer_core_menu_2_players_ready_countdown_final_sim
    port map( test_status => menu_2_players_ready_countdown_final_ts );

  MENU_RED_PLAYER_READY_SHOULD_TRIGGER_UPDATE_FRAME_SIM : entity work.LEDs_racer_core_menu_red_player_ready_should_trigger_update_frame_sim
    port map( test_status => menu_red_player_ready_should_trigger_update_frame_ts );

  MENU_GREEN_PLAYER_READY_SHOULD_TRIGGER_UPDATE_FRAME_SIM : entity work.LEDs_racer_core_menu_green_player_ready_should_trigger_update_frame_sim
    port map( test_status => menu_green_player_ready_should_trigger_update_frame_ts );

  MENU_BLUE_PLAYER_READY_SHOULD_TRIGGER_UPDATE_FRAME_SIM : entity work.LEDs_racer_core_menu_blue_player_ready_should_trigger_update_frame_sim
    port map( test_status => menu_blue_player_ready_should_trigger_update_frame_ts );

  
  RUN_TESTS : process
  begin
    test_runner_setup(runner, runner_cfg);

    while test_suite loop

      if run("main") then
        declare_simulation(main_ts);

      elsif run("blue_wins") then
        declare_simulation(blue_wins_ts);

      elsif run("green_wins") then
        declare_simulation(green_wins_ts);

      elsif run("red_wins") then
        declare_simulation(red_wins_ts);

      elsif run("yellow_wins") then
        declare_simulation(yellow_wins_ts);

      elsif run("menu") then
        declare_simulation(menu_ts);

      elsif run("menu_red_ready_to_play") then
        declare_simulation(menu_red_ready_to_play_ts);

      elsif run("menu_green_ready_to_play") then
        declare_simulation(menu_green_ready_to_play_ts);

      elsif run("menu_blue_ready_to_play") then
        declare_simulation(menu_blue_ready_to_play_ts);

      elsif run("menu_yellow_ready_to_play") then
        declare_simulation(menu_yellow_ready_to_play_ts);

      elsif run("menu_red_and_green_ready_to_play") then
        declare_simulation(menu_red_and_green_ready_to_play_ts);

      elsif run("menu_2_players_ready_countdown_6") then
        declare_simulation(menu_2_players_ready_countdown_6_ts);

      elsif run("menu_2_players_ready_countdown_5") then
        declare_simulation(menu_2_players_ready_countdown_5_ts);

      elsif run("menu_2_players_ready_countdown_4") then
        declare_simulation(menu_2_players_ready_countdown_4_ts);

      elsif run("menu_2_players_ready_countdown_3") then
        declare_simulation(menu_2_players_ready_countdown_3_ts);

      elsif run("menu_2_players_ready_countdown_2") then
        declare_simulation(menu_2_players_ready_countdown_2_ts);

      elsif run("menu_2_players_ready_countdown_1") then
        declare_simulation(menu_2_players_ready_countdown_1_ts);

      elsif run("menu_2_players_ready_countdown_final") then
        declare_simulation(menu_2_players_ready_countdown_final_ts);

      elsif run("menu_red_player_ready_should_trigger_update_frame") then
        declare_simulation(menu_red_player_ready_should_trigger_update_frame_ts);

      elsif run("menu_green_player_ready_should_trigger_update_frame") then
        declare_simulation(menu_green_player_ready_should_trigger_update_frame_ts);

      elsif run("menu_blue_player_ready_should_trigger_update_frame") then
        declare_simulation(menu_blue_player_ready_should_trigger_update_frame_ts);

      end if;

    end loop;

    test_runner_cleanup(runner);
  end process;

end architecture;
