module DE0_NANO_LEDs_racer_main(
    input  wire clk,
    input  wire green_input,
    input  wire red_input,
    input  wire blue_input,
    input  wire yellow_input,
    output wire leds_line,
    output wire tp_update_frame,
    output wire tp_blue_ready_to_play,
    output wire tp_green_ready_to_play,
    output wire tp_yellow_ready_to_play,
    output wire tp_red_ready_to_play,
    output wire tp_screen_0,
    output wire tp_screen_1
);

    LEDs_racer_main #(
        .MAX_POS(109),
        .DEBOUNCE_CLK_CNT(65536)
    ) u_LEDs_racer_main (
        .clk(clk),
        .reset(0),
        .green_input(green_input),
        .red_input(red_input),
        .blue_input(blue_input),
        .yellow_input(yellow_input),
        .leds_line(leds_line),
        .tp_update_frame(tp_update_frame),
        .tp_blue_ready_to_play(tp_blue_ready_to_play),
        .tp_green_ready_to_play(tp_green_ready_to_play),
        .tp_yellow_ready_to_play(tp_yellow_ready_to_play),
        .tp_red_ready_to_play(tp_red_ready_to_play),
        .tp_screen_0(tp_screen_0),
        .tp_screen_1(tp_screen_1)
    );

endmodule

