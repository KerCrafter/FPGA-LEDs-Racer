library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_core_tb is
end LEDs_racer_core_tb;

architecture behaviour of LEDs_racer_core_tb is
	signal clk : std_logic;

	signal red_input : std_logic;
	signal blue_input : std_logic;
	signal green_input : std_logic;
	signal yellow_input : std_logic;
	
	signal current_led : integer range 0 to 108;
	signal led_green_intensity : integer range 0 to 255;
	signal led_red_intensity : integer range 0 to 255;
	signal led_blue_intensity : integer range 0 to 255;
	
	signal update_frame : std_logic;
begin
	UUT: entity work.LEDs_racer_core
		generic map(max_pos => 109)
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
		red_input <= '0';
		blue_input <= '0';
		green_input <= '0';
		yellow_input <= '0';
		
		current_led <= 0;
		
		
		-- First Frame
		wait for 1 ns; current_led <= 1;
		wait for 1 ns; current_led <= 2;
		wait for 1 ns; current_led <= 3;
		wait for 1 ns; current_led <= 4;
		
		
		wait for 5 ms;
		red_input <= '1'; wait for 0.5 ms; red_input <= '0'; --red position up to 1
		
		wait;
	end process;
	
	CLK_STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		
		clk <= '1'; wait for 10 ns;
	end process;
	
	CHECK_SIG: process
	begin
		wait for 1 ps; assert led_green_intensity = 5 and led_red_intensity = 5 and led_blue_intensity = 5 report "LED 0 : should be WHITE";
		
		wait until current_led = 1; wait for 1 ps;
		assert led_green_intensity = 0 and led_red_intensity = 0 and led_blue_intensity = 0 report "LED 1 : should be BLACK";

		wait until current_led = 2; wait for 1 ps;
		assert led_green_intensity = 0 and led_red_intensity = 0 and led_blue_intensity = 0 report "LED 2 : should be BLACK";
		
		wait until current_led = 3; wait for 1 ps;
		assert led_green_intensity = 0 and led_red_intensity = 0 and led_blue_intensity = 0 report "LED 3 : should be BLACK";
		
		wait until current_led = 4; wait for 1 ps;
		assert led_green_intensity = 0 and led_red_intensity = 0 and led_blue_intensity = 0 report "LED 4 : should be BLACK";
		
	
		wait;
	end process;
end architecture;
