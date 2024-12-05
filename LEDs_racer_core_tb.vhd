library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_core_tb is
end entity;

architecture testbench of LEDs_racer_core_tb is
	signal clk : std_logic := '0';

	signal red_input : std_logic;
	signal blue_input : std_logic;
	signal green_input : std_logic;
	signal yellow_input : std_logic;
	
	signal current_led : integer range 0 to 108;
	signal led_green_intensity : std_logic_vector(7 downto 0);
	signal led_red_intensity : std_logic_vector(7 downto 0);
	signal led_blue_intensity : std_logic_vector(7 downto 0);
	
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
		procedure red_player_press_his_button_during(duration: time) is
		begin
			wait for 20 ns;

			red_input <= '1';
			wait for duration;
			red_input <= '0';
		end procedure;
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
		
		red_player_press_his_button_during(0.5 ms); --RED position up from 0 to 1
		
		wait;
	end process;
	
	CLK_STIM: process
	begin
		-- Inverse CLK every 10ns = 20ns per cycle = 50MHz
		clk <= not clk; wait for 10 ns;
	end process;
	
	CHECK_SIG: process
		procedure assert_LED_should_lightoff(message: string) is
		begin
			assert led_green_intensity = std_logic_vector(to_unsigned(0, 8)) and led_red_intensity = std_logic_vector(to_unsigned(0, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(0, 8)) report message;
		end procedure;

		procedure assert_LED_should_be_white(message: string) is
		begin
			wait for 1 ps; assert led_green_intensity = std_logic_vector(to_unsigned(5, 8)) and led_red_intensity = std_logic_vector(to_unsigned(5, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(5, 8)) report message;
		end procedure;
	begin
		assert_LED_should_be_white("LED 0 : should be WHITE");
		
		wait until current_led = 1; wait for 1 ps;
		assert_LED_should_lightoff("LED 1 : should be BLACK");

		wait until current_led = 2; wait for 1 ps;
		assert_LED_should_lightoff("LED 2 : should be BLACK");
		
		wait until current_led = 3; wait for 1 ps;
		assert_LED_should_lightoff("LED 3 : should be BLACK");
		
		wait until current_led = 4; wait for 1 ps;
		assert_LED_should_lightoff("LED 4 : should be BLACK");
	
		wait;
	end process;
end architecture;
