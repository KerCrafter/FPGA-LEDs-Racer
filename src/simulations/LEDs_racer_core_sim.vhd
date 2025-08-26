library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;

entity LEDs_racer_core_sim is
  port (
    test_status : out t_TEST_STATUS := TEST_STATUS_INIT
  );
end entity;

architecture simulation of LEDs_racer_core_sim is
  signal clk : std_logic := '1';

  signal red_input : std_logic := '0';
  signal blue_input : std_logic := '0';
  signal green_input : std_logic := '0';
  signal yellow_input : std_logic := '0';
  
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
  begin
    -- First Frame
    wait for 1 ns; current_led <= 1;
    wait for 1 ns; current_led <= 2;
    wait for 1 ns; current_led <= 3;
    wait for 1 ns; current_led <= 4;
    
    wait;
  end process;
  
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

      assert led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) report report_message severity failure;
    end procedure;

    procedure assert_LED_should_lightoff(message: string) is
    begin
      assert_GRB(0, 0, 0, message);
    end procedure;

    procedure assert_LED_should_be_white(message: string) is
    begin
      assert_GRB(5, 5, 5, message);
    end procedure;
  begin

    wait for 1 ps;
    assert_LED_should_be_white("LED 0 : should be WHITE");
    
    wait until current_led = 1; wait for 1 ps;
    assert_LED_should_lightoff("LED 1 : should be BLACK");

    wait until current_led = 2; wait for 1 ps;
    assert_LED_should_lightoff("LED 2 : should be BLACK");
    
    wait until current_led = 3; wait for 1 ps;
    assert_LED_should_lightoff("LED 3 : should be BLACK");
    
    wait until current_led = 4; wait for 1 ps;
    assert_LED_should_lightoff("LED 4 : should be BLACK");
  
    SIMULATION_END(test_status);
  end process;


  CHECK_UPDATE_FRAME: process
  begin
    wait for 1 ps;

    assert update_frame = '0' report "Update Frame should be LOW before 1st clk top" severity failure;

    wait until clk = '1'; wait for 1 ps;
    assert update_frame = '1' report "Update Frame should be HIGH after 1st clk top" severity failure;

    wait until clk = '0'; wait until clk = '1'; wait for 1 ps;
    assert update_frame = '0' report "Update Frame should be LOW after 2nd clk top" severity failure;
    
    wait;
  end process;

end architecture;
