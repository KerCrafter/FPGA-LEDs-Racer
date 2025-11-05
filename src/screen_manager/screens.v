module screens #(
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
    input  wire [2:0] countdown,
    input  [1:0] current_screen,
    input  wire [$clog2(MAX_POS)-1:0] current_led,
    output wire [7:0] led_green_intensity,
    output wire [7:0] led_red_intensity,
    output wire [7:0] led_blue_intensity
);

    wire is_menu;
    wire is_gameplay;
    wire is_finished;

    wire [7:0] j1_led_green_intensity, j1_led_red_intensity, j1_led_blue_intensity;
    wire [7:0] j2_led_green_intensity, j2_led_red_intensity, j2_led_blue_intensity;

    assign is_menu = (current_screen == 2'b00);
    assign is_gameplay = (current_screen == 2'b01);
    assign is_finished = (current_screen == 2'b10);

    menu_screen #(
        .MAX_POS(MAX_POS)
    ) menu_screen_inst (
        .enable(is_menu),
        .green_ready_to_play(green_ready_to_play),
        .blue_ready_to_play(blue_ready_to_play),
        .red_ready_to_play(red_ready_to_play),
        .yellow_ready_to_play(yellow_ready_to_play),
        .countdown(countdown),
        .led_number(current_led),
        .i_green_intensity(0),
        .i_red_intensity(0),
        .i_blue_intensity(0),
        .o_green_intensity(j1_led_green_intensity),
        .o_red_intensity(j1_led_red_intensity),
        .o_blue_intensity(j1_led_blue_intensity)
    );

    gameplay_screen #(
        .MAX_POS(MAX_POS)
    ) gameplay_screen_inst (
        .enable(is_gameplay),
        .red_pos(red_cur_pos),
        .blue_pos(blue_cur_pos),
        .green_pos(green_cur_pos),
        .yellow_pos(yellow_cur_pos),
        .led_number(current_led),
        .i_green_intensity(j1_led_green_intensity),
        .i_red_intensity(j1_led_red_intensity),
        .i_blue_intensity(j1_led_blue_intensity),
        .o_green_intensity(j2_led_green_intensity),
        .o_red_intensity(j2_led_red_intensity),
        .o_blue_intensity(j2_led_blue_intensity)
    );

    end_screen #(
        .MAX_POS(MAX_POS)
    ) end_screen_inst (
        .enable(is_finished),
        .red_pos(red_cur_pos),
        .blue_pos(blue_cur_pos),
        .green_pos(green_cur_pos),
        .yellow_pos(yellow_cur_pos),
        .i_green_intensity(j2_led_green_intensity),
        .i_red_intensity(j2_led_red_intensity),
        .i_blue_intensity(j2_led_blue_intensity),
        .o_green_intensity(led_green_intensity),
        .o_red_intensity(led_red_intensity),
        .o_blue_intensity(led_blue_intensity)
    );

endmodule
