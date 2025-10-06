library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button_tb is
end entity;

architecture simulation of player_button_tb is
  signal clk : std_logic := '0';
  signal btn : std_logic := '0';
  signal activity : std_logic;
  signal current_screen : std_logic_vector(1 downto 0);
  signal cur_pos : integer range 0 to 108;
  signal ready_to_play : std_logic;
begin

  UUT: entity work.player_button port map (
    current_screen => current_screen,
    clk => clk,
    btn => btn,
    activity => activity,
    cur_pos => cur_pos,
    ready_to_play => ready_to_play,
    reset => '0'
  );

  CLK_STIM: process
  begin
    -- Inverse CLK every 10ns = 20ns per cycle = 50MHz
    clk <= not clk; wait for 10 ns;
  end process;
  
  BTN_STIM: process
  begin
    -- in menu
    current_screen <= "00";

    btn <= '0'; wait for 50 ns;
    btn <= '1'; wait for 50 ns;

    btn <= '0'; wait for 50 ns;
    btn <= '1'; wait for 50 ns;

    -- game started
    current_screen <= "01";
  
    btn <= '0'; wait for 50 ns;
    
    btn <= '1'; wait for 50 ns;
    btn <= '0'; wait for 50 ns;

    btn <= '1'; wait for 50 ns;
    btn <= '0'; wait for 50 ns;

    btn <= '1'; wait for 50 ns;
    btn <= '0'; wait for 50 ns;

    -- game finished
    current_screen <= "11"; wait for 15 ns;

    btn <= '1'; wait for 50 ns;
    btn <= '0'; wait for 50 ns;

    btn <= '1'; wait for 50 ns;
    btn <= '0'; wait for 50 ns;
    
    wait;
  end process;

end architecture;
