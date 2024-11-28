library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_core_blue_wins_tb is
end LEDs_racer_core_blue_wins_tb;

architecture simulation of LEDs_racer_core_blue_wins_tb is
	signal clk : std_logic;

	signal red_input : std_logic;
	signal blue_input : std_logic;
	signal green_input : std_logic;
	signal yellow_input : std_logic;
	
	signal current_led : integer range 0 to 4;
	signal led_green_intensity : std_logic_vector(7 downto 0);
	signal led_red_intensity : std_logic_vector(7 downto 0);
	signal led_blue_intensity : std_logic_vector(7 downto 0);
	
	signal update_frame : std_logic;
begin
	UUT: entity work.LEDs_racer_core
		generic map(max_pos => 5)
		port map (
			clk => clk,

			green_input => green_input,
			red_input => red_input,
			blue_input => blue_input,
			yellow_input => yellow_input,
			
			current_led => current_led,
			led_green_intensity => led_green_intensity,
			led_red_intensity => led_red_intensity,
			led_blue_intensity => led_blue_intensity,
			update_frame => update_frame
		);
	
	PLAYS_STIM: process
	begin
		blue_input <= '0'; --blue position = 0
		
		wait for 20 ns; blue_input <= '1'; wait for 20 ns; blue_input <= '0'; --blue position up to 1
		wait for 20 ns; blue_input <= '1'; wait for 20 ns; blue_input <= '0'; --blue position up to 2
		wait for 20 ns; blue_input <= '1'; wait for 20 ns; blue_input <= '0'; --blue position up to 3
		wait for 20 ns; blue_input <= '1'; wait for 20 ns; blue_input <= '0'; --blue position up to 4
		
		-- check the display (all LEDs should be BLUE)
		wait for 20 ns; current_led <= 0; wait for 1 ps; assert led_green_intensity = std_logic_vector(to_unsigned(0, 8)) and led_red_intensity = std_logic_vector(to_unsigned(0, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(10, 8)) report "LED 0 : should be BLUE";
		wait for 20 ns; current_led <= 1; wait for 1 ps; assert led_green_intensity = std_logic_vector(to_unsigned(0, 8)) and led_red_intensity = std_logic_vector(to_unsigned(0, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(10, 8)) report "LED 1 : should be BLUE";
		wait for 20 ns; current_led <= 2; wait for 1 ps; assert led_green_intensity = std_logic_vector(to_unsigned(0, 8)) and led_red_intensity = std_logic_vector(to_unsigned(0, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(10, 8)) report "LED 2 : should be BLUE";
		wait for 20 ns; current_led <= 3; wait for 1 ps; assert led_green_intensity = std_logic_vector(to_unsigned(0, 8)) and led_red_intensity = std_logic_vector(to_unsigned(0, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(10, 8)) report "LED 3 : should be BLUE";
		wait for 20 ns; current_led <= 4; wait for 1 ps; assert led_green_intensity = std_logic_vector(to_unsigned(0, 8)) and led_red_intensity = std_logic_vector(to_unsigned(0, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(10, 8)) report "LED 4 : should be BLUE";

		wait;
	end process;
	
	CLK_STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		
		clk <= '1'; wait for 10 ns;
	end process;

end architecture;
