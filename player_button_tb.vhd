library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button_tb is
end entity;

architecture simulation of player_button_tb is
  signal clk : std_logic := '0';
  signal btn : std_logic := '0';
  signal activity : std_logic;
  signal on_menu : std_logic := '0';
  signal game_started: std_logic := '0';
  signal cur_pos : integer range 0 to 108;
  signal ready_to_play : std_logic;
begin

  UUT: entity work.player_button port map (
    clk => clk,
    on_menu => on_menu,
    game_started => game_started,
    btn => btn,
    activity => activity,
    cur_pos => cur_pos,
    ready_to_play => ready_to_play
  );

  CLK_STIM: process
  begin
    -- Inverse CLK every 10ns = 20ns per cycle = 50MHz
    clk <= not clk; wait for 10 ns;
  end process;
  
  BTN_STIM: process
  begin
    on_menu <= '1';

    btn <= '0'; wait for 50 ns;
    btn <= '1'; wait for 50ns;

    btn <= '0'; wait for 50 ns;
    btn <= '1'; wait for 50ns;

    on_menu <= '0';
    game_started <= '1';
  
    btn <= '0'; wait for 50 ns;
    
    btn <= '1'; wait for 50ns;
    btn <= '0'; wait for 50ns;

    btn <= '1'; wait for 50ns;
    btn <= '0'; wait for 50ns;

    btn <= '1'; wait for 50ns;
    btn <= '0'; wait for 50ns;

    game_started <= '0'; wait for 15ns;

    btn <= '1'; wait for 50ns;
    btn <= '0'; wait for 50ns;

    btn <= '1'; wait for 50ns;
    btn <= '0'; wait for 50ns;
    
    wait;
  end process;

end architecture;
