module DE0_NANO_LEDs_racer_main(
    input  wire clk,
    input  wire green_input,
    input  wire red_input,
    input  wire blue_input,
    input  wire yellow_input,
    output wire leds_line
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
        .leds_line(leds_line)
    );

endmodule

