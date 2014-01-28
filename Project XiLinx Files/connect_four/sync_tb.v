module sync_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire vga_h_sync;
	wire vga_v_sync;
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	// Instantiate the Unit Under Test (UUT)
	sync uut (
		.clk(clk), 
		.reset(reset), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.inDisplayArea(inDisplayArea), 
		.CounterX(CounterX), 
		.CounterY(CounterY)
	);

	always #10 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 10 ns for global reset to finish
		#10;
		
		#10 reset = 0;
		#10 reset = 1;
		
		#20 reset = 0;

	end
      
endmodule

