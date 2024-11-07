library ieee;
use ieee.std_logic_1164.all;


entity button_debouncer_tb is
end entity;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity button_debouncer is
	port (
		clk : in std_logic;
		btn_in : in std_logic;
		btn_debounced : out std_logic := '0'
	);
end entity;

architecture beh of button_debouncer is
	signal cnt : integer range 0 to 2 := 0;
begin

	process(clk)
	begin
	
		if rising_edge(clk) then
			if btn_in = '1' and cnt /= 2 then
				cnt <= cnt + 1;
			end if;
		end if;
	
	end process;

	btn_debounced <= '1' when cnt = 2 else '0';
	
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
		
		--one wait one edge clk
		if clk = '0' then
			wait until clk = '1';
		else
			wait until clk = '0';
			wait until clk = '1';
		end if;
		
		--one wait one edge clk

		if clk = '0' then
			wait until clk = '1';
		else
			wait until clk = '0';
			wait until clk = '1';
		end if;
		
		assert btn_debounced = '1' report "debounced button should up to HIGH";
		
		wait;
	
	end process;
	

end architecture;