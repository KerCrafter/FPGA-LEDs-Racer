library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity WS2812B_driver_tb is
end entity;

architecture behaviour of WS2812B_driver_tb is
	constant num_leds : integer := 5000;
	
	signal clk : std_logic;
	signal enable : std_logic;
	
	signal update_frame : std_logic;
	
	signal program_led_number : integer range 0 to num_leds-1;
	signal program_green_intensity : integer range 0 to num_leds-1;
	signal program_red_intensity : integer range 0 to num_leds-1;
	signal program_blue_intensity : integer range 0 to num_leds-1;

	signal leds_line : std_logic;
	
	
	signal elapsed_clk_top : integer := 1;
	
	procedure assert_should_maintain_LOW_state_during_1_clk_edge is
	begin
		if clk = '1' then
			wait until clk = '0'; assert leds_line = '0' report "should maintain LOW during ...";
			wait until clk = '1'; assert leds_line = '0' report "should maintain LOW during ...";
		else
			wait until clk = '1'; assert leds_line = '0' report "should maintain LOW during ...";
		end if;
	end procedure;
	
	procedure assert_should_maintain_LOW_state_during( expected_clk_edge: integer ) is
		variable clk_checks : integer := 0;
	begin
		while clk_checks < expected_clk_edge loop
			assert_should_maintain_LOW_state_during_1_clk_edge;
			clk_checks := clk_checks + 1;
		end loop;
	end procedure;
	
	procedure assert_should_maintain_HIGH_state_during_1_clk_edge is
	begin
		if clk = '1' then
			wait until clk = '0'; assert leds_line = '1' report "should maintain HIGH during ...";
			wait until clk = '1'; assert leds_line = '1' report "should maintain HIGH during ...";
		else
			wait until clk = '1'; assert leds_line = '1' report "should maintain HIGH during ...";
		end if;
	end procedure;
	
	procedure assert_should_maintain_HIGH_state_during( expected_clk_edge: integer ) is
		variable clk_checks : integer := 0;
	begin
		while clk_checks < expected_clk_edge loop
			assert_should_maintain_HIGH_state_during_1_clk_edge;
			clk_checks := clk_checks + 1;
		end loop;
	end procedure;
	
	procedure assert_serial_line_change_to_LOW_after_clk_edge_counts( clk_edge: integer ) is
		variable cursor_start : integer;
	begin
		cursor_start := elapsed_clk_top;
		wait until leds_line = '0'; assert elapsed_clk_top - cursor_start = clk_edge report "to send first bit, should be 1 during around 0,80us";

	end procedure;
	
	procedure assert_serial_line_change_to_HIGH_after_clk_edge_counts( clk_edge: integer ) is
		variable cursor_start : integer;
	begin
		cursor_start := elapsed_clk_top;
		wait until leds_line = '1'; assert elapsed_clk_top - cursor_start = clk_edge report "serial line should change to HIGH after  clock rising edges"; -- to send first bit, should be 0 during around 0,45us

	end procedure;
	
	procedure assert_serial_NRZ_1_code_should_sent is
	begin
		assert_should_maintain_HIGH_state_during(40); -- ( 20ns * 40 => 800ns ) / 1000 = 0,8us (spec 0,80 )
		assert_should_maintain_LOW_state_during(23); -- ( 20ns * 23 => 460ns ) / 1000 = 0,46us ( Spec 0,45 )
	end procedure;
	
	procedure assert_serial_NRZ_0_code_should_sent is
	begin
		assert_should_maintain_HIGH_state_during(20); -- ( 20ns * 20 => 400ns ) / 1000 = 0,4us (spec 0,40 )
		assert_should_maintain_LOW_state_during(43); -- ( 20ns * 43 => 860ns ) / 1000 = 0,86us ( Spec 0,85 )
	end procedure;
	
	procedure assert_serial_led_signal_should_sent(
		green : integer range 0 to 255;
		red : integer range 0 to 255;
		blue : integer range 0 to 255
	) is
		variable green_vector : std_logic_vector(1 to 8);
		variable red_vector : std_logic_vector(1 to 8);
		variable blue_vector : std_logic_vector(1 to 8);
	begin
		-- Green
		green_vector := std_logic_vector(to_unsigned(green, 8));
		
		if green_vector(1) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if green_vector(2) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if green_vector(3) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if green_vector(4) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if green_vector(5) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if green_vector(6) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if green_vector(7) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if green_vector(8) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		-- Red
		red_vector := std_logic_vector(to_unsigned(red, 8));

		if red_vector(1) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if red_vector(2) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if red_vector(3) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if red_vector(4) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if red_vector(5) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if red_vector(6) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if red_vector(7) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if red_vector(8) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		-- Blue
		blue_vector := std_logic_vector(to_unsigned(blue, 8));

		if blue_vector(1) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if blue_vector(2) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if blue_vector(3) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if blue_vector(4) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if blue_vector(5) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if blue_vector(6) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if blue_vector(7) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;
		
		if blue_vector(8) = '1' then
			assert_serial_NRZ_1_code_should_sent;
		else
			assert_serial_NRZ_0_code_should_sent;
		end if;

	end procedure;
	
	procedure assert_serial_white_led_signal_should_sent is
	begin
		assert_serial_led_signal_should_sent(5, 5, 5);
	end procedure;
	
	procedure assert_serial_black_led_signal_should_sent is
	begin
		assert_serial_led_signal_should_sent(0, 0, 0);
	end procedure;
	
	procedure assert_serial_green_led_signal_should_sent is
	begin
		assert_serial_led_signal_should_sent(10, 0, 0);
	end procedure;
	
	procedure assert_serial_red_led_signal_should_sent is
	begin
		assert_serial_led_signal_should_sent(0, 10, 0);
	end procedure;
	
	procedure assert_serial_blue_led_signal_should_sent is
	begin
		assert_serial_led_signal_should_sent(0, 0, 10);
	end procedure;
	
	procedure assert_serial_yellow_led_signal_should_sent is
	begin
		assert_serial_led_signal_should_sent(5, 5, 0);
	end procedure;
	
	procedure assert_next_black_leds_should_sent(leds_count : integer) is
	begin

		for i in 1 to leds_count loop
			assert_serial_black_led_signal_should_sent;
		end loop;

	end procedure;
	
