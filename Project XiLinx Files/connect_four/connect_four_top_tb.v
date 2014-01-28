`timescale 1ns / 1ps
module connect_four_top_tb;

	// Inputs
	reg CLK50;
	reg P1;
	reg P2;
	reg Reset_button;
	reg Sw6;
	reg Sw5;
	reg Sw4;
	reg Sw3;
	reg Sw2;
	reg Sw1;
	reg Sw0;

	// Outputs
	wire An3;
	wire An2;
	wire An1;
	wire An0;
	wire Ca;
	wire Cb;
	wire Cc;
	wire Cd;
	wire Ce;
	wire Cf;
	wire Cg;
	wire Dp;
	wire vga_h_sync;
	wire vga_v_sync;
	wire vga_r;
	wire vga_g;
	wire vga_b;

	// Instantiate the Unit Under Test (UUT)
	connect_four_top uut (
		.CLK50(CLK50), 
		.P1(P1), 
		.P2(P2), 
		.Reset_button(Reset_button), 
		.Sw6(Sw6), 
		.Sw5(Sw5), 
		.Sw4(Sw4), 
		.Sw3(Sw3), 
		.Sw2(Sw2), 
		.Sw1(Sw1), 
		.Sw0(Sw0), 
		.An3(An3), 
		.An2(An2), 
		.An1(An1), 
		.An0(An0), 
		.Ca(Ca), 
		.Cb(Cb), 
		.Cc(Cc), 
		.Cd(Cd), 
		.Ce(Ce), 
		.Cf(Cf), 
		.Cg(Cg), 
		.Dp(Dp), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.vga_r(vga_r), 
		.vga_g(vga_g), 
		.vga_b(vga_b)
	);
	
	always #10 CLK50 = ~CLK50;
	initial begin
		// Initialize Inputs
		CLK50 = 0;
		P1 = 0;
		P2 = 0;
		Reset_button = 0;
		Sw6 = 0;
		Sw5 = 0;
		Sw4 = 0;
		Sw3 = 0;
		Sw2 = 0;
		Sw1 = 0;
		Sw0 = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		// Add stimulus here
		#10 Reset_button = 1;
		#10 Reset_button = 0;
		
		#10 P1 = 1;
		#10 Sw6 = 1;
		#10 Sw5 = 1;
		#10 Sw4 = 1;
		#10 Sw3 = 1;
		#10 Sw2 = 1;
		#10 Sw1 = 1;
		#10 Sw0 = 1;
		
		#20 P2 = 1;
		#20 Sw6 = 1;
		#20 Sw5 = 1;
		#20 Sw4 = 1;
		#20 Sw3 = 1;
		#20 Sw2 = 1;
		#20 Sw1 = 1;
		#20 Sw0 = 1;

	end
      
endmodule

