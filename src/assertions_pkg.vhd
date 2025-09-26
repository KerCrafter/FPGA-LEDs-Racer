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

  procedure assert_all_LEDs_should_be_BLUE(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_all_LEDs_should_be_RED(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_all_LEDs_should_be_GREEN(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_all_LEDs_should_be_YELLOW(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_all_LEDs_should_lightoff(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_LED_should_lightoff(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  );

  procedure assert_LED_should_be_red(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  );

  procedure assert_LED_should_be_blue(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  );

  procedure assert_LED_should_be_white(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  );

  procedure assert_LED_should_be_green(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  );

  procedure assert_LED_should_be_yellow(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  );

  procedure assert_LED_should_be_green_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_LED_should_be_red_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_LED_should_be_blue_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_LED_should_be_yellow_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  );

  procedure assert_LED_should_lightoff_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
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

    assert sut.led_green_intensity = std_logic_vector(to_unsigned(led_green_intensity_i, 8)) and sut.led_red_intensity = std_logic_vector(to_unsigned(led_red_intensity_i, 8)) and sut.led_blue_intensity = std_logic_vector(to_unsigned(led_blue_intensity_i, 8)) report report_message;

  end procedure;

  procedure assert_all_LEDs_should_be_RED(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin

    for led_number in 0 to 108 loop
      wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 0, 10, 0, "LED " & to_string(led_number) & ": should be RED");
    end loop;

  end procedure;

  procedure assert_all_LEDs_should_be_YELLOW(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin

    for led_number in 0 to 108 loop
      wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 5, 5, 0, "LED " & to_string(led_number) & ": should be YELLOW");
    end loop;

  end procedure;

  procedure assert_all_LEDs_should_lightoff(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin

    for led_number in 0 to 108 loop
      wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 0, 0, 0, "LED " & to_string(led_number) & ": should be Light OFF");
    end loop;

  end procedure;

  procedure assert_LED_should_lightoff(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  ) is
  begin
    wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 0, 0, 0, "LED " & to_string(led_number) & ": should be Light OFF");
  end procedure;

  procedure assert_LED_should_be_red(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  ) is
  begin
    wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 0, 5, 0, "LED " & to_string(led_number) & ": should be RED");
  end procedure;

  procedure assert_LED_should_be_white(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  ) is
  begin
    wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 5, 5, 5, "LED " & to_string(led_number) & ": should be WHITE");
  end procedure;

  procedure assert_LED_should_be_green(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  ) is
  begin
    wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 5, 0, 0, "LED " & to_string(led_number) & ": should be GREEN");
  end procedure;

  procedure assert_LED_should_be_blue(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  ) is
  begin
    wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 0, 0, 5, "LED " & to_string(led_number) & ": should be BLUE");
  end procedure;

  procedure assert_LED_should_be_yellow(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS;
    led_number: integer range 0 to 108
  ) is
  begin
    wait for 20 ns; current_led <= led_number; wait for 1 ps; assert_GRB(sut, test_status, 5, 5, 0, "LED " & to_string(led_number) & ": should be YELLOW");
  end procedure;

  procedure assert_LED_should_be_green_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    for led_number in from_led to to_led loop
      assert_LED_should_be_green(SUT, current_led_sig, test_status, led_number);
    end loop;
  end procedure;

  procedure assert_LED_should_be_red_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    for led_number in from_led to to_led loop
      assert_LED_should_be_red(SUT, current_led_sig, test_status, led_number);
    end loop;
  end procedure;

  procedure assert_LED_should_be_blue_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    for led_number in from_led to to_led loop
      assert_LED_should_be_blue(SUT, current_led_sig, test_status, led_number);
    end loop;
  end procedure;

  procedure assert_LED_should_be_yellow_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    for led_number in from_led to to_led loop
      assert_LED_should_be_yellow(SUT, current_led_sig, test_status, led_number);
    end loop;
  end procedure;

  procedure assert_LED_should_lightoff_for_range(
    from_led: integer range 0 to 108;
    to_led: integer range 0 to 108;
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led_sig: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    for led_number in from_led to to_led loop
      assert_LED_should_lightoff(SUT, current_led_sig, test_status, led_number);
    end loop;
  end procedure;

  procedure assert_all_LEDs_should_be_GREEN(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    assert_LED_should_be_green_for_range(
      from_led => 0,
      to_led => 108,
      sut => sut,
      current_led_sig => current_led,
      test_status => test_status
    );
  end procedure;

  procedure assert_all_LEDs_should_be_BLUE(
    signal sut: in LEDs_racer_core_sut_interface;
    signal current_led: out integer range 0 to 108;
    signal test_status: out t_TEST_STATUS
  ) is
  begin
    assert_LED_should_be_blue_for_range(
      from_led => 0,
      to_led => 108,
      sut => sut,
      current_led_sig => current_led,
      test_status => test_status
    );
  end procedure;


end package body;
