library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.player_interactions_test_pkg.all;

entity LEDs_racer_core_green_wins_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_green_wins_sim is
  signal clk : std_logic := '0';

  signal red_input : std_logic := '0';
  signal blue_input : std_logic := '0';
  signal green_input : std_logic := '0';
  signal yellow_input : std_logic := '0';
  
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

      if led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) then
      else
        SIMULATION_FAIL(test_status);
      end if;

      assert led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) report report_message;
    end procedure;
    
    procedure assert_all_LEDs_should_be_GREEN is
    begin
      wait for 20 ns; current_led <= 0; wait for 1 ps; assert_GRB(10, 0, 0, "LED 0 : should be GREEN");
      wait for 20 ns; current_led <= 1; wait for 1 ps; assert_GRB(10, 0, 0, "LED 1 : should be GREEN");
      wait for 20 ns; current_led <= 2; wait for 1 ps; assert_GRB(10, 0, 0, "LED 2 : should be GREEN");
      wait for 20 ns; current_led <= 3; wait for 1 ps; assert_GRB(10, 0, 0, "LED 3 : should be GREEN");
      wait for 20 ns; current_led <= 4; wait for 1 ps; assert_GRB(10, 0, 0, "LED 4 : should be GREEN");
    end procedure;

  begin
    player_press_his_button_during(20 ns, green_input); --GREEN Player, UP from position 0 to 1
    player_press_his_button_during(20 ns, green_input); --GREEN Player, UP from position 1 to 2
    player_press_his_button_during(20 ns, green_input); --GREEN Player, UP from position 2 to 3
    player_press_his_button_during(20 ns, green_input); --GREEN Player, UP from position 3 to 4
    
    assert_all_LEDs_should_be_GREEN;

    -- Game is END Should lock GREEN actions
    player_press_his_button_during(20 ns, green_input); --GREEN player STAY in position 4

    assert_all_LEDs_should_be_GREEN;

    --Try move the RED player
    player_press_his_button_during(20 ns, red_input);
    player_press_his_button_during(20 ns, red_input);
    player_press_his_button_during(20 ns, red_input);
    player_press_his_button_during(20 ns, red_input);

    assert_all_LEDs_should_be_GREEN;

    --Try move the BLUE player
    player_press_his_button_during(20 ns, blue_input);
    player_press_his_button_during(20 ns, blue_input);
    player_press_his_button_during(20 ns, blue_input);
    player_press_his_button_during(20 ns, blue_input);

    assert_all_LEDs_should_be_GREEN;

    --Try move the YELLOW player
    player_press_his_button_during(20 ns, yellow_input);
    player_press_his_button_during(20 ns, yellow_input);
    player_press_his_button_during(20 ns, yellow_input);
    player_press_his_button_during(20 ns, yellow_input);

    assert_all_LEDs_should_be_GREEN;

    SIMULATION_END(test_status);
  end process;
  
  CLK_STIM: process
  begin
    -- Inverse CLK every 10ns = 20ns per cycle = 50MHz
    clk <= not clk; wait for 10 ns;
  end process;

end architecture;
