library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DE0_NANO_LEDs_racer_main is
  port(
    clk : in std_logic;
    
    green_input : in std_logic;
    red_input : in std_logic;
    blue_input : in std_logic;
    yellow_input : in std_logic;

    leds_line : out std_logic
  );
end entity;

architecture structural of DE0_NANO_LEDs_racer_main is
begin

  LEDs_racer_main: entity work.LEDs_racer_main
    generic map(max_pos => 109, DEBOUNCE_CLK_CNT => 65536)
    port map (
      clk => clk,
      green_input => green_input,
      red_input => red_input,
      blue_input => blue_input,
      yellow_input => yellow_input,

      leds_line => leds_line
    );

end architecture;
