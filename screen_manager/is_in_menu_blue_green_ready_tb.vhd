library ieee;
use ieee.std_logic_1164.all;

entity is_in_menu_blue_green_ready_tb is
end entity;

architecture simulation of is_in_menu_blue_green_ready_tb is
  signal clk : std_logic := '0';
  signal green_ready_to_play : std_logic := '0';
  signal red_ready_to_play : std_logic := '0';
  signal blue_ready_to_play : std_logic := '0';
  signal yellow_ready_to_play : std_logic := '0';
  signal result : std_logic;
  signal D_two_players_ready : std_logic;
begin
  UUT: entity work.is_in_menu
    port map (
      clk => clk,

      green_ready_to_play => green_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,
      
      result => result,
      D_two_players_ready => D_two_players_ready
    );
  
  STIM: process
  begin 

    wait for 30 ns; blue_ready_to_play <= '1';

    wait for 15 ns; assert D_two_players_ready = '0' report "Only blue is ready to play";

    wait for 30 ns; green_ready_to_play <= '1';

    wait for 15 ns; assert D_two_players_ready = '1' report "Blue and Green are ready to play";

    wait;

  end process;
  
  CLK_STIM: process
  begin
    -- Inverse CLK every 10ns = 20ns per cycle = 50MHz
    clk <= not clk; wait for 10 ns;
  end process;

end architecture;
