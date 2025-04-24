library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity LEDs_racer_core_blue_wins_vunit_tb is
  generic (runner_cfg : string);
end entity;

architecture simulation of LEDs_racer_core_blue_wins_vunit_tb is
  signal tb_end : std_logic;
begin

  SIM : entity work.LEDs_racer_core_blue_wins_sim
    port map(
      tb_end => tb_end
    );
  
  MAIN : process
  begin   

    test_runner_setup(runner, runner_cfg);
    
    wait until tb_end = '1';

    test_runner_cleanup(runner);
    wait;

  end process;
  
end architecture;
