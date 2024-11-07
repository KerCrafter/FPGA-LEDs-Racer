library ieee;
use ieee.std_logic_1164.all;


entity button_debouncer_tb is
end entity;

library ieee;
use ieee.std_logic_1164.all;

entity button_debouncer is
	port (
		clk : in std_logic;
		btn_in : in std_logic;
		btn_debounced : out std_logic
	);
end entity;

architecture beh of button_debouncer is
begin
	btn_debounced <= '0';
end architecture;


architecture behaviour of button_debouncer_tb is
	signal clk : std_logic;
	signal btn_in : std_logic := '0';
	signal btn_debounced : std_logic;
begin

	UUT: entity work.button_debouncer port map (
		clk => clk,
		btn_in => btn_in,
		btn_debounced => btn_debounced
	);

	CLK_STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		clk <= '1'; wait for 10 ns;
	end process;
	
	BTN_STIM: process
	begin
		btn_in <= '0'; wait for 50 ns;
		
--		btn_in <= '1'; wait for 3 ns;
--		btn_in <= '0'; wait for 3 ns;
--		btn_in <= '1'; wait for 3 ns;
--		btn_in <= '0'; wait for 3 ns;
--		btn_in <= '1'; wait for 3 ns;
--		btn_in <= '0'; wait for 3 ns;
--		btn_in <= '1'; wait for 3 ns;
--		btn_in <= '0'; wait for 3 ns;
--		btn_in <= '1'; wait for 3 ns;
--		btn_in <= '0'; wait for 3 ns;
--		btn_in <= '1'; wait for 3 ns;
--		btn_in <= '0'; wait for 3 ns;
		btn_in <= '1';
		
		wait;
	end process;
	
	CHECK_BTN_DEBOUNCE: process
	begin
		wait until btn_in <= '1';
		
		assert btn_debounced = '0' report "just when button is pressed, should be LOW";
		
		wait;
	
	end process;
	

end architecture;