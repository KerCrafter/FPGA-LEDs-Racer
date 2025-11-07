`default_nettype none

module gameplay_screen #(
    parameter MAX_POS = 109
)(
    input  wire enable,
    input  wire [$clog2(MAX_POS)-1:0] red_pos,
    input  wire [$clog2(MAX_POS)-1:0] blue_pos,
    input  wire [$clog2(MAX_POS)-1:0] green_pos,
    input  wire [$clog2(MAX_POS)-1:0] yellow_pos,
    input  wire [$clog2(MAX_POS)-1:0] led_number,
    input  wire [7:0] i_red_intensity,
    input  wire [7:0] i_blue_intensity,
    input  wire [7:0] i_green_intensity,
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
        case ({(green_pos==led_number), (red_pos==led_number), (blue_pos==led_number), (yellow_pos==led_number)})
            4'b0000: {green_intensity, red_intensity, blue_intensity} = {8'd0, 8'd0, 8'd0};
            4'b1000: {green_intensity, red_intensity, blue_intensity} = {8'd10, 8'd0, 8'd0};
            4'b0100: {green_intensity, red_intensity, blue_intensity} = {8'd0, 8'd10, 8'd0};
            4'b0010: {green_intensity, red_intensity, blue_intensity} = {8'd0, 8'd0, 8'd10};
            4'b0001: {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd0};
            default: {green_intensity, red_intensity, blue_intensity} = {8'd5, 8'd5, 8'd5};
        endcase
    end

endmodule
