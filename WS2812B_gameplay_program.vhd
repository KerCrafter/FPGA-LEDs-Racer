library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WS2812B_gameplay_program is
	generic (
		max_pos : integer := 109
	);

	port (
		enable : in std_logic;
		red_pos : in integer range 0 to max_pos-1;
		blue_pos : in integer range 0 to max_pos-1;
		green_pos : in integer range 0 to max_pos-1;
		yellow_pos : in integer range 0 to max_pos-1;
		
		led_number : in integer range 0 to max_pos-1;
	
		red_intensity : out std_logic_vector(7 downto 0);
		blue_intensity : out std_logic_vector(7 downto 0);
		green_intensity : out std_logic_vector(7 downto 0)
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
	
		if enable = '1' then
			if green_pos = max_pos-1 then
				green_intensity <= std_logic_vector(to_unsigned(10, 8));
				red_intensity <= std_logic_vector(to_unsigned(0, 8));
				blue_intensity <= std_logic_vector(to_unsigned(0, 8));
			elsif red_pos = max_pos-1 then
				green_intensity <= std_logic_vector(to_unsigned(0, 8));
				red_intensity <= std_logic_vector(to_unsigned(10, 8));
				blue_intensity <= std_logic_vector(to_unsigned(0, 8));
			else
				players_into_the_led := bool_to_logic(red_pos = led_number) & bool_to_logic(blue_pos = led_number) & bool_to_logic(green_pos = led_number) & bool_to_logic(yellow_pos = led_number);

				case players_into_the_led is
					when "0000" =>
						green_intensity <= std_logic_vector(to_unsigned(0, 8));
						red_intensity <= std_logic_vector(to_unsigned(0, 8));
						blue_intensity <= std_logic_vector(to_unsigned(0, 8));

					when "0001" =>
						green_intensity <= std_logic_vector(to_unsigned(5, 8));
						red_intensity <= std_logic_vector(to_unsigned(5, 8));
						blue_intensity <= std_logic_vector(to_unsigned(0, 8));
						
					when "1000" =>
						green_intensity <= std_logic_vector(to_unsigned(0, 8));
						red_intensity <= std_logic_vector(to_unsigned(10, 8));
						blue_intensity <= std_logic_vector(to_unsigned(0, 8));
						
					when "0100" =>
						green_intensity <= std_logic_vector(to_unsigned(0, 8));
						red_intensity <= std_logic_vector(to_unsigned(0, 8));
						blue_intensity <= std_logic_vector(to_unsigned(10, 8));
						
					when "0010" =>
						green_intensity <= std_logic_vector(to_unsigned(10, 8));
						red_intensity <= std_logic_vector(to_unsigned(0, 8));
						blue_intensity <= std_logic_vector(to_unsigned(0, 8));

					when others =>
						green_intensity <= std_logic_vector(to_unsigned(5, 8));
						red_intensity <= std_logic_vector(to_unsigned(5, 8));
						blue_intensity <= std_logic_vector(to_unsigned(5, 8));
				end case;
			end if;
		else
			green_intensity <= "ZZZZZZZZ";
			red_intensity <= "ZZZZZZZZ";
			blue_intensity <= "ZZZZZZZZ";
		end if;
	end process;

end architecture;