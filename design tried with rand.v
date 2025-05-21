module double_flop_sync (
    input clk_b,               // Destination clock
    input rst_b,               // Reset in destination domain
    input [3:0] rand_signal_a, // 4-bit signal from domain A
    output [3:0] rand_signal_b // Synchronized signal for domain B
);
    // Two-stage synchronizer
    reg [3:0] sync_ff1, sync_ff2;

    always @(posedge clk_b or posedge rst_b) begin
        if (rst_b) begin
            sync_ff1 <= 4'd0;
            sync_ff2 <= 4'd0;
        end else begin
            sync_ff1 <= rand_signal_a;    // First flop captures the input
            sync_ff2 <= sync_ff1;         // Second flop synchronizes the signal
        end
    end

    assign rand_signal_b = sync_ff2;
endmodule

