library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button_tb is
end entity;

architecture behaviour of player_button_tb is
	signal clk : std_logic;
	signal btn : std_logic := '0';
	signal activity : std_logic;
	signal cur_pos : integer range 0 to 108;
begin

	UUT: entity work.player_button port map (
		clk => clk,
		btn => btn,
		activity => activity,
		cur_pos => cur_pos
	);

	CLK_STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		clk <= '1'; wait for 10 ns;
	end process;
	
	BTN_STIM: process
	begin
	
		btn <= '0'; wait for 50 ns;
		
		btn <= '1'; wait for 50ns;
		btn <= '0'; wait for 50ns;

		btn <= '1'; wait for 50ns;
		btn <= '0'; wait for 50ns;

		btn <= '1'; wait for 50ns;
		btn <= '0'; wait for 50ns;
		
		wait;
	end process;

end architecture;
