module player_button #(
    parameter MAX_POS = 16
)(
    input  wire clk,
    input  wire btn,
    input  wire [1:0] current_screen,
    input  wire reset,
    output reg [$clog2(MAX_POS)-1:0] cur_pos,
    output wire activity,
    output reg  ready_to_play
);

    parameter WAIT_INTERACT   = 2'd0;
    parameter WHEN_BTN        = 2'd1;
    parameter WAIT_RELEASE_BTN= 2'd2;
    parameter WHEN_RESET      = 2'd3;
    reg [1:0] state;

    always @(posedge clk) begin
        case (state)
            WAIT_INTERACT: begin
                if (btn)
                    state <= WHEN_BTN;
                else if (reset)
                    state <= WHEN_RESET;
            end

            WHEN_BTN: begin
                state <= WAIT_RELEASE_BTN;
                if (current_screen == 2'b00)
                    ready_to_play <= 1;
                else if (current_screen == 2'b01 && ready_to_play)
                    cur_pos <= cur_pos + 1;
            end

            WAIT_RELEASE_BTN: begin
                if (!btn)
                    state <= WAIT_INTERACT;
            end

            WHEN_RESET: begin
                state <= WAIT_INTERACT;
                cur_pos <= 0;
                ready_to_play <= 0;
            end
        endcase
    end

    assign activity = btn;

endmodule
