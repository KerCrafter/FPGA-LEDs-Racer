library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tt_um_kercrafter_leds_racer is
  port(
    ui_in   : in  std_logic_vector(7 downto 0);
    uo_out  : out std_logic_vector(7 downto 0);
    uio_in  : in  std_logic_vector(7 downto 0);
    uio_out : out std_logic_vector(7 downto 0);
    uio_oe  : out std_logic_vector(7 downto 0);
    ena     : in  std_logic;
    clk     : in  std_logic;
    rst_n   : in  std_logic
  );
end entity;

architecture structural of tt_um_kercrafter_leds_racer is
begin

  LEDs_racer_main: entity work.LEDs_racer_main
    generic map(max_pos => 109, DEBOUNCE_CLK_CNT => 65536)
    port map (
      clk => clk,
      green_input => ui_in(2),
      red_input => ui_in(1),
      blue_input => ui_in(0),
      yellow_input => ui_in(3),
      --force_reset => FORCE_RESET,

      leds_line => uo_out(0)
      --tp_screen_0 => TP_SCREEN_0,
      --tp_screen_1 => TP_SCREEN_1,
      --tp_blue_rtp => TP_BLUE_RTP,
      --tp_red_rtp => TP_RED_RTP,
      --tp_green_rtp => TP_GREEN_RTP,
      --tp_yellow_rtp => TP_YELLOW_RTP,
      --tp_update_frame => TP_UPDATE_FRAME
    );

end architecture;