begin
	UUT: entity work.WS2812B_driver
		generic map(max_pos => num_leds)
		port map (
			clk => clk,
			enable => enable,
			
			program_led_number => program_led_number,
			program_green_intensity => program_green_intensity,
			program_red_intensity => program_red_intensity,
			program_blue_intensity => program_blue_intensity,
			
			update_frame => update_frame,

			leds_line => leds_line
		);
	
	PLAYS_STIM: process
	begin
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		update_frame <= '0';
		enable <= '0';
		
		wait for 1 ms;
		enable <= '1';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 5;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		wait for 170 ms;
		
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 0;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		
		
		wait for 170 ms;
		
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 5;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		
		
		
		
		wait for 170 ms;
		
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 5;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;

		
		wait for 170 ms;
		
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 5;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		
		
		wait for 170 ms;
		
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 5;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		
		
		
		wait for 170 ms;
		
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 5;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		
		
		
		wait for 170 ms;
		
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 5;
		program_red_intensity <= 5;
		program_blue_intensity <= 5;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		
		wait for 170 ms;
		
		program_green_intensity <= 10;
		program_red_intensity <= 0;
		program_blue_intensity <= 0;
		
		update_frame <= '1';
		wait for 5 ns; update_frame <= '0';
		
		wait until program_led_number = 1;
		program_green_intensity <= 0;
		program_red_intensity <= 0;
		program_blue_intensity <= 10;
		
		wait until program_led_number = 2;
		program_green_intensity <= 0;
		program_red_intensity <= 10;
		program_blue_intensity <= 0;
		
		wait;
	end process;
	
	CLK_STIM: process
	begin
		clk <= '0'; wait for 10 ns;
		
		clk <= '1';
		elapsed_clk_top <= elapsed_clk_top + 1; 
		wait for 10 ns;
	end process;
	
	CHECK_ENA: process
	begin
		assert leds_line = '0' report "Initialy should be low";

		wait until enable = '1'; wait until clk = '1'; wait for 1 ps;
		assert leds_line = '1' report "Just after enable, leds line should be high";
		
		wait;
	end process;
	
	CHECK_SIG: process
	begin
		wait until leds_line = '1';
		
		-- All players are in 1st case
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_white_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_yellow_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_white_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_white_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_white_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_white_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_white_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_black_led_signal_should_sent;
		assert_serial_white_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		
		wait until update_frame = '1';
		
		assert_serial_green_led_signal_should_sent;
		assert_serial_blue_led_signal_should_sent;
		assert_serial_red_led_signal_should_sent;
		
		finish;
	end process;
end architecture;
