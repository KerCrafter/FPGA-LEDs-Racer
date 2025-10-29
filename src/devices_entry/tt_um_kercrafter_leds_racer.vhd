library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_um_kercrafter_leds_racer is
  port(
    CLK : in std_logic;
    
    GREEN_BTN : in std_logic;
    RED_BTN : in std_logic;
    BLUE_BTN : in std_logic;
    YELLOW_BTN : in std_logic;
    FORCE_RESET: in std_logic;

    LEDS_LINE : out std_logic;
    TP_SCREEN_0 : out std_logic;
    TP_SCREEN_1 : out std_logic;
    TP_BLUE_RTP : out std_logic;
    TP_RED_RTP : out std_logic;
    TP_GREEN_RTP : out std_logic;
    TP_YELLOW_RTP : out std_logic;
    TP_UPDATE_FRAME : out std_logic
  );
end entity;

architecture structural of tt_um_kercrafter_leds_racer is
begin

  LEDs_racer_main: entity work.LEDs_racer_main
    generic map(max_pos => 109, DEBOUNCE_CLK_CNT => 65536)
    port map (
      clk => CLK,
      green_input => GREEN_BTN,
      red_input => GREEN_BTN,
      blue_input => BLUE_BTN,
      yellow_input => YELLOW_BTN,
      --force_reset => FORCE_RESET,

      leds_line => LEDS_LINE
      --tp_screen_0 => TP_SCREEN_0,
      --tp_screen_1 => TP_SCREEN_1,
      --tp_blue_rtp => TP_BLUE_RTP,
      --tp_red_rtp => TP_RED_RTP,
      --tp_green_rtp => TP_GREEN_RTP,
      --tp_yellow_rtp => TP_YELLOW_RTP,
      --tp_update_frame => TP_UPDATE_FRAME
    );

end architecture;
