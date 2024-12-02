library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_core_yellow_wins_tb is
end LEDs_racer_core_yellow_wins_tb;

architecture simulation of LEDs_racer_core_yellow_wins_tb is
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
		procedure assert_GRB(
			led_green_intensity_i: integer range 0 to 255;
			led_red_intensity_i: integer range 0 to 255;
			led_blue_intensity_i: integer range 0 to 255;
			report_message: string
		) is
		begin
			assert led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) report report_message;
		end procedure;
		
		procedure yellow_player_press_his_button_during(duration: time) is
		begin
			yellow_input <= '1';
			wait for duration;
			yellow_input <= '0';
		end procedure;
		
		procedure all_the_screen_should_YELLOW is
		begin
			wait for 20 ns; current_led <= 0; wait for 1 ps; assert_GRB(5, 5, 0, "LED 0 : should be YELLOW");
			wait for 20 ns; current_led <= 1; wait for 1 ps; assert_GRB(5, 5, 0, "LED 1 : should be YELLOW");
			wait for 20 ns; current_led <= 2; wait for 1 ps; assert_GRB(5, 5, 0, "LED 2 : should be YELLOW");
			wait for 20 ns; current_led <= 3; wait for 1 ps; assert_GRB(5, 5, 0, "LED 3 : should be YELLOW");
			wait for 20 ns; current_led <= 4; wait for 1 ps; assert_GRB(5, 5, 0, "LED 4 : should be YELLOW");
		end procedure;
	begin
		yellow_input <= '0'; --yellow position = 0
		
		wait for 20 ns; yellow_player_press_his_button_during(20 ns); --player yellow up to position 1
		wait for 20 ns; yellow_player_press_his_button_during(20 ns); --player yellow up to position 2
		wait for 20 ns; yellow_player_press_his_button_during(20 ns); --player yellow up to position 3
		wait for 20 ns; yellow_player_press_his_button_during(20 ns); --player yellow up to position 4
		
		-- check the display (all LEDs should be YELLOW)
		all_the_screen_should_YELLOW;

		-- Game is END Should lock YELLOW actions
		wait for 20 ns; yellow_player_press_his_button_during(20 ns); --YELLOW player stay in position 4

		all_the_screen_should_YELLOW;
		
		wait;
	end process;
	
	CLK_STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		
		clk <= '1'; wait for 10 ns;
	end process;

end architecture;
