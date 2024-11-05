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
	
	
	leds_line <= serial_state_led_line(
		bit_proceed => bit_proceed,
		step => step,
		players_in_case => bool_to_logic(red_cur_pos = led_proceed) & bool_to_logic(blue_cur_pos = led_proceed) & bool_to_logic(green_cur_pos = led_proceed) & bool_to_logic(yellow_cur_pos = led_proceed)
	) when stage = SendLEDsData else '0';
	
end architecture;