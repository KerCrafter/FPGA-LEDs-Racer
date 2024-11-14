library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_main is
	generic (
		max_pos : integer := 16
	);

	port(
		clk : in std_logic;
		enable : in std_logic;
		
		green_input : in std_logic;
		red_input : in std_logic;
		blue_input : in std_logic;
		yellow_input : in std_logic;
		
		dp_0 : out integer range 0 to max_pos-1;
		
		dp_green : out integer range 0 to 255;
		dp_red : out integer range 0 to 255;
		dp_blue : out integer range 0 to 255;
		
		dp_red_cur_pos : out integer range 0 to max_pos-1;
		
		leds_line : out std_logic
	);
end entity;

architecture structural of LEDs_racer_main is
	signal led_proceed : integer range 0 to max_pos-1;
	
	signal update_frame : std_logic;
	
	signal red_intensity : integer range 0 to 255;
	signal blue_intensity : integer range 0 to 255;
	signal green_intensity : integer range 0 to 255;
begin
	WS2812B_driver: entity work.WS2812B_driver
		generic map(max_pos => max_pos)
		port map(
			clk => clk,
			leds_line => leds_line,
			enable => enable,
			
			program_led_number => led_proceed,
			program_red_intensity => red_intensity,
			program_blue_intensity => blue_intensity,
			program_green_intensity => green_intensity,
			update_frame => update_frame
		);
		
	LEDs_racer_core: entity work.LEDs_racer_core
		generic map(max_pos => max_pos)
		port map(
			clk => clk,
			
			update_frame => update_frame,
			
			green_input => green_input,
			red_input => red_input,
			blue_input => blue_input,
			yellow_input => yellow_input,
		
			current_led => led_proceed,
			led_green_intensity => green_intensity,
			led_red_intensity => red_intensity,
			led_blue_intensity => blue_intensity
		);

end architecture;