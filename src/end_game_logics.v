`default_nettype none

module end_game_logics #(
    parameter END_TIMER_CLK_COUNT = 1
)(
    input  wire clk,
    input  wire reset,
    input  wire [1:0] current_screen,
    output wire trigger_reset_all
);

    wire end_timer_enable;

    timer #(
        .CLK_COUNT(END_TIMER_CLK_COUNT),
        .FIRST_TICK_AFTER_DELAY(1)
    ) TIMER_inst (
        .clk(clk),
        .reset(reset),
        .enable(end_timer_enable),
        .tick(trigger_reset_all)
    );

    assign end_timer_enable = (current_screen == 2'b10) ? 1'b1 : 1'b0;

endmodule
