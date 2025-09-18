library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.players_commands_pkg.all;
use work.player_interactions_test_pkg.all;

entity LEDs_racer_core_menu_red_and_green_ready_to_play_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_menu_red_and_green_ready_to_play_sim is
  signal clk : std_logic := '1';

  signal players_commands : t_PLAYERS_COMMANDS := PLAYERS_COMMANDS_INIT;
  
  signal current_led : integer range 0 to 108;
  signal led_green_intensity : std_logic_vector(7 downto 0);
  signal led_red_intensity : std_logic_vector(7 downto 0);
  signal led_blue_intensity : std_logic_vector(7 downto 0);
  
  signal update_frame : std_logic;
begin
  UUT: entity work.LEDs_racer_core
    generic map(max_pos => 109)
    port map (
      clk => clk,

      players_commands => players_commands,
      
      opt_with_menu => '1',
      
      current_led => current_led,
      led_green_intensity => led_green_intensity,
      led_red_intensity => led_red_intensity,
      led_blue_intensity => led_blue_intensity,
      update_frame => update_frame
    );
  
  CLK_STIM: process
  begin
    -- Inverse CLK every 10ns = 20ns per cycle = 50MHz
    clk <= not clk; wait for 10 ns;
  end process;
  
  CHECK_SIG: process

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

    procedure assert_LED_should_lightoff(led_number : integer) is
    begin
      current_led <= led_number; wait for 1 ps;
      assert_GRB(0, 0, 0, "LED " & to_string(led_number) & " : should light off");
    end procedure;

    procedure assert_LED_should_be_white(led_number : integer) is
    begin
      current_led <= led_number; wait for 1 ps;
      assert_GRB(5, 5, 5, "LED " & to_string(led_number) & " : should be WHITE");
    end procedure;

    procedure assert_LED_should_be_red(led_number : integer) is
    begin
      current_led <= led_number; wait for 1 ps;
      assert_GRB(0, 5, 0, "LED " & to_string(led_number) & " : should be RED");
    end procedure;

    procedure assert_LED_should_be_green(led_number : integer) is
    begin
      current_led <= led_number; wait for 1 ps;
      assert_GRB(5, 0, 0, "LED " & to_string(led_number) & " : should be GREEN");
    end procedure;

  begin
    player_press_his_button_during(20 ns, players_commands.red);
    player_press_his_button_during(20 ns, players_commands.green);

    assert_LED_should_be_white(0);

    assert_LED_should_be_red(1);

    assert_LED_should_be_red(2);

    assert_LED_should_be_red(3);

    assert_led_should_be_red(4);
    
    assert_led_should_be_red(5);

    assert_led_should_be_red(6);

    assert_LED_should_be_white(7);

    assert_LED_should_be_green(8);

    assert_LED_should_be_green(9);

    assert_LED_should_be_green(10);

    assert_LED_should_be_green(11);
    
    assert_LED_should_be_green(12);

    assert_LED_should_be_green(13);

    assert_LED_should_be_white(14);

    assert_LED_should_be_white(21);

    --Ring 2
    assert_LED_should_be_white(28);

    assert_LED_should_be_white(34);

    assert_LED_should_be_white(40);

    assert_LED_should_be_white(46);

    -- Ring 3

    assert_LED_should_be_white(52);

    assert_LED_should_be_white(57);

    assert_LED_should_be_white(62);

    assert_LED_should_be_white(67);

    -- Ring 4

    assert_LED_should_be_white(72);

    assert_LED_should_be_white(76);

    assert_LED_should_be_white(80);

    assert_LED_should_be_white(84);

    -- Ring 5

    assert_LED_should_be_white(88);

    assert_LED_should_be_white(91);

    assert_LED_should_be_white(94);

    assert_LED_should_be_white(97);

    -- Ring 6

    assert_LED_should_be_white(100);

    assert_LED_should_be_white(102);

    assert_LED_should_be_white(104);

    assert_LED_should_be_white(106);

    -- Ring 7
    assert_LED_should_be_white(108);


    SIMULATION_END(test_status);
  end process;

end architecture;
