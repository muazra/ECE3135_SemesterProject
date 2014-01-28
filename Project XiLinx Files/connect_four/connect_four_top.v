//player 1 is red, player 2 is blue
module connect_four_top
		(CLK50,                                     // the 50 MHz incoming clock signal
	    P1, P2, Reset_button,                      // 4 buttons, P1, P2, idk, reset game
		 Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0,         // 7 switches to choose the column to drop 
       An3, An2, An1, An0,                        // 4 anodes to selct the 7 segs
       Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,            // 8 cathodes for 7segs
       vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b);        // VGA signals

		 /*  INPUTS */
		 input CLK50;        
		 input P1, P2, Reset_button;        
		 input Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;

		 /*  OUTPUTS */
		 output An0, An1, An2, An3;                 //7 segs
		 output Cg, Cf, Ce, Cd, Cc, Cb, Ca, Dp;     //7seg(diodes)
		 
		 output vga_h_sync, vga_v_sync;             //vga outputs for screen
		 output vga_r, vga_g, vga_b;                //colors for screen
		 
		 /*  CLOCK SIGNALS */
		 wire reset, CLK50;
		 wire board_clk, sys_clk;
		 wire [1:0] ssdscan_clk;
		 reg [26:0] DIV_CLK;                        //clock divider
		 reg CLK_int25;                             //new clock to give 25MHz output
		
		 //make clock half the frequency
		 always @(posedge CLK50) begin
			CLK_int25 <= ~CLK_int25;
		 end
		 
		 BUFG BUFGP1 (board_clk, CLK_int25);        //connect input signal CLK25 to output signal board_clk
		//assign board_clk = CLK_int25;
		 
		 always @(posedge board_clk, posedge reset)begin                                                        
			 if (reset)
				 DIV_CLK <= 0;
			 else
				 DIV_CLK <= DIV_CLK + 1'b1;
				end
					
		 assign sys_clk = board_clk;
		 //assign sys_clk = DIV_CLK[25];
		 
		 /* LOCAL SIGNALS */
		 reg player;
		 wire [6:0] player_input;
		 wire start;
		 wire Q_INI, Q_P1, Q_P1C, Q_P1C2, Q_P2, Q_P2C, Q_P2C2, Q_END;
		 //INI = initial state, P1 = input from player 1, P1C = check for full column, P1C2 = check for end condition
		 //P2 = "" player 2, P2C = "" for player 2, P2C2 = check for end condition, END = end condition met
		 wire [41:0] game_data; // 0 is player 1, 1 is player 2
		 wire [41:0] empty; // 0 = box is empty, 1 = box is taken
		 wire [1:0] win_con; // 00 = none/draw, 01 = player 1, 10 = player 2
		 wire error; // 0 = Normal, 1 = Column is Full
		 reg [3:0] ssd_player_input;//7-seg to display column chosen for playerx
		 
		 //to check states of players
		 wire P1_pulse, P2_pulse;

		//debounce switches and keep track of states for both players
		 deb #(.N_dc(28)) deb_l
		(.CLK(sys_clk), .RESET(reset), .PB(P1), .DPB(P1_pulse), 
		 .SCEN( ), .MCEN( ), .CCEN( ));

		 deb #(.N_dc(28)) deb_r
       (.CLK(sys_clk), .RESET(reset), .PB(P2), .DPB(P2_pulse), 
		 .SCEN( ), .MCEN( ), .CCEN( ));
		 
		 
		 assign reset = Reset_button;
		
		 assign start = P1_pulse || P2_pulse; 
		 assign player_input = {Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0};

		 
		 //check players turn to drop
		 always @ (posedge sys_clk, posedge reset)begin
			 if (reset)
				 player <= 1'bX;
			 else
			 begin
				if (P1_pulse == 1'b1)
					player <= 1'b0;
				if (P2_pulse == 1'b1)
					player <= 1'b1;
			 end
			end
		 
		 /* CONNECT FOUR INSTANTIATION */
		 connect_four sm(.player_input(player_input), .player(player), 
					.start(start), .clk(sys_clk), .reset(reset), .Q_INI(Q_INI), .Q_P1(Q_P1),
					.Q_P1C(Q_P1C), .Q_P1C2(Q_P1C2), .Q_P2(Q_P2), .Q_P2C(Q_P2C), .Q_P2C2(Q_P2C2),
					.Q_END(Q_END), .game_data(game_data), .empty(empty), .win_con(win_con), .error(error) );

		 
		 /* 7-seg(SSD) SIGNALS */
		 reg [3:0] SSD;
		 wire [3:0] SSD3, SSD2, SSD1, SSD0;
		 reg [7:0] SSD_CATHODES;
		 
		 assign An0 = !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
		 assign An1 = !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
		 assign An2 = !((ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
		 assign An3 = !((ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
		 assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES};


		//display player turn and column numbers on seve-segs
		 always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
		 begin : SSD_SCAN_OUT
					case (ssdscan_clk) 
							  2'b00: SSD = SSD0;
							  2'b01: SSD = SSD1;
							  2'b10: SSD = SSD2;
							  2'b11: SSD = SSD3;
					endcase 
		 end

		 always @ (SSD) 
		 begin : HEX_TO_SSD
					case (SSD) 
							  4'b0000: SSD_CATHODES = 8'b00000010; // 0
							  4'b0001: SSD_CATHODES = 8'b10011110; // 1
							  4'b0010: SSD_CATHODES = 8'b00100100; // 2
							  4'b0011: SSD_CATHODES = 8'b00001100; // 3
							  4'b0100: SSD_CATHODES = 8'b10011000; // 4
							  4'b0101: SSD_CATHODES = 8'b01001000; // 5
							  4'b0110: SSD_CATHODES = 8'b01000000; // 6
							  4'b0111: SSD_CATHODES = 8'b00011110; // 7
							  4'b1000: SSD_CATHODES = 8'b00000000; // 8
							  4'b1001: SSD_CATHODES = 8'b00001000; // 9
							  4'b1010: SSD_CATHODES = 8'b00010000; // A
							  4'b1011: SSD_CATHODES = 8'b11000000; // B
							  4'b1100: SSD_CATHODES = 8'b01100010; // C
							  4'b1101: SSD_CATHODES = 8'b10000100; // D
							  4'b1110: SSD_CATHODES = 8'b01100000; // E
							  4'b1111: SSD_CATHODES = 8'b11111111; // all empty
					endcase
		 end        

		 localparam
		 COL7 = 7'b0000001,
		 COL6 = 7'b0000010,
		 COL5 = 7'b0000100,
		 COL4 = 7'b0001000,
		 COL3 = 7'b0010000,
		 COL2 = 7'b0100000,
		 COL1 = 7'b1000000;

		 always @ (player_input)
		 begin
				case (player_input)
						COL1: ssd_player_input <= 4'b0001;
						COL2: ssd_player_input <= 4'b0010;
						COL3: ssd_player_input <= 4'b0011;
						COL4: ssd_player_input <= 4'b0100;
						COL5: ssd_player_input <= 4'b0101;
						COL6: ssd_player_input <= 4'b0110;
						COL7: ssd_player_input <= 4'b0111;
						default: ssd_player_input <= 4'b1110;
				 endcase
		 end

		 assign SSD3 = (Q_INI | Q_END) ? 4'b0000 : (Q_P1 | Q_P1C | Q_P1C2) ? 4'b0001 : 4'b0010;
		 assign SSD2 = ssd_player_input;
		 assign SSD1 = 4'b1111;
		 assign SSD0 = {2'b0, win_con}; // 0 = none/draw, 1 = player 1, 2 = player 2

		 assign ssdscan_clk = DIV_CLK[18:17]; // or [19:18]        

		
		 /* VGA SIGNALS */

		 wire clk; 
		 assign clk = board_clk;
		 
		 connect_four_vga vga(.clk(clk), .sys_clk(sys_clk), .reset(reset),
					.game_data(game_data), .empty(empty), 
					.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), 
					.vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b) );

endmodule
