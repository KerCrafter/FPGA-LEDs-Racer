library ieee;
use ieee.std_logic_1164.all;

entity race_4_players_tb is
end race_4_players_tb;

architecture beh of race_4_players_tb is
	signal p1_input : std_logic;
	signal p2_input : std_logic;
	signal p3_input : std_logic;
	signal p4_input : std_logic;
	signal p1_position : integer range 0 to 3;
	signal p2_position : integer range 0 to 3;
	signal p3_position : integer range 0 to 3;
	signal p4_position : integer range 0 to 3;

begin
	UUT: entity work.race_4_players port map (
		p1_input => p1_input,
		p2_input => p2_input,
		p3_input => p3_input,
		p4_input => p4_input,
		p1_position => p1_position,
		p2_position => p2_position,
		p3_position => p3_position,
		p4_position => p4_position
	);

	P1_STIM: process
	begin
		p1_input <= '0'; wait for 5 ms;
		assert p1_position = 0 report "Before Player 1 press his button, should be to position 0";
		
		p1_input <= '1'; wait for 1 ns;
		assert p1_position = 1 report "After Player 1 press his button, should be to position 1";
		
		wait for 10 ms;
		
		assert p1_position = 1 report "Player 1 continue to press his button, should rest in position 1";
		wait for 1 ns;
		
		p1_input <= '0'; wait for 1 ns;
		
		assert p1_position = 1 report "After Player 1 release his button, should rest in position 1";

		wait for 50 ms;
		
		p1_input <= '1'; wait for 1 ns;
		assert p1_position = 2 report "After Player 1 push his button, should update his position to 2";
		
		wait;
	end process;
	
	P2_STIM: process
	begin
		p2_input <= '0'; wait for 6 ms;
		p2_input <= '1'; wait for 10 ms;
		p2_input <= '0'; wait for 50 ms;
		p2_input <= '1'; wait for 10 ms;
		wait;
	end process;
	
	P3_STIM: process
	begin
		p3_input <= '0'; wait for 4 ms;
		p3_input <= '1'; wait for 10 ms;
		p3_input <= '0'; wait for 50 ms;
		p3_input <= '1'; wait for 10 ms;
		wait;
	end process;
	
	P4_STIM: process
	begin
		p4_input <= '0'; wait for 10 ms;
		p4_input <= '1'; wait for 10 ms;
		p4_input <= '0'; wait for 50 ms;
		p4_input <= '1'; wait for 10 ms;
		wait;
	end process;
end architecture;
			