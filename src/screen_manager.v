module screen_manager #(
    parameter MAX_POS = 109
)(
    input  wire green_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] green_cur_pos,
    input  wire red_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] red_cur_pos,
    input  wire blue_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] blue_cur_pos,
    input  wire yellow_ready_to_play,
    input  wire [$clog2(MAX_POS)-1:0] yellow_cur_pos,
    input  wire is_in_menu,
    input  wire [2:0] countdown,
    input  wire [$clog2(MAX_POS)-1:0] current_led,
    output wire [1:0] current_screen,
    output wire [7:0] led_green_intensity,
    output wire [7:0] led_red_intensity,
    output wire [7:0] led_blue_intensity
);

    router #(
        .MAX_POS(MAX_POS)
    ) router_inst (
        .green_cur_pos(green_cur_pos),
        .red_cur_pos(red_cur_pos),
        .blue_cur_pos(blue_cur_pos),
        .yellow_cur_pos(yellow_cur_pos),
        .is_in_menu(is_in_menu),
        .current_screen(current_screen)
    );

    screens #(
        .MAX_POS(MAX_POS)
    ) screens_inst (
        .green_ready_to_play(green_ready_to_play),
        .green_cur_pos(green_cur_pos),
        .red_ready_to_play(red_ready_to_play),
        .red_cur_pos(red_cur_pos),
        .blue_ready_to_play(blue_ready_to_play),
        .blue_cur_pos(blue_cur_pos),
        .yellow_ready_to_play(yellow_ready_to_play),
        .yellow_cur_pos(yellow_cur_pos),
        .countdown(countdown),
        .current_led(current_led),
        .current_screen(current_screen),
        .led_green_intensity(led_green_intensity),
        .led_red_intensity(led_red_intensity),
        .led_blue_intensity(led_blue_intensity)
    );

endmodule
