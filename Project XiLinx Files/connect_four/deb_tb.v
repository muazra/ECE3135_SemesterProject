module deb_tb;

	// Inputs
	reg CLK;
	reg RESET;
	reg PB;

	// Outputs
	wire DPB;
	wire SCEN;
	wire MCEN;
	wire CCEN;

	// Instantiate the Unit Under Test (UUT)
	deb uut (
		.CLK(CLK), 
		.RESET(RESET), 
		.PB(PB), 
		.DPB(DPB), 
		.SCEN(SCEN), 
		.MCEN(MCEN), 
		.CCEN(CCEN)
	);
	
	always #10 CLK = ~CLK;
	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 0;
		PB = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		#10 RESET = 1;
		#10 RESET = 0;
		
		#10 PB = ~PB;

	end
      
endmodule

