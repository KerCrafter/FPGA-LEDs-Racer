module LEDs_racer_core #(
    parameter MAX_POS = 16,
    parameter MENU_TIMER_CLK_COUNT = 50000000,
    parameter END_TIMER_CLK_COUNT = 750000000
)(
    input  wire clk,
    input  wire players_commands_red,
    input  wire players_commands_blue,
    input  wire players_commands_green,
    input  wire players_commands_yellow,
    input  wire [$clog2(MAX_POS)-1:0] current_led,
    output wire [7:0] led_green_intensity,
    output wire [7:0] led_red_intensity,
    output wire [7:0] led_blue_intensity,
    output wire update_frame
);

    wire red_ready_to_play;
    wire [$clog2(MAX_POS)-1:0] red_cur_pos;
    wire blue_ready_to_play;
    wire [$clog2(MAX_POS)-1:0] blue_cur_pos;
    wire green_ready_to_play;
    wire [$clog2(MAX_POS)-1:0] green_cur_pos;
    wire yellow_ready_to_play;
    wire [$clog2(MAX_POS)-1:0] yellow_cur_pos;
    wire red_activity;
    wire blue_activity;
    wire green_activity;
    wire yellow_activity;
    wire menu_activity;
    wire [1:0] current_screen;
    wire is_in_menu;
    wire [$clog2(8)-1:0] countdown;
    wire reset_all;

    domain_unit #(
        .MAX_POS(MAX_POS),
        .MENU_TIMER_CLK_COUNT(MENU_TIMER_CLK_COUNT),
        .END_TIMER_CLK_COUNT(END_TIMER_CLK_COUNT)
    ) domain_unit_inst (
        .clk(clk),
        .players_commands_red(players_commands_red),
        .players_commands_blue(players_commands_blue),
        .players_commands_green(players_commands_green),
        .players_commands_yellow(players_commands_yellow),
        .current_screen(current_screen),
        .red_ready_to_play(red_ready_to_play),
        .red_cur_pos(red_cur_pos),
        .blue_ready_to_play(blue_ready_to_play),
        .blue_cur_pos(blue_cur_pos),
        .green_ready_to_play(green_ready_to_play),
        .green_cur_pos(green_cur_pos),
        .yellow_ready_to_play(yellow_ready_to_play),
        .yellow_cur_pos(yellow_cur_pos),
        .red_activity(red_activity),
        .blue_activity(blue_activity),
        .green_activity(green_activity),
        .yellow_activity(yellow_activity),
        .menu_activity(menu_activity),
        .is_in_menu(is_in_menu),
        .countdown(countdown),
        .reset_all(reset_all)
    );

    display_unit #(
        .MAX_POS(MAX_POS)
    ) display_unit_inst (
        .clk(clk),
        .current_led(current_led),
        .current_screen(current_screen),
        .red_ready_to_play(red_ready_to_play),
        .red_cur_pos(red_cur_pos),
        .blue_ready_to_play(blue_ready_to_play),
        .blue_cur_pos(blue_cur_pos),
        .green_ready_to_play(green_ready_to_play),
        .green_cur_pos(green_cur_pos),
        .yellow_ready_to_play(yellow_ready_to_play),
        .yellow_cur_pos(yellow_cur_pos),
        .red_activity(red_activity),
        .blue_activity(blue_activity),
        .green_activity(green_activity),
        .yellow_activity(yellow_activity),
        .menu_activity(menu_activity),
        .is_in_menu(is_in_menu),
        .countdown(countdown),
        .reset_all(reset_all),
        .led_green_intensity(led_green_intensity),
        .led_red_intensity(led_red_intensity),
        .led_blue_intensity(led_blue_intensity),
        .update_frame(update_frame)
    );

endmodule
