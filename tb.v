

module double_flop_sync_tb;
    // Clock domain A (source domain) - 100MHz
    reg clk_a;
    
    // Clock domain B (destination domain) - 75MHz
    reg clk_b;
    
    // Shared reset signal
    reg rst;
    
    // Signals for the DUT
    reg [3:0] signal_a_reg;   // Signal generated in domain A
    wire [3:0] signal_a;      // Signal connected to the DUT
    wire [3:0] signal_b;      // Synchronizer output in domain B
    
    // Instantiate the synchronizer
    double_flop_sync dut (
        .clk_b(clk_b),
        .rst_b(rst),
        .rand_signal_a(signal_a),
        .rand_signal_b(signal_b)
    );
    
    // Connect domain A register to the synchronizer input
    assign signal_a = signal_a_reg;
    
    // Clock generation for domain A (100MHz - 10ns period)
    initial begin
        clk_a = 0;
        forever #5 clk_a = ~clk_a;  // 10ns period
    end
    
    // Clock generation for domain B 
    initial begin
        clk_b = 0;
        forever #7 clk_b = ~clk_b;  // 14ns period
    end
    
    // Random signal generation in domain A
    always @(posedge clk_a or posedge rst) begin
        if (rst) begin
            signal_a_reg <= 4'd0;
        end else begin
            signal_a_reg <= $urandom_range(8, 2);  // Generate random number between 2 and 8
        end
    end

    // Display signal values at each positive edge of clk_b
    always @(posedge clk_b) begin
      $display("B-- Time: %0t ns | RST: %b | Signal_A: %0d | Sync_FF1: %0d | Sync_FF2: %0d | Signal_B: %0d",
                 $time, rst,  signal_a, dut.sync_ff1, dut.sync_ff2, signal_b);
    end
  
  always @(posedge clk_a) begin
    $display("A-- Time: %0t ns | RST: %b | Signal_A: %0d | Sync_FF1: %0d | Sync_FF2: %0d | Signal_B: %0d",
                 $time, rst,  signal_a, dut.sync_ff1, dut.sync_ff2, signal_b);
    end

    // Simulation control
    initial begin
        $dumpfile("double_flop_sync_tb.vcd");
        $dumpvars(0, double_flop_sync_tb);
        
        
        rst = 0;
        
        #500;
        
        $display("\nSimulation completed successfully!");
        $finish;
    end
endmodule
