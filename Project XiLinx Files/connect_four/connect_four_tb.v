module connect_four_tb;

	// Inputs
	reg [6:0] player_input;
	reg player;
	reg start;
	reg clk;
	reg reset;

	// Outputs
	wire Q_INI;
	wire Q_P1;
	wire Q_P1C;
	wire Q_P1C2;
	wire Q_P2;
	wire Q_P2C;
	wire Q_P2C2;
	wire Q_END;
	wire [41:0] game_data;
	wire [41:0] empty;
	wire [1:0] win_con;
	wire error;

	// Instantiate the Unit Under Test (UUT)
	connect_four uut (
		.player_input(player_input), 
		.player(player), 
		.start(start), 
		.clk(clk), 
		.reset(reset), 
		.Q_INI(Q_INI), 
		.Q_P1(Q_P1), 
		.Q_P1C(Q_P1C), 
		.Q_P1C2(Q_P1C2), 
		.Q_P2(Q_P2), 
		.Q_P2C(Q_P2C), 
		.Q_P2C2(Q_P2C2), 
		.Q_END(Q_END), 
		.game_data(game_data), 
		.empty(empty), 
		.win_con(win_con), 
		.error(error)
	);
	
	always #10 clk = ~clk;
	initial begin
		// Initialize Inputs
		player_input = 0;
		player = 0;
		start = 0;
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		#10 reset = 1;
		#10 reset = 0;
		
		#10 player = 1;
		#10 player = ~player;
		#10 start = 1;
		#10 player_input = 7'b1000000;
		
		#10 player = 0;
		#10 player = ~player;
		#10 start = 1;
		#10 player_input = 7'b0000001;
		
		#15 player = 1;
		#15 player = ~player;
		#15 start = 1;
		#15 player_input = 7'b0100000;
		
		#15 player = 0;
		#15 player = ~player;
		#15 start = 1;
		#15 player_input = 7'b0000001;
		
		#20 player = 1;
		#20 player = ~player;
		#20 start = 1;
		#20 player_input = 7'b0010000;
				
		#20 player = 0;
		#20 player = ~player;
		#20 start = 1;
		#20 player_input = 7'b0000001;
		
		#25 player = 1;
		#25 player = ~player;
		#25 start = 1;
		#25 player_input = 7'b0001000;
		
		#25 player = 0;
		#25 player = ~player;
		#25 start = 1;
		#25 player_input = 7'b0000010;

	end
      
endmodule

