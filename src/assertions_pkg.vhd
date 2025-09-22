library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_status_pkg.all;
use work.sut_pkg.all;

package assertions_pkg is

  procedure assert_GRB(
    signal sut: in LEDs_racer_core_sut_interface;
    signal test_status: out t_TEST_STATUS;
    led_green_intensity_i: integer range 0 to 255;
    led_red_intensity_i: integer range 0 to 255;
    led_blue_intensity_i: integer range 0 to 255;
    report_message: string
  );

end package;

package body assertions_pkg is

  procedure assert_GRB(
    signal sut: in LEDs_racer_core_sut_interface;
    signal test_status: out t_TEST_STATUS;
    led_green_intensity_i: integer range 0 to 255;
    led_red_intensity_i: integer range 0 to 255;
    led_blue_intensity_i: integer range 0 to 255;
    report_message: string
  ) is
  begin

    if sut.led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and sut.led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and sut.led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) then
    else
      SIMULATION_FAIL(test_status);
    end if;

    assert sut.led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and sut.led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and sut.led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) report report_message severity failure;

  end procedure;

end package body;
