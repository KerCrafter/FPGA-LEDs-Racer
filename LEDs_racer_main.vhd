library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_core is
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
		
		current_led : in integer range 0 to max_pos-1;
		led_green_intensity : out integer range 0 to 255;
		led_red_intensity : out integer range 0 to 255;
		led_blue_intensity : out integer range 0 to 255;
		update_frame : out std_logic
		
	);
end entity;

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
			enable => enable,

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

architecture structural of LEDs_racer_core is
	signal green_input_debounced : std_logic;

	signal red_cur_pos : integer range 0 to max_pos-1;
	signal blue_cur_pos : integer range 0 to max_pos-1;
	signal green_cur_pos : integer range 0 to max_pos-1;
	signal yellow_cur_pos : integer range 0 to max_pos-1;
	
	signal red_activity : std_logic;
	signal blue_activity : std_logic;
	signal green_activity : std_logic;
	signal yellow_activity : std_logic;
begin

	red_btn: entity work.player_button
		generic map(max_pos => max_pos)
		port map (
			clk => clk,
			btn => red_input,
			cur_pos => red_cur_pos,
			activity => red_activity
		);
	
	blue_btn: entity work.player_button
		generic map(max_pos => max_pos)
		port map (
			clk => clk,
			btn => blue_input,
			cur_pos => blue_cur_pos,
			activity => blue_activity
		);
	
	green_debouncer: entity work.button_debouncer port map (
		clk => clk,
		btn_in => green_input,
		btn_debounced => green_input_debounced
	);
	
	green_btn: entity work.player_button
		generic map(max_pos => max_pos)
		port map (
			clk => clk,
			btn => green_input_debounced,
			cur_pos => green_cur_pos,
			activity => green_activity
		);
	
	yellow_btn: entity work.player_button
		generic map(max_pos => max_pos)
		port map (
			clk => clk,
			btn => yellow_input,
			cur_pos => yellow_cur_pos,
			activity => yellow_activity
		);
	
	activity_detector: entity work.activity_detector port map(
		A => green_activity,
		B => red_activity,
		C => blue_activity,
		D => yellow_activity,
		
		R => update_frame
	);

	WS2812B_gameplay_program: entity work.WS2812B_gameplay_program
		generic map(max_pos => max_pos)
		port map(
			red_pos => red_cur_pos,
			blue_pos => blue_cur_pos,
			green_pos => green_cur_pos,
			yellow_pos => yellow_cur_pos,
			
			led_number => current_led,
		
			green_intensity => led_green_intensity,
			red_intensity => led_red_intensity,
			blue_intensity => led_blue_intensity
		);


end architecture;