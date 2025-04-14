library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LEDs_racer_core_yellow_wins_tb is
end entity;

architecture simulation of LEDs_racer_core_yellow_wins_tb is
  signal clk : std_logic := '0';

  signal red_input : std_logic;
  signal blue_input : std_logic;
  signal green_input : std_logic;
  signal yellow_input : std_logic;
  
  signal current_led : integer range 0 to 4;
  signal led_green_intensity : std_logic_vector(7 downto 0);
  signal led_red_intensity : std_logic_vector(7 downto 0);
  signal led_blue_intensity : std_logic_vector(7 downto 0);
  
  signal update_frame : std_logic;
begin
  UUT: entity work.LEDs_racer_core
    generic map(max_pos => 5)
    port map (
      clk => clk,

      green_input => green_input,
      red_input => red_input,
      blue_input => blue_input,
      yellow_input => yellow_input,
      
      current_led => current_led,
      led_green_intensity => led_green_intensity,
      led_red_intensity => led_red_intensity,
      led_blue_intensity => led_blue_intensity,
      update_frame => update_frame
    );
  
  PLAYS_STIM: process
    procedure assert_GRB(
      led_green_intensity_i: integer range 0 to 255;
      led_red_intensity_i: integer range 0 to 255;
      led_blue_intensity_i: integer range 0 to 255;
      report_message: string
    ) is
    begin
      assert led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) report report_message;
    end procedure;
    
    procedure YELLOW_player_press_his_button_during(duration: time) is
    begin
      wait for 20 ns;
    
      yellow_input <= '1';
      wait for duration;
      yellow_input <= '0';
    end procedure;

    procedure GREEN_player_press_his_button_during(duration: time) is
    begin
      wait for 20 ns;
    
      green_input <= '1';
      wait for duration;
      green_input <= '0';
    end procedure;

    procedure RED_player_press_his_button_during(duration: time) is
    begin
      wait for 20 ns;
    
      red_input <= '1';
      wait for duration;
      red_input <= '0';
    end procedure;

    procedure BLUE_player_press_his_button_during(duration: time) is
    begin
      wait for 20 ns;
    
      blue_input <= '1';
      wait for duration;
      blue_input <= '0';
    end procedure;
    
    procedure assert_all_LEDs_should_be_YELLOW is
    begin
      wait for 20 ns; current_led <= 0; wait for 1 ps; assert_GRB(5, 5, 0, "LED 0 : should be YELLOW");
      wait for 20 ns; current_led <= 1; wait for 1 ps; assert_GRB(5, 5, 0, "LED 1 : should be YELLOW");
      wait for 20 ns; current_led <= 2; wait for 1 ps; assert_GRB(5, 5, 0, "LED 2 : should be YELLOW");
      wait for 20 ns; current_led <= 3; wait for 1 ps; assert_GRB(5, 5, 0, "LED 3 : should be YELLOW");
      wait for 20 ns; current_led <= 4; wait for 1 ps; assert_GRB(5, 5, 0, "LED 4 : should be YELLOW");
    end procedure;
  begin 
    YELLOW_player_press_his_button_during(20 ns); --YELLOW Player, UP from position 0 to 1
    YELLOW_player_press_his_button_during(20 ns); --YELLOW Player, UP from position 1 to 2
    YELLOW_player_press_his_button_during(20 ns); --YELLOW Player, UP from position 2 to 3
    YELLOW_player_press_his_button_during(20 ns); --YELLOW Player, UP from position 3 to 4
    
    assert_all_LEDs_should_be_YELLOW;

    -- Game is END Should lock YELLOW actions
    YELLOW_player_press_his_button_during(20 ns); --YELLOW player STAY in position 4

    assert_all_LEDs_should_be_YELLOW;


    -- try move GREEN player
    GREEN_player_press_his_button_during(20 ns);
    GREEN_player_press_his_button_during(20 ns);
    GREEN_player_press_his_button_during(20 ns);
    GREEN_player_press_his_button_during(20 ns);
    
    assert_all_LEDs_should_be_YELLOW;

    -- try move RED player
    RED_player_press_his_button_during(20 ns);
    RED_player_press_his_button_during(20 ns);
    RED_player_press_his_button_during(20 ns);
    RED_player_press_his_button_during(20 ns);
    
    assert_all_LEDs_should_be_YELLOW;

    -- try move BLUE player
    BLUE_player_press_his_button_during(20 ns);
    BLUE_player_press_his_button_during(20 ns);
    BLUE_player_press_his_button_during(20 ns);
    BLUE_player_press_his_button_during(20 ns);
    
    assert_all_LEDs_should_be_YELLOW;
    
    wait;
  end process;
  
  CLK_STIM: process
  begin
    -- Inverse CLK every 10ns = 20ns per cycle = 50MHz
    clk <= not clk; wait for 10 ns;
  end process;

end architecture;
