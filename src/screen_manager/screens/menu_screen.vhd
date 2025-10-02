library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity menu_screen is
  generic (
    max_pos : integer := 109
  );

  port (
    red_ready_to_play : in std_logic;
    blue_ready_to_play : in std_logic;
    green_ready_to_play : in std_logic;
    yellow_ready_to_play : in std_logic;

    countdown : in integer range 0 to 7;
    
    led_number : in integer range 0 to max_pos-1;
  
    red_intensity : out std_logic_vector(7 downto 0);
    blue_intensity : out std_logic_vector(7 downto 0);
    green_intensity : out std_logic_vector(7 downto 0)
  );
end entity;

architecture beh of menu_screen is
begin

  process(led_number, red_ready_to_play, blue_ready_to_play, green_ready_to_play, yellow_ready_to_play, countdown)
    procedure set_GRB (green_intensity_i: integer range 0 to 255; red_intensity_i: integer range 0 to 255; blue_intensity_i: integer range 0 to 255) is
    begin
      green_intensity <= std_logic_vector(to_unsigned(green_intensity_i, 8));
      red_intensity <= std_logic_vector(to_unsigned(red_intensity_i, 8));
      blue_intensity <= std_logic_vector(to_unsigned(blue_intensity_i, 8));
    end procedure;
    
    variable countdown_ring_1 : boolean;
    variable countdown_ring_2 : boolean;
    variable countdown_ring_3 : boolean;
    variable countdown_ring_4 : boolean;
    variable countdown_ring_5 : boolean;
    variable countdown_ring_6 : boolean;
    variable countdown_ring_7 : boolean;

  begin
    countdown_ring_1 := led_number = 0 or led_number = 7 or led_number = 14 or led_number = 21;
    countdown_ring_2 := led_number = 28 or led_number = 34 or led_number = 40 or led_number = 46;
    countdown_ring_3 := led_number = 52 or led_number = 57 or led_number = 62 or led_number = 67;
    countdown_ring_4 := led_number = 72 or led_number = 76 or led_number = 80 or led_number = 84;
    countdown_ring_5 := led_number = 88 or led_number = 91 or led_number = 94 or led_number = 97;
    countdown_ring_6 := led_number = 100 or led_number = 102 or led_number = 104 or led_number = 106;
    countdown_ring_7 := led_number = 108;

    if countdown_ring_1 and countdown >= 7 then
      set_GRB(5, 5, 5);
    elsif countdown_ring_2 and countdown >= 6 then
      set_GRB(5, 5, 5);
    elsif countdown_ring_3 and countdown >= 5 then
      set_GRB(5, 5, 5);
    elsif countdown_ring_4 and countdown >= 4 then
      set_GRB(5, 5, 5);
    elsif countdown_ring_5 and countdown >= 3 then
      set_GRB(5, 5, 5);
    elsif countdown_ring_6 and countdown >= 2 then
      set_GRB(5, 5, 5);
    elsif countdown_ring_7 and countdown >= 1 then
      set_GRB(5, 5, 5);
    elsif red_ready_to_play = '1' and led_number >= 1 and led_number <= 6 then
      set_GRB(0, 5, 0);
    elsif green_ready_to_play = '1' and led_number >= 8 and led_number <= 13 then
      set_GRB(5, 0, 0);
    elsif blue_ready_to_play = '1' and led_number >= 15 and led_number <= 20 then
      set_GRB(0, 0, 5);
    elsif yellow_ready_to_play = '1' and led_number >= 22 and led_number <= 27 then
      set_GRB(5, 5, 0);
    else
      set_GRB(0, 0, 0);
    end if;

  end process;

end architecture;
