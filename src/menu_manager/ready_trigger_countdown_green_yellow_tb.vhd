library ieee;
use ieee.std_logic_1164.all;

entity ready_trigger_countdown_green_yellow_tb is
end entity;

architecture simulation of ready_trigger_countdown_green_yellow_tb is
  signal green_ready_to_play : std_logic := '0';
  signal red_ready_to_play : std_logic := '0';
  signal blue_ready_to_play : std_logic := '0';
  signal yellow_ready_to_play : std_logic := '0';
  signal result : std_logic;
begin
  UUT: entity work.ready_trigger_countdown
    port map (
      green_ready_to_play => green_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,
      
      result => result
    );
  
  STIM: process
  begin 

    wait for 30 ns; green_ready_to_play <= '1';

    wait for 15 ns; assert result = '0' report "Only green is ready to play";

    wait for 30 ns; yellow_ready_to_play <= '1';

    wait for 15 ns; assert result = '1' report "Green and Yellow are ready to play";

    wait;

  end process;

end architecture;
