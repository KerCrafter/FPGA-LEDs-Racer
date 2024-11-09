library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button is
	port (
		btn : in std_logic;
		clk: in std_logic;
		cur_pos : buffer integer range 0 to 108;
		activity : out std_logic
	);
end entity;

architecture beh of player_button is
	signal lock : std_logic;
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if btn = '1' and btn /= lock then
				lock <= btn;
				
				cur_pos <= cur_pos + 1;
			elsif btn = '0' and btn /= lock then
				lock <= btn;
			end if;
		end if;
	end process;
	
	activity <= '1' when btn = '1' and btn /= lock else '0';
	
end architecture;