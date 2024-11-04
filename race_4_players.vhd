library ieee;
use ieee.std_logic_1164.all;

entity race_4_players is
	port(
		p1_input : in std_logic;
		p2_input : in std_logic;
		p3_input : in std_logic;
		p4_input : in std_logic;
		p1_position : buffer integer range 0 to 3;
		p2_position : buffer integer range 0 to 3;
		p3_position : buffer integer range 0 to 3;
		p4_position : buffer integer range 0 to 3
	);		
end entity;

architecture behavior of race_4_players is
begin

	process(p1_input)
	begin
		if rising_edge(p1_input) then
			p1_position <= p1_position + 1;
		end if;
	end process;
	
	process(p2_input)
	begin
		if rising_edge(p2_input) then
			p2_position <= p2_position + 1;
		end if;
	end process;
	
	process(p3_input)
	begin
		if rising_edge(p3_input) then
			p3_position <= p3_position + 1;
		end if;
	end process;
	
	process(p4_input)
	begin
		if rising_edge(p4_input) then
			p4_position <= p4_position + 1;
		end if;
	end process;
end architecture;