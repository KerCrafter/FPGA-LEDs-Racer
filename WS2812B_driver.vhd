library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WS2812B_driver is
	port(
		clk : in std_logic;
		enable : in std_logic;
		
		green_pos : in integer range 0 to 3;
		red_pos : in integer range 0 to 3;
		blue_pos : in integer range 0 to 3;
		yellow_pos : in integer range 0 to 3;
		
		leds_line : out std_logic := '0'
	);
end entity;

architecture behaviour of WS2812B_driver is
	signal step : integer range 0 to 62;
	signal bit_proceed : integer range 0 to 23;
	signal led_proceed : integer range 0 to 3;
	
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
		step : integer range 0 to 62;
		bit_proceed : integer range 0 to 23;
		
		green: integer range 0 to 255;
		red: integer range 0 to 255;
		blue: integer range 0 to 255
	) return std_logic is
		variable data :  std_logic_vector(0 to 23);
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
		step : integer range 0 to 62;
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
		variable red_cur_pos : integer range 0 to 3;
		variable blue_cur_pos : integer range 0 to 3;
		variable green_cur_pos : integer range 0 to 3;
		variable yellow_cur_pos : integer range 0 to 3;
	begin
	
		if rising_edge(clk) then

			case stage is
				when WaitStart =>
					if enable = '1' then
						stage <= SendLEDsData;
					end if;
				
					leds_line <= '0';
		
				when SendLEDsData =>
					if step = 62 then
						step <= 0;
						
						if bit_proceed = 23 then
							bit_proceed <= 0;
							
							if led_proceed = 3 then
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
						players_in_case => bool_to_logic(red_pos = led_proceed) & bool_to_logic(blue_pos = led_proceed) & bool_to_logic(green_pos = led_proceed) & bool_to_logic(yellow_pos = led_proceed)
					);
				
				when ValidateSeq =>
					leds_line <= '0';
					
					
					if blue_pos = blue_cur_pos and red_pos = red_cur_pos and green_pos = green_cur_pos and yellow_pos = yellow_cur_pos then
						--stay here
					else
					
						if blue_pos /= blue_cur_pos then
							blue_cur_pos := blue_pos;
						end if;
						
						if red_pos /= red_cur_pos then
							red_cur_pos := red_pos;
						end if;
						
						if green_pos /= green_cur_pos then
							green_cur_pos := green_pos;
						end if;
						
						if yellow_pos /= yellow_cur_pos then
							yellow_cur_pos := yellow_pos;
						end if;
						
						stage <= SendLEDsData;
					end if;
				when others =>
					--nothing todo
			end case;
		end if;

	end process;
end architecture;