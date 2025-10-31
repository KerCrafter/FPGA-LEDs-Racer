module router #(
    parameter MAX_POS = 109
)(
    input wire [6:0] green_cur_pos,
    input wire [6:0] red_cur_pos,
    input wire [6:0] blue_cur_pos,
    input wire [6:0] yellow_cur_pos,
    input  wire is_in_menu,
    output reg [1:0] current_screen
);

    wire game_in_progress_screen;
    wire game_finished_screen;

    is_game_finished #(
        .MAX_POS(MAX_POS)
    ) is_game_finished_inst (
        .is_in_menu(is_in_menu),
        .green_cur_pos(green_cur_pos),
        .red_cur_pos(red_cur_pos),
        .blue_cur_pos(blue_cur_pos),
        .yellow_cur_pos(yellow_cur_pos),
        .result(game_finished_screen)
    );

    is_game_started #(
        .MAX_POS(MAX_POS)
    ) is_game_started_inst (
        .is_in_menu(is_in_menu),
        .green_cur_pos(green_cur_pos),
        .red_cur_pos(red_cur_pos),
        .blue_cur_pos(blue_cur_pos),
        .yellow_cur_pos(yellow_cur_pos),
        .result(game_in_progress_screen)
    );

    always @(*) begin
        if (is_in_menu)
            current_screen = 2'b00;
        else if (game_in_progress_screen)
            current_screen = 2'b01;
        else if (game_finished_screen)
            current_screen = 2'b10;
        else
            current_screen = 2'b11;
    end

endmodule
