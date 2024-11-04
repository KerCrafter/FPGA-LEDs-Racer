library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_main is
	port(
		clk : in std_logic;
		enable : in std_logic;
		
		green_input : in std_logic;
		red_input : in std_logic;
		blue_input : in std_logic;
		yellow_input : in std_logic;
		
		leds_line : out std_logic := '0'
	);
end entity;

architecture behaviour of LEDs_racer_main is
	constant step_max : integer := 62;
	constant bit_proceed_max : integer := 23;
	constant led_proceed_max : integer := 3;

	signal step : integer range 0 to step_max;
	signal bit_proceed : integer range 0 to bit_proceed_max;
	signal led_proceed : integer range 0 to led_proceed_max;
	
	constant WaitStart : std_logic_vector(0 to 1) := "00";
	constant SendLEDsData : std_logic_vector(0 to 1) := "01";
	constant ValidateSeq : std_logic_vector(0 to 1) := "10";
	
	signal stage : std_logic_vector(0 to 1) := WaitStart;
	
	
	constant HIGH_DURATION_FOR_CODE_1 : integer := 39;
	constant HIGH_DURATION_FOR_CODE_0 : integer := 19;
	
	function ite(b: boolean; x, y: integer) return integer is
	begin
		 if (b) then
			  return x;
		 else
			  return y;
		 end if;
	end function ite;
	
	function bool_to_logic(b: boolean) return std_logic is
	begin
		 if (b) then
			  return '1';
		 else
			  return '0';
		 end if;
	end function bool_to_logic;
	
	function serial_state_led_line_for_color (
		step : integer range 0 to step_max;
		bit_proceed : integer range 0 to bit_proceed_max;
		
		green: integer range 0 to 255;
		red: integer range 0 to 255;
		blue: integer range 0 to 255
	) return std_logic is
		variable data :  std_logic_vector(0 to bit_proceed_max);
	begin
		data := std_logic_vector( to_unsigned( green, 8)) & std_logic_vector( to_unsigned( red, 8)) & std_logic_vector( to_unsigned( blue, 8));
	
		if data(bit_proceed) = '0' and step <= HIGH_DURATION_FOR_CODE_0 then
			return '1';
		elsif data(bit_proceed) = '1' and step <= HIGH_DURATION_FOR_CODE_1 then
			return '1';
		else
			return '0';
		end if;
	end function;
	
	
	function serial_state_led_line (
		step : integer range 0 to step_max;
		bit_proceed : integer range 0 to 23;
		
		players_in_case : std_logic_vector(3 downto 0)
	) return std_logic is
	begin		
		if players_in_case = "0000" then
			return serial_state_led_line_for_color(
				bit_proceed => bit_proceed,
				step => step,
				green => 0,
				red => 0,
				blue => 0
			);
		elsif players_in_case = "0001" then
			return serial_state_led_line_for_color(
				bit_proceed => bit_proceed,
				step => step,
				green => 5,
				red => 5,
				blue => 0
			);
		elsif players_in_case = "0010" or players_in_case = "0100" or players_in_case = "1000" then
			return serial_state_led_line_for_color(
				bit_proceed => bit_proceed,
				step => step,
				green => ite(players_in_case = "0010", 10, 0),
				red => ite(players_in_case = "1000", 10, 0),
				blue => ite(players_in_case = "0100", 10, 0)
			);
		else
			return serial_state_led_line_for_color(
				bit_proceed => bit_proceed,
				step => step,
				green => 5,
				red => 5,
				blue => 5
			);
		end if;
	end function;
	
	
begin
	process(clk)
		variable red_cur_pos : integer range 0 to led_proceed_max;
		variable blue_cur_pos : integer range 0 to led_proceed_max;
		variable green_cur_pos : integer range 0 to led_proceed_max;
		variable yellow_cur_pos : integer range 0 to led_proceed_max;
		
		variable red_lock : std_logic := '0';
		variable blue_lock : std_logic := '0';
		variable green_lock : std_logic := '0';
		variable yellow_lock : std_logic := '0';
	begin
		if rising_edge(clk) then

			case stage is
				when WaitStart =>
					if enable = '1' then
						stage <= SendLEDsData;
					end if;
				
					leds_line <= '0';
		
				when SendLEDsData =>
					if step = step_max then
						step <= 0;
						
						if bit_proceed = bit_proceed_max then
							bit_proceed <= 0;
							
							if led_proceed = led_proceed_max then
								led_proceed <= 0;
								
								stage <= ValidateSeq;
							else
								led_proceed <= led_proceed + 1;
							end if;
						else
							bit_proceed <= bit_proceed + 1;
						end if;
					else
						step <= step + 1;
					end if;
					
					leds_line <= serial_state_led_line(
						bit_proceed => bit_proceed,
						step => step,
						players_in_case => bool_to_logic(red_cur_pos = led_proceed) & bool_to_logic(blue_cur_pos = led_proceed) & bool_to_logic(green_cur_pos = led_proceed) & bool_to_logic(yellow_cur_pos = led_proceed)
					);
				
				when ValidateSeq =>
					leds_line <= '0';
					
					if red_input = '1' and red_input /= red_lock then
						red_cur_pos := red_cur_pos + 1;
						stage <= SendLEDsData;
					end if;
					
					if blue_input = '1' and blue_input /= blue_lock then
						blue_cur_pos := blue_cur_pos + 1;
						stage <= SendLEDsData;
					end if;
					
					if green_input = '1' and green_input /= green_lock then
						green_cur_pos := green_cur_pos + 1;
						stage <= SendLEDsData;
					end if;
					
					if yellow_input = '1' and yellow_input /= yellow_lock then
						yellow_cur_pos := yellow_cur_pos + 1;
						stage <= SendLEDsData;
					end if;
					
					if red_input /= red_lock then
						red_lock := red_input;
					end if;
					
					if blue_input /= blue_lock then
						blue_lock := blue_input;
					end if;
					
					if green_input /= green_lock then
						green_lock := green_input;
					end if;
					
					if yellow_input /= yellow_lock then
						yellow_lock := yellow_input;
					end if;

				when others =>
					--nothing todo
			end case;
		end if;

	end process;
end architecture;