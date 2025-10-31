module LEDs_racer_main #(
    parameter MAX_POS = 109,
    parameter DEBOUNCE_CLK_CNT = 65536
)(
    input  wire clk,
    input  wire green_input,
    input  wire red_input,
    input  wire blue_input,
    input  wire yellow_input,
    output wire leds_line
);

    wire [$clog2(MAX_POS)-1:0] led_proceed;
    wire update_frame;
    wire [7:0] red_intensity;
    wire [7:0] blue_intensity;
    wire [7:0] green_intensity;

    wire players_commands_green;
    wire players_commands_red;
    wire players_commands_blue;
    wire players_commands_yellow;

    button_debouncer #(
        .DEBOUNCE_CLK_CNT(DEBOUNCE_CLK_CNT)
    ) green_debouncer (
        .clk(clk),
        .btn_in(green_input),
        .btn_debounced(players_commands_green)
    );

    button_debouncer #(
        .DEBOUNCE_CLK_CNT(DEBOUNCE_CLK_CNT)
    ) red_debouncer (
        .clk(clk),
        .btn_in(red_input),
        .btn_debounced(players_commands_red)
    );

    button_debouncer #(
        .DEBOUNCE_CLK_CNT(DEBOUNCE_CLK_CNT)
    ) blue_debouncer (
        .clk(clk),
        .btn_in(blue_input),
        .btn_debounced(players_commands_blue)
    );

    button_debouncer #(
        .DEBOUNCE_CLK_CNT(DEBOUNCE_CLK_CNT)
    ) yellow_debouncer (
        .clk(clk),
        .btn_in(yellow_input),
        .btn_debounced(players_commands_yellow)
    );

    WS2812B_driver #(
        .MAX_POS(MAX_POS)
    ) WS2812B_driver_inst (
        .clk(clk),
        .leds_line(leds_line),
        .program_led_number(led_proceed),
        .program_red_intensity(red_intensity),
        .program_blue_intensity(blue_intensity),
        .program_green_intensity(green_intensity),
        .update_frame(update_frame)
    );

    LEDs_racer_core #(
        .MAX_POS(MAX_POS)
    ) LEDs_racer_core_inst (
        .clk(clk),
        .update_frame(update_frame),
        .players_commands_green(players_commands_green),
        .players_commands_red(players_commands_red),
        .players_commands_blue(players_commands_blue),
        .players_commands_yellow(players_commands_yellow),
        .current_led(led_proceed),
        .led_green_intensity(green_intensity),
        .led_red_intensity(red_intensity),
        .led_blue_intensity(blue_intensity)
    );

endmodule
