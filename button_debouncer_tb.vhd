library ieee;
use ieee.std_logic_1164.all;


entity button_debouncer_tb is
end entity;

architecture behaviour of button_debouncer_tb is
	signal clk : std_logic;
	signal btn_in : std_logic;
begin

	CLK_STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		clk <= '1'; wait for 10 ns;
	end process;
	
	BTN_STIM: process
	begin
		btn_in <= '0'; wait for 50 ns;
		
		btn_in <= '1'; wait for 3 ns;
		btn_in <= '0'; wait for 3 ns;
		btn_in <= '1'; wait for 3 ns;
		btn_in <= '0'; wait for 3 ns;
		btn_in <= '1'; wait for 3 ns;
		btn_in <= '0'; wait for 3 ns;
		btn_in <= '1'; wait for 3 ns;
		btn_in <= '0'; wait for 3 ns;
		btn_in <= '1'; wait for 3 ns;
		btn_in <= '0'; wait for 3 ns;
		btn_in <= '1'; wait for 3 ns;
		btn_in <= '0'; wait for 3 ns;
		btn_in <= '1';
		
		wait;
	end process;
	

end architecture;