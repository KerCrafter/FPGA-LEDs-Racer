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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity player_button is
	port (
		btn : in std_logic;
		clk: in std_logic;
		cur_pos : buffer integer range 0 to 3;
		activity : out std_logic
	);
end entity;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WS2812B_gameplay_program is
	port (
		red_pos : in integer range 0 to 3;
		blue_pos : in integer range 0 to 3;
		green_pos : in integer range 0 to 3;
		yellow_pos : in integer range 0 to 3;
		
		led_number : in integer range 0 to 3;
	
		red_intensity : out integer range 0 to 255;
		blue_intensity : out integer range 0 to 255;
		green_intensity : out integer range 0 to 255
	);
end entity;

architecture beh of WS2812B_gameplay_program is

	function bool_to_logic(b: boolean) return std_logic is
	begin
		 if (b) then
			  return '1';
		 else
			  return '0';
		 end if;
	end function bool_to_logic;

begin
	process(led_number, red_pos, blue_pos, green_pos, yellow_pos)
		variable v : std_logic_vector(3 downto 0);
	begin
	
		v := bool_to_logic(red_pos = led_number) & bool_to_logic(blue_pos = led_number) & bool_to_logic(green_pos = led_number) & bool_to_logic(yellow_pos = led_number);
	
		case v is
			when "0000" =>
				green_intensity <= 0;
				red_intensity <= 0;
				blue_intensity <= 0;

			when "0001" =>
				green_intensity <= 5;
				red_intensity <= 5;
				blue_intensity <= 0;
				
			when "1000" =>
				green_intensity <= 0;
				red_intensity <= 10;
				blue_intensity <= 0;
				
			when "0100" =>
				green_intensity <= 0;
				red_intensity <= 0;
				blue_intensity <= 10;
				
			when "0010" =>
				green_intensity <= 10;
				red_intensity <= 0;
				blue_intensity <= 0;

			when others =>
				green_intensity <= 5;
				red_intensity <= 5;
				blue_intensity <= 5;
		end case;
	end process;

end architecture;

architecture beh of player_button is
	signal lock : std_logic;
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if btn = '1' and btn /= lock then
				lock <= btn;
				
				cur_pos <= cur_pos + 1;
			elsif btn = '0' and btn /= lock then
				lock <= btn;
			end if;
		end if;
	end process;
	
	activity <= '1' when btn = '1' and btn /= lock else '0';
	
end architecture;

architecture behaviour of LEDs_racer_main is
	constant step_max : integer := 62;
	constant bit_proceed_max : integer := 23;
	constant led_proceed_max : integer := 3;

	signal step : integer range 0 to step_max;
	signal bit_proceed : integer range 0 to bit_proceed_max;
	signal led_proceed : integer range 0 to led_proceed_max;
	
	signal red_cur_pos : integer range 0 to led_proceed_max;
	signal blue_cur_pos : integer range 0 to led_proceed_max;
	signal green_cur_pos : integer range 0 to led_proceed_max;
	signal yellow_cur_pos : integer range 0 to led_proceed_max;
	
	signal red_activity : std_logic;
	signal blue_activity : std_logic;
	signal green_activity : std_logic;
	signal yellow_activity : std_logic;
	
	signal red_intensity : integer range 0 to 255;
	signal blue_intensity : integer range 0 to 255;
	signal green_intensity : integer range 0 to 255;
	
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
begin
	red_btn: entity work.player_button port map (
		clk => clk,
		btn => red_input,
		cur_pos => red_cur_pos,
		activity => red_activity
	);
	
	blue_btn: entity work.player_button port map (
		clk => clk,
		btn => blue_input,
		cur_pos => blue_cur_pos,
		activity => blue_activity
	);
	
	green_btn: entity work.player_button port map (
		clk => clk,
		btn => green_input,
		cur_pos => green_cur_pos,
		activity => green_activity
	);
	
	yellow_btn: entity work.player_button port map (
		clk => clk,
		btn => yellow_input,
		cur_pos => yellow_cur_pos,
		activity => yellow_activity
	);
	
	WS2812B_gameplay_program: entity work.WS2812B_gameplay_program port map(
		red_pos => red_cur_pos,
		blue_pos => blue_cur_pos,
		green_pos => green_cur_pos,
		yellow_pos => yellow_cur_pos,
		
		led_number => led_proceed,
	
		green_intensity => green_intensity,
		red_intensity => red_intensity,
		blue_intensity => blue_intensity
	);

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
				
				when ValidateSeq =>
					if red_activity = '1' or blue_activity = '1' or green_activity = '1' or yellow_activity = '1' then
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
		green => green_intensity,
		red => red_intensity,
		blue => blue_intensity
	) when stage = SendLEDsData else '0';
	
	
end architecture;