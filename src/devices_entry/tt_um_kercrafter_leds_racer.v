`default_nettype none

module tt_um_kercrafter_leds_racer (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    LEDs_racer_main #(
        .MAX_POS(109),
        .DEBOUNCE_CLK_CNT(65536)
    ) LEDs_racer_main_inst (
        .clk(clk),
        .reset(~rst_n),
        .green_input(ui_in[2]),
        .red_input(ui_in[1]),
        .blue_input(ui_in[0]),
        .yellow_input(ui_in[3]),
        .leds_line(uo_out[0]),
        .tp_screen_0(uo_out[1]),
        .tp_screen_1(uo_out[2]),
        .tp_blue_ready_to_play(uo_out[3]),
        .tp_red_ready_to_play(uo_out[4]),
        .tp_green_ready_to_play(uo_out[5]),
        .tp_yellow_ready_to_play(uo_out[6]),
        .tp_update_frame(uo_out[7])
    );

    assign uio_out = 0;
    assign uio_oe  = 0;

    wire _unused = &{1'b0, ui_in[7:4], uio_in, ena};

endmodule
