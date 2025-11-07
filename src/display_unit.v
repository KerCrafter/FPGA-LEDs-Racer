`default_nettype none

module display_unit #(
    parameter MAX_POS = 16
)(
    input  wire clk,
    input  wire [$clog2(MAX_POS)-1:0] current_led,
    input  wire red_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] red_cur_pos,
    input  wire blue_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] blue_cur_pos,
    input  wire green_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] green_cur_pos,
    input  wire yellow_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] yellow_cur_pos,
    input  wire red_activity,
    input  wire blue_activity,
    input  wire green_activity,
    input  wire yellow_activity,
    input  wire menu_activity,
    input  wire is_in_menu,
    input  wire [2:0] countdown,
    input  wire reset_all,
    output wire [1:0] current_screen,
    output wire [7:0] led_green_intensity,
    output wire [7:0] led_red_intensity,
    output wire [7:0] led_blue_intensity,
    output wire update_frame
);

    activity_detector activity_detector_inst (
        .clk(clk),
        .reset(reset_all),
        .A(green_activity),
        .B(red_activity),
        .C(blue_activity),
        .D(yellow_activity),
        .E(menu_activity),
        .F(reset_all),
        .R(update_frame)
    );

    screen_manager #(
        .MAX_POS(MAX_POS)
    ) screen_manager_inst (
        .current_screen(current_screen),
        .green_ready_to_play(green_ready_to_play),
        .green_cur_pos(green_cur_pos),
        .red_ready_to_play(red_ready_to_play),
        .red_cur_pos(red_cur_pos),
        .blue_ready_to_play(blue_ready_to_play),
        .blue_cur_pos(blue_cur_pos),
        .yellow_ready_to_play(yellow_ready_to_play),
        .yellow_cur_pos(yellow_cur_pos),
        .is_in_menu(is_in_menu),
        .countdown(countdown),
        .current_led(current_led),
        .led_green_intensity(led_green_intensity),
        .led_red_intensity(led_red_intensity),
        .led_blue_intensity(led_blue_intensity)
    );

endmodule
