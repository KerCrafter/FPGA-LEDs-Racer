library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sut_pkg.all;

entity LEDs_racer_core_SUT is
  port(
    sut_interface : inout LEDs_racer_core_SUT_interface
  );
end entity;

architecture structural of LEDs_racer_core_SUT is
begin

  SUT: entity work.LEDs_racer_core
    generic map(
      max_pos => 109,
      MENU_TIMER_CLK_COUNT => 5
    )
    port map (
      clk => sut_interface.clk,

      players_commands => sut_interface.players_commands,
    
      current_led => sut_interface.current_led,
      led_green_intensity => sut_interface.led_green_intensity,
      led_red_intensity => sut_interface. led_red_intensity,
      led_blue_intensity => sut_interface.led_blue_intensity,
      update_frame => sut_interface.update_frame
    );

end architecture;
