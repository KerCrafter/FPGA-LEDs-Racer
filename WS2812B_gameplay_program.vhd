library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WS2812B_gameplay_program is
	port (
		red_pos : in integer range 0 to 15;
		blue_pos : in integer range 0 to 15;
		green_pos : in integer range 0 to 15;
		yellow_pos : in integer range 0 to 15;
		
		led_number : in integer range 0 to 15;
	
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
		variable players_into_the_led : std_logic_vector(3 downto 0);
	begin
	
		players_into_the_led := bool_to_logic(red_pos = led_number) & bool_to_logic(blue_pos = led_number) & bool_to_logic(green_pos = led_number) & bool_to_logic(yellow_pos = led_number);
	
		case players_into_the_led is
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