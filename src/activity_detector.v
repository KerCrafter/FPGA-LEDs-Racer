module activity_detector (
    input  wire clk,
    input  wire reset,
    input  wire A,
    input  wire B,
    input  wire C,
    input  wire D,
    input  wire E,
    input  wire F,
    output wire R
);

    reg boot_activity = 1'b0;
    reg boot_end = 1'b0;
    wire activity_signals;

    wire pipe1;
    wire pipe2;
    wire pipe3;
    wire pipe4;
    wire pipe5;

    pipe_pulse_generator A_PIPE_PULSE (
        .clk(clk),
        .reset(reset),
        .pipe_in(1'b0),
        .pipe_out(pipe1),
        .s(A)
    );

    pipe_pulse_generator B_PIPE_PULSE (
        .clk(clk),
        .reset(reset),
        .pipe_in(pipe1),
        .pipe_out(pipe2),
        .s(B)
    );

    pipe_pulse_generator C_PIPE_PULSE (
        .clk(clk),
        .reset(reset),
        .pipe_in(pipe2),
        .pipe_out(pipe3),
        .s(C)
    );

    pipe_pulse_generator D_PIPE_PULSE (
        .clk(clk),
        .reset(reset),
        .pipe_in(pipe3),
        .pipe_out(pipe4),
        .s(D)
    );

    pipe_pulse_generator E_PIPE_PULSE (
        .clk(clk),
        .reset(reset),
        .pipe_in(pipe4),
        .pipe_out(pipe5),
        .s(E)
    );

    pipe_pulse_generator F_PIPE_PULSE (
        .clk(clk),
        .reset(reset),
        .pipe_in(pipe5),
        .pipe_out(activity_signals),
        .s(F)
    );

    always @(posedge clk) begin
      if (reset) begin
        boot_activity <= 1'b0;
        boot_end <= 1'b0;
      
      end else begin
        if (boot_end == 1'b0) begin
            boot_activity <= 1'b1;
            boot_end <= 1'b1;
        end else begin
            boot_activity <= 1'b0;
        end
      end
    end

    assign R = activity_signals | boot_activity;

endmodule
