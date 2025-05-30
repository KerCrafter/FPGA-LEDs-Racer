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
  process(enable, led_number, red_pos, blue_pos, green_pos, yellow_pos)
    variable players_into_the_led : std_logic_vector(3 downto 0);
    
    procedure set_GRB (green_intensity_i: integer range 0 to 255; red_intensity_i: integer range 0 to 255; blue_intensity_i: integer range 0 to 255) is
    begin
      green_intensity <= std_logic_vector(to_unsigned(green_intensity_i, 8));
      red_intensity <= std_logic_vector(to_unsigned(red_intensity_i, 8));
      blue_intensity <= std_logic_vector(to_unsigned(blue_intensity_i, 8));
    end procedure;
    
    procedure set_LED_white is
    begin
      set_GRB(5, 5, 5);
    end procedure;
    
    procedure set_LED_off is
    begin
      set_GRB(0, 0, 0);
    end procedure;
    
    procedure set_LED_green is
    begin
      set_GRB(10, 0, 0);
    end procedure;

    procedure set_LED_red is
    begin
      set_GRB(0, 10, 0);
    end procedure;
    
    procedure set_LED_blue is
    begin
      set_GRB(0, 0, 10);
    end procedure;

    procedure set_LED_yellow is
    begin
      set_GRB(5, 5, 0);
    end procedure;
  begin
  
    if enable = '1' then

        players_into_the_led := bool_to_logic(green_pos = led_number) & bool_to_logic(red_pos = led_number) & bool_to_logic(blue_pos = led_number) & bool_to_logic(yellow_pos = led_number);

        case players_into_the_led is
          when "0000" =>
            set_LED_off;
            
          when "1000" =>
            set_LED_green;
            
          when "0100" =>
            set_LED_red;
            
          when "0010" =>
            set_LED_blue;
            
          when "0001" =>
            set_LED_yellow;

          when others =>
            set_LED_white;
        end case;

    else
      green_intensity <= "ZZZZZZZZ";
      red_intensity <= "ZZZZZZZZ";
      blue_intensity <= "ZZZZZZZZ";
    end if;
  end process;

end architecture;
