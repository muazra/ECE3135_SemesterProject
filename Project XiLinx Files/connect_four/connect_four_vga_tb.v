module connect_four_vga_tb;

	// Inputs
	reg [41:0] game_data;
	reg [41:0] empty;
	reg clk;
	reg sys_clk;
	reg reset;

	// Outputs
	wire vga_h_sync;
	wire vga_v_sync;
	wire vga_r;
	wire vga_g;
	wire vga_b;

	// Instantiate the Unit Under Test (UUT)
	connect_four_vga uut (
		.game_data(game_data), 
		.empty(empty), 
		.clk(clk), 
		.sys_clk(sys_clk), 
		.reset(reset), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.vga_r(vga_r), 
		.vga_g(vga_g), 
		.vga_b(vga_b)
	);

	always #10 sys_clk = ~sys_clk;
	initial begin
		// Initialize Inputs
		game_data = 0;
		empty = 0;
		clk = 0;
		sys_clk = 0;
		reset = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		// Add stimulus here		


	end
      
endmodule

