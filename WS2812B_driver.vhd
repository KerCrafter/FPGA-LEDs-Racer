library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WS2812B_driver is
	generic (
		max_pos : integer := 16
	);
	
	port (
		clk : in std_logic;
		enable : in std_logic;
		leds_line : out std_logic := '0';
		
		update_frame : in std_logic;
		
		program_led_number : buffer integer range 0 to max_pos-1;
		program_red_intensity : in integer range 0 to 255;
		program_blue_intensity : in integer range 0 to 255;
		program_green_intensity : in integer range 0 to 255
	);
end entity;


architecture beh of WS2812B_driver is
	constant step_max : integer := 62;
	constant bit_proceed_max : integer := 23;

	signal step : integer range 0 to step_max;
	signal bit_proceed : integer range 0 to bit_proceed_max;

	constant WaitStart : std_logic_vector(0 to 1) := "00";
	constant SendLEDsData : std_logic_vector(0 to 1) := "01";
	constant ValidateSeq : std_logic_vector(0 to 1) := "10";
	
	signal stage : std_logic_vector(0 to 1) := WaitStart;
	
	
	constant HIGH_DURATION_FOR_CODE_1 : integer := 39;
	constant HIGH_DURATION_FOR_CODE_0 : integer := 19;
	
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
begin
	process(clk)
	begin
		if rising_edge(clk) then
			case stage is
				when WaitStart =>
					if enable = '1' then
						stage <= SendLEDsData;
					end if;		
				when SendLEDsData =>
					if step = step_max then
						step <= 0;
						
						if bit_proceed = bit_proceed_max then
							bit_proceed <= 0;
							
							if program_led_number = max_pos-1 then
								program_led_number <= 0;
								
								stage <= ValidateSeq;
							else
								program_led_number <= program_led_number + 1;
							end if;
						else
							bit_proceed <= bit_proceed + 1;
						end if;
					else
						step <= step + 1;
					end if;
				
				when ValidateSeq =>
					if update_frame = '1' then
						stage <= SendLEDsData;
					end if;

				when others =>
					--nothing todo
			end case;
		end if;

	end process;
	
	leds_line <= serial_state_led_line_for_color(
		bit_proceed => bit_proceed,
		step => step,
		green => program_green_intensity,
		red => program_red_intensity,
		blue => program_blue_intensity
	) when stage = SendLEDsData else '0';

end architecture;