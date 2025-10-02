library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipe_tri_bus is
  port(
    enable : in std_logic;

    i_led_green_intensity : in std_logic_vector(7 downto 0);
    i_led_red_intensity : in std_logic_vector(7 downto 0);
    i_led_blue_intensity : in std_logic_vector(7 downto 0);

    d_led_green_intensity : in std_logic_vector(7 downto 0);
    d_led_red_intensity : in std_logic_vector(7 downto 0);
    d_led_blue_intensity : in std_logic_vector(7 downto 0);

    o_led_green_intensity : out std_logic_vector(7 downto 0);
    o_led_red_intensity : out std_logic_vector(7 downto 0);
    o_led_blue_intensity : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of pipe_tri_bus is
begin
  o_led_green_intensity <= d_led_green_intensity when enable = '1' else i_led_green_intensity; 
  o_led_red_intensity <= d_led_red_intensity when enable = '1' else i_led_red_intensity; 
  o_led_blue_intensity <= d_led_blue_intensity when enable = '1' else i_led_blue_intensity; 
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity screens is
  generic (
    max_pos : integer := 109
  );

  port(
    green_ready_to_play : in std_logic;
    green_cur_pos : in integer range 0 to max_pos-1;
    red_ready_to_play : in std_logic;
    red_cur_pos : in integer range 0 to max_pos-1;
    blue_ready_to_play : in std_logic;
    blue_cur_pos : in integer range 0 to max_pos-1;
    yellow_ready_to_play : in std_logic;
    yellow_cur_pos : in integer range 0 to max_pos-1;

    countdown : in integer range 0 to 7;
    current_screen : in std_logic_vector(1 downto 0);
  
    current_led : in integer range 0 to max_pos-1;
    led_green_intensity : out std_logic_vector(7 downto 0);
    led_red_intensity : out std_logic_vector(7 downto 0);
    led_blue_intensity : out std_logic_vector(7 downto 0)
  );
end entity;

architecture structural of screens is
  signal is_menu : std_logic;
  signal is_gameplay : std_logic;
  signal is_finished : std_logic;
begin

  menu_screen: entity work.menu_screen
    generic map(max_pos => max_pos)
    port map(
      enable => is_menu,
      green_ready_to_play => green_ready_to_play,
      blue_ready_to_play => blue_ready_to_play,
      red_ready_to_play => red_ready_to_play,
      yellow_ready_to_play => yellow_ready_to_play,

      countdown => countdown,
      
      led_number => current_led,
    
      green_intensity => led_green_intensity,
      red_intensity => led_red_intensity,
      blue_intensity => led_blue_intensity
    );

  WS2812B_gameplay_program: entity work.WS2812B_gameplay_program
    generic map(max_pos => max_pos)
    port map(
      enable => is_gameplay,
      red_pos => red_cur_pos,
      blue_pos => blue_cur_pos,
      green_pos => green_cur_pos,
      yellow_pos => yellow_cur_pos,
      
      led_number => current_led,
    
      green_intensity => led_green_intensity,
      red_intensity => led_red_intensity,
      blue_intensity => led_blue_intensity
    );
    
  game_finished_program: entity work.game_finished_program
    generic map(max_pos => max_pos)
    port map(
      enable => is_finished,
      red_pos => red_cur_pos,
      blue_pos => blue_cur_pos,
      green_pos => green_cur_pos,
      yellow_pos => yellow_cur_pos,
      
      led_number => current_led,
    
      green_intensity => led_green_intensity,
      red_intensity => led_red_intensity,
      blue_intensity => led_blue_intensity
    );


  is_menu <= '1' when current_screen = "00" else '0';
  is_gameplay <= '1' when current_screen = "01" else '0';
  is_finished <= '1' when current_screen = "10" else '0';

end architecture;
