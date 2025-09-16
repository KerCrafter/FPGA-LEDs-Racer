library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity menu_screen is
  generic (
    max_pos : integer := 109
  );

  port (
    enable : in std_logic;
    red_ready_to_play : in std_logic;
    blue_ready_to_play : in std_logic;
    green_ready_to_play : in std_logic;
    yellow_ready_to_play : in std_logic;
    
    led_number : in integer range 0 to max_pos-1;
  
    red_intensity : out std_logic_vector(7 downto 0);
    blue_intensity : out std_logic_vector(7 downto 0);
    green_intensity : out std_logic_vector(7 downto 0)
  );
end entity;

architecture beh of menu_screen is
begin

  process(enable, led_number, red_ready_to_play, blue_ready_to_play, green_ready_to_play)

    variable red_int : integer range 0 to 255;
    variable green_int : integer range 0 to 255;


    procedure set_GRB (green_intensity_i: integer range 0 to 255; red_intensity_i: integer range 0 to 255; blue_intensity_i: integer range 0 to 255) is
    begin
      green_intensity <= std_logic_vector(to_unsigned(green_intensity_i, 8));
      red_intensity <= std_logic_vector(to_unsigned(red_intensity_i, 8));
      blue_intensity <= std_logic_vector(to_unsigned(blue_intensity_i, 8));
    end procedure;

  begin
    if enable = '1' then

      if red_ready_to_play = '1' and led_number >= 1 and led_number <= 6 then
        red_int := 5;
      else
        red_int := 0;
      end if;


      if green_ready_to_play = '1' and led_number >= 8 and led_number <= 8 then
        green_int := 5;
      else
        green_int := 0;
      end if;

      set_GRB(green_int, red_int, 0);
    else

      green_intensity <= "ZZZZZZZZ";
      red_intensity <= "ZZZZZZZZ";
      blue_intensity <= "ZZZZZZZZ";

    end if;

  end process;

end architecture;
