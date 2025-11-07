`default_nettype none

module ready_trigger_countdown (
    input  wire green_ready_to_play,
    input  wire red_ready_to_play,
    input  wire blue_ready_to_play,
    input  wire yellow_ready_to_play,
    output wire result
);

    assign result = ((green_ready_to_play + blue_ready_to_play + red_ready_to_play + yellow_ready_to_play) > 1) ? 1'b1 : 1'b0;

endmodule
