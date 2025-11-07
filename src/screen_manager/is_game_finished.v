`default_nettype none

module is_game_finished #(
    parameter MAX_POS = 109
)(
    input  wire is_in_menu,
    input  wire [$clog2(MAX_POS)-1:0] green_cur_pos,
    input  wire [$clog2(MAX_POS)-1:0] red_cur_pos,
    input  wire [$clog2(MAX_POS)-1:0] blue_cur_pos,
    input  wire [$clog2(MAX_POS)-1:0] yellow_cur_pos,
    output wire result
);

    assign result = (~is_in_menu) &&
                    ((green_cur_pos == MAX_POS-1) ||
                     (red_cur_pos == MAX_POS-1) ||
                     (blue_cur_pos == MAX_POS-1) ||
                     (yellow_cur_pos == MAX_POS-1));

endmodule
