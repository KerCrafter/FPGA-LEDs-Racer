module menu_manager #(
    parameter MENU_TIMER_CLK_COUNT = 50000000
)(
    input  wire clk,
    input  wire green_ready_to_play,
    input  wire red_ready_to_play,
    input  wire blue_ready_to_play,
    input  wire yellow_ready_to_play,
    input  wire reset,
    output wire is_in_menu,
    output reg  [2:0] countdown,
    output wire activity
);

    wire trigger_countdown;
    wire menu_timer_tick;
    reg  countdown_finished;

    parameter WAIT_INTERACT   = 2'd0;
    parameter WHEN_RESET      = 2'd1;
    parameter WHEN_TIMER_TICK = 2'd2;
    reg [1:0] state;

    ready_trigger_countdown ready_trigger_countdown_inst (
        .green_ready_to_play(green_ready_to_play),
        .red_ready_to_play(red_ready_to_play),
        .blue_ready_to_play(blue_ready_to_play),
        .yellow_ready_to_play(yellow_ready_to_play),
        .result(trigger_countdown)
    );

    timer #(
        .CLK_COUNT(MENU_TIMER_CLK_COUNT)
    ) menu_timer (
        .clk(clk),
        .reset(reset),
        .enable(trigger_countdown),
        .tick(menu_timer_tick)
    );

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_INTERACT;
            countdown <= 0;
            countdown_finished <= 0;
        end else begin
            case (state)
                WAIT_INTERACT: begin
                    if (menu_timer_tick)
                        state <= WHEN_TIMER_TICK;
                    else if (reset)
                        state <= WHEN_RESET;
                end

                WHEN_TIMER_TICK: begin
                    state <= WAIT_INTERACT;
                    if (countdown == 0)
                        countdown <= 7;
                    else if (countdown == 1)
                        countdown_finished <= 1;
                    else
                        countdown <= countdown - 1;
                end

                WHEN_RESET: begin
                    state <= WAIT_INTERACT;
                    countdown <= 0;
                    countdown_finished <= 0;
                end
            endcase
        end
    end

    assign is_in_menu = ~countdown_finished;
    assign activity = menu_timer_tick;

endmodule
