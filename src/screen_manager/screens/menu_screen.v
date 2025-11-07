`default_nettype none

module menu_screen #(
    parameter MAX_POS = 109
)(
    input  wire enable,
    input  wire [7:0] i_red_intensity,
    input  wire [7:0] i_blue_intensity,
    input  wire [7:0] i_green_intensity,
    input  wire red_ready_to_play,
    input  wire blue_ready_to_play,
    input  wire green_ready_to_play,
    input  wire yellow_ready_to_play,
    input  wire [2:0] countdown, // 0..7
    input  wire [$clog2(MAX_POS)-1:0] led_number,
    output wire [7:0] o_red_intensity,
    output wire [7:0] o_blue_intensity,
    output wire [7:0] o_green_intensity
);

    reg [7:0] red_intensity;
    reg [7:0] blue_intensity;
    reg [7:0] green_intensity;

    pipe_tri_bus pipe_tri_bus_inst (
        .enable(enable),
        .i_led_red_intensity(i_red_intensity),
        .i_led_blue_intensity(i_blue_intensity),
        .i_led_green_intensity(i_green_intensity),
        .d_led_red_intensity(red_intensity),
        .d_led_blue_intensity(blue_intensity),
        .d_led_green_intensity(green_intensity),
        .o_led_red_intensity(o_red_intensity),
        .o_led_blue_intensity(o_blue_intensity),
        .o_led_green_intensity(o_green_intensity)
    );

    always @(*) begin
        if (((led_number==0)||(led_number==7)||(led_number==14)||(led_number==21)) && countdown >= 3'd7)
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        else if (((led_number==28)||(led_number==34)||(led_number==40)||(led_number==46)) && countdown >= 3'd6)
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        else if (((led_number==52)||(led_number==57)||(led_number==62)||(led_number==67)) && countdown >= 3'd5)
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        else if (((led_number==72)||(led_number==76)||(led_number==80)||(led_number==84)) && countdown >= 3'd4)
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        else if (((led_number==88)||(led_number==91)||(led_number==94)||(led_number==97)) && countdown >= 3'd3)
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        else if (((led_number==100)||(led_number==102)||(led_number==104)||(led_number==106)) && countdown >= 3'd2)
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        else if ((led_number==108) && countdown >= 3'd1)
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        else if (red_ready_to_play && ((led_number>=1 && led_number<=6)||(led_number>=29 && led_number<=33)||(led_number>=53 && led_number<=56)||(led_number>=73 && led_number<=75)||(led_number>=89 && led_number<=90)||(led_number==101)))
            {green_intensity, red_intensity, blue_intensity} = {8'd0, 8'd5, 8'd0};
        else if (green_ready_to_play && ((led_number>=8 && led_number<=13)||(led_number>=35 && led_number<=39)||(led_number>=58 && led_number<=61)||(led_number>=77 && led_number<=79)||(led_number>=92 && led_number<=93)||(led_number==103)))
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd0, 8'd0};
        else if (blue_ready_to_play && ((led_number>=15 && led_number<=20)||(led_number>=41 && led_number<=45)||(led_number>=63 && led_number<=66)||(led_number>=81 && led_number<=83)||(led_number>=95 && led_number<=96)||(led_number==105)))
            {green_intensity, red_intensity, blue_intensity} = {8'd0, 8'd0, 8'd5};
        else if (yellow_ready_to_play && ((led_number>=22 && led_number<=27)||(led_number>=47 && led_number<=51)||(led_number>=68 && led_number<=71)||(led_number>=85 && led_number<=87)||(led_number>=98 && led_number<=99)||(led_number==107)))
            {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd0};
        else
            {green_intensity, red_intensity, blue_intensity} = {8'd0, 8'd0, 8'd0};
    end

endmodule
