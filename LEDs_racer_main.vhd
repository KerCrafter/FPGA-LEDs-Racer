library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_main is
	generic (
		max_pos : integer := 16;
		debounce_clk_cnt : integer := 65536
	);

	port(
		clk : in std_logic;
		enable : in std_logic;
		
		green_input : in std_logic;
		red_input : in std_logic;
		blue_input : in std_logic;
		yellow_input : in std_logic;

		leds_line : out std_logic
	);
end entity;

architecture structural of LEDs_racer_main is
	signal led_proceed : integer range 0 to max_pos-1;
	
	signal update_frame : std_logic;
	
	signal red_intensity : integer range 0 to 255;
	signal blue_intensity : integer range 0 to 255;
	signal green_intensity : integer range 0 to 255;
	
	signal red_input_debounced : std_logic;
	signal green_input_debounced : std_logic;
	signal blue_input_debounced : std_logic;
begin

	green_debouncer: entity work.button_debouncer
		generic map(debounce_clk_cnt => debounce_clk_cnt)
		port map (
			clk => clk,
			btn_in => green_input,
			btn_debounced => green_input_debounced
		);
		
	red_debouncer: entity work.button_debouncer
		generic map(debounce_clk_cnt => debounce_clk_cnt)
		port map (
			clk => clk,
			btn_in => red_input,
			btn_debounced => red_input_debounced
		);
		
	blue_debouncer: entity work.button_debouncer
		generic map(debounce_clk_cnt => debounce_clk_cnt)
		port map (
			clk => clk,
			btn_in => blue_input,
			btn_debounced => blue_input_debounced
		);

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
			
			green_input => green_input_debounced,
			red_input => red_input_debounced,
			blue_input => blue_input_debounced,
			yellow_input => yellow_input,
		
			current_led => led_proceed,
			led_green_intensity => green_intensity,
			led_red_intensity => red_intensity,
			led_blue_intensity => blue_intensity
		);

end architecture;