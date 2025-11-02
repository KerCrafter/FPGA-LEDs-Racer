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
        //.force_reset(FORCE_RESET),
        .leds_line(uo_out[0])
        //.tp_screen_0(TP_SCREEN_0),
        //.tp_screen_1(TP_SCREEN_1),
        //.tp_blue_rtp(TP_BLUE_RTP),
        //.tp_red_rtp(TP_RED_RTP),
        //.tp_green_rtp(TP_GREEN_RTP),
        //.tp_yellow_rtp(TP_YELLOW_RTP),
        //.tp_update_frame(TP_UPDATE_FRAME)
    );

    assign uo_out[1] = 1'b0;
    assign uo_out[2] = 1'b0;
    assign uo_out[3] = 1'b0;
    assign uo_out[4] = 1'b0;
    assign uo_out[5] = 1'b0;
    assign uo_out[6] = 1'b0;
    assign uo_out[7] = 1'b0;
    assign uio_out = 0;
    assign uio_oe  = 0;

    wire _unused = &{ena, 1'b0};

endmodule
