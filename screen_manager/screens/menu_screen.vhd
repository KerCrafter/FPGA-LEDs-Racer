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

  green_intensity <= "00000000" when enable = '1' else "ZZZZZZZZ";
  red_intensity <= "00000000" when enable = '1' else "ZZZZZZZZ";
  blue_intensity <= "00000000" when enable = '1' else "ZZZZZZZZ";

end architecture;
