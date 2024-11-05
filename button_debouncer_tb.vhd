library ieee;
use ieee.std_logic_1164.all;


entity button_debouncer_tb is
end entity;

architecture behaviour of button_debouncer_tb is
	signal clk : std_logic;
begin

	STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		clk <= '1'; wait for 10 ns;
	end process;

end architecture;