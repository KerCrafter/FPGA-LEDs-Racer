`default_nettype none

module domain_unit #(
    parameter MAX_POS = 16,
    parameter MENU_TIMER_CLK_COUNT = 50000000,
    parameter END_TIMER_CLK_COUNT = 750000000
)(
    input  wire clk,
    input  wire reset,
    input  wire players_commands_red,
    input  wire players_commands_blue,
    input  wire players_commands_green,
    input  wire players_commands_yellow,
    input  wire [1:0] current_screen,
    output wire red_ready_to_play,
    output [$clog2(MAX_POS)-1:0] red_cur_pos,
    output wire blue_ready_to_play,
    output [$clog2(MAX_POS)-1:0] blue_cur_pos,
    output wire green_ready_to_play,
    output [$clog2(MAX_POS)-1:0] green_cur_pos,
    output wire yellow_ready_to_play,
    output [$clog2(MAX_POS)-1:0] yellow_cur_pos,
    output wire red_activity,
    output wire blue_activity,
    output wire green_activity,
    output wire yellow_activity,
    output wire menu_activity,
    output wire is_in_menu,
    output [2:0] countdown,
    output wire reset_all
);

    player_button #(
        .MAX_POS(MAX_POS)
    ) red_btn (
        .clk(clk),
        .btn(players_commands_red),
        .cur_pos(red_cur_pos),
        .activity(red_activity),
        .current_screen(current_screen),
        .ready_to_play(red_ready_to_play),
        .reset(reset_all)
    );

    player_button #(
        .MAX_POS(MAX_POS)
    ) blue_btn (
        .clk(clk),
        .btn(players_commands_blue),
        .cur_pos(blue_cur_pos),
        .activity(blue_activity),
        .current_screen(current_screen),
        .ready_to_play(blue_ready_to_play),
        .reset(reset_all)
    );

    player_button #(
        .MAX_POS(MAX_POS)
    ) green_btn (
        .clk(clk),
        .btn(players_commands_green),
        .cur_pos(green_cur_pos),
        .activity(green_activity),
        .current_screen(current_screen),
        .ready_to_play(green_ready_to_play),
        .reset(reset_all)
    );

    player_button #(
        .MAX_POS(MAX_POS)
    ) yellow_btn (
        .clk(clk),
        .btn(players_commands_yellow),
        .cur_pos(yellow_cur_pos),
        .activity(yellow_activity),
        .current_screen(current_screen),
        .ready_to_play(yellow_ready_to_play),
        .reset(reset_all)
    );

    menu_manager #(
        .MENU_TIMER_CLK_COUNT(MENU_TIMER_CLK_COUNT)
    ) menu_manager_inst (
        .clk(clk),
        .green_ready_to_play(green_ready_to_play),
        .red_ready_to_play(red_ready_to_play),
        .blue_ready_to_play(blue_ready_to_play),
        .yellow_ready_to_play(yellow_ready_to_play),
        .reset(reset_all),
        .is_in_menu(is_in_menu),
        .countdown(countdown),
        .activity(menu_activity)
    );

    end_game_logics #(
        .END_TIMER_CLK_COUNT(END_TIMER_CLK_COUNT)
    ) end_game_logics_inst (
        .clk(clk),
        .reset(reset),
        .current_screen(current_screen),
        .trigger_reset_all(reset_all)
    );

endmodule
