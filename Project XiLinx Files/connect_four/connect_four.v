`timescale 1ns / 1ps
module connect_four
        (player_input, player, 
        start, clk, reset, 
        Q_INI, Q_P1, Q_P1C, Q_P1C2, Q_P2, Q_P2C, Q_P2C2, Q_END, 
        game_data, empty, win_con, error);
        
        input clk, reset;
        input start;
        
        input [6:0] player_input;
        input player; 
        
        reg [1:0] input_data; // 2 bit data (00 = none, 10 = player 1, 11 = player 2)
        reg [5:0] addr;//address
        reg [3:0] cnt;//counter for full column
        
        reg flag, flag_local, flag_local2;//to check square conditions and players' victory
        integer i, j, k;
        
        output reg [41:0] game_data;
        output reg [41:0] empty;
        output reg [1:0] win_con; // 00 = draw, 01 = player 1 win, 10 = player 2 win
        output reg error; //column already full
        
        reg [7:0] state;
        output wire Q_INI, Q_P1, Q_P1C, Q_P1C2, Q_P2, Q_P2C, Q_P2C2, Q_END;
        assign {Q_END, Q_P2C2, Q_P2C, Q_P2, Q_P1C2, Q_P1C, Q_P1, Q_INI} = state;
        
        localparam
        INI =         8'b00000001,           // "Initial" state
        P1 =          8'b00000010,           // "Player 1 move / input / validate input"
        P1C =         8'b00000100,           // "Check for full column / game logic / update board state / output"
        P1C2 =        8'b00001000,           // "Check end condition"
        P2 =          8'b00010000,           // "Player 2 move / input / validate input"
        P2C =         8'b00100000,           // "Check for full column / game logic / update board state / output"
        P2C2 =        8'b01000000,           // "Check end condition"
        END =         8'b10000000,           // "End condition met / update LED / logic"
        UNK =         8'bXXXXXXXX;
        
        localparam
        COL7 =         7'b0000001,
        COL6 =         7'b0000010,
        COL5 =         7'b0000100,
        COL4 =         7'b0001000,
        COL3 =         7'b0010000,
        COL2 =         7'b0100000,
        COL1 =         7'b1000000;
        
		  
		  //create cases for when the squares are aligned to get winning condition
        always @(posedge clk, posedge reset) 
        begin
            if(reset) 
				begin
					state <= INI;//all squares are empty
               addr <= 6'bXXXXXX;
               win_con <= 2'bX; //reset winner
               cnt <= 4'bX;
               game_data <= 42'bX;
               empty <= 42'bX;
               error <= 1'b0;
             end 
             else
             begin 
                  case (state) 
							INI:
							begin
                         state <= P1;
                         addr <= 6'bXXXXXX;
                         win_con <= 2'b00; 
                         game_data <= 42'b0;
                         empty <= 42'b0;
                         error <= 1'b0;
                     end
                     
							P1: 
                     begin
                          if(player == 1)
                          begin
                              state <= P1;
                             // player 1
                          end
                          else if(start)
                          begin
                             error <= 1'b0;
                             state <= P1C;
                             cnt <= 4'b0;
                             case (player_input)//check which column player used
                                  COL1: 
                                  begin
                                     addr <= 6'b000000;
                                  end
                                  COL2:
                                  begin
												addr <= 6'b000001;
											 end
											 COL3:
											 begin
												addr <= 6'b000010;
											 end
											 COL4:
											 begin
												addr <= 6'b000011;
											 end
											 COL5:
											 begin
												addr <= 6'b000100;
											 end
											 COL6:
											 begin
												addr <= 6'b000101;
											 end
											COL7:
											 begin
												addr <= 6'b000110;
											 end
										   default:
											begin
												state <= P1;
												// not a valid switch input
											end
										endcase
								   end
							end
 
							P1C:
							begin
								if(cnt >= 4'b0110)//count rows up
								begin
									// column is full
									error <= 1'b1;
									state <= P1;
								end
								else if(empty[addr]==0) // square is empty
							   begin
									empty[addr] <= 1'b1;
									game_data[addr] <= 1'b0;
									state <= P1C2;
								end
							   else
								  begin 
										cnt <= cnt + 4'b0001;//increase number of squares full
										addr <= addr + 6'b000111;
									end
							end
                                        
							P1C2: 
							begin
								// default state condition
								state <= P2;
									  
							  // draw state condition (end condition)
							  if(empty[41:35] == 7'b1111111)
							  begin
								  state <= END;
								  win_con <= 2'b00;			
							  end
										
								// win state condition for P1 (end condition)
							  flag = 1'b0;
							  
							  // LINE ACROSS - WIN CONDITION
							  //scan squares to check which are not empty
							  
							  for(i=0; i<=5; i=i+1)
							  begin
								 for(j=0; j<=3; j=j+1)
								 begin
									 flag_local = 1'b1;
									 for(k=0; k<=3; k=k+1)
									 begin
									   if((empty[(7*i)+(j+k)]==1'b0) || (game_data[(7*i)+(j+k)]==1'b1))
										begin
											flag_local = 1'b0;
										end
									 end
									 if(flag_local == 1'b1)
										begin
										  flag = 1'b1;
										end
								 end
							 end
                                                        
						  // LINE DOWN - WIN CONDITION
						  for(i=0; i<=6; i=i+1)
						  begin
								for(j=0; j<=2; j=j+1)
								begin
								  flag_local = 1'b1;
								  for(k=0; k<=3; k=k+1)
								  begin
									 if((empty[(7*(j+k))+i]==1'b0) || (game_data[(7*(j+k))+i]==1'b1))
									 begin
									 	flag_local = 1'b0;
									 end
								  end
								  if(flag_local == 1'b1)//mark as a full square
								  begin
								    flag = 1'b1;
								 end
						    end
						end
						  
					  // DIAGONALS - WIN CONDITION
					  
					  for(i=0; i<=2; i=i+1)
					  begin
							for(j=0; j<=3; j=j+1)
							  begin
									 flag_local = 1'b1;
									 flag_local2 = 1'b1;
									 for(k=0; k<=3; k=k+1)
									 begin
										  if((empty[(7*i)+j+(8*k)]==1'b0) || (game_data[(7*i)+j+(8*k)]==1'b1))
										  begin
												flag_local = 1'b0;
										  end
										  if((empty[(7*i)+3+j+(6*k)]==1'b0) || (game_data[(7*i)+3+j+(6*k)]==1'b1))
										  begin
												flag_local2 = 1'b0;
										  end
									end
									if(flag_local == 1'b1 || flag_local2 == 1'b1)
									begin
										flag = 1'b1;
									end
								end
					end                                                        
					  
				  // FINAL CHECK
				  if(flag == 1'b1)
				  begin
						state <= END;
						win_con <= 2'b01;
				  end
				end
					 
				P2:
				begin
					  if(player == 0)
					  begin
							state <= P2;
							// player 2
						end
					   else if(start)
						begin
							error <= 1'b0;
							state <= P2C;
							cnt <= 4'b0;
							case (player_input)
								  COL1: 
								  begin
										addr <= 6'b000000;
								  end
								  COL2:
								  begin
										addr <= 6'b000001;
								  end
								  COL3:
								  begin
										addr <= 6'b000010;
								  end
								  COL4:
								  begin
										addr <= 6'b000011;
										 end
								  COL5:
								  begin
										addr <= 6'b000100;
								  end
								  COL6:
								  begin
										addr <= 6'b000101;
								  end
								  COL7:
								  begin
										addr <= 6'b000110;
								  end
								  default:
								  begin
										state <= P2;
											// not a valid switch input
											
								 end
							endcase
						end
					end
                                        
					 P2C:
					begin
							  if(cnt >= 4'b0110)
								begin
										// column is full
													
									state <= P2;
									error <= 1'b1;
								end
							  else if(empty[addr]==0) // is empty
										 begin
													empty[addr] <= 1'b1;
													game_data[addr] <= 1'b1;
													state <= P2C2;
										 end
							  else
										 begin 
													cnt <= cnt + 4'b0001;
													addr <= addr + 6'b000111;
										 end
					end
                                        
							 P2C2: 
										begin
												  // default state condition
												  state <= P1;
												  
												  // draw state condition (end condition)
												  if(empty[41:35] == 7'b1111111)
															 begin
																		state <= END;
																		win_con <= 2'b00;
															 end
										
							  // win state condition for P2 (end condition)
							  flag = 1'b0;
							  
							  // LINE ACROSS - WIN CONDITION                                                        
							  for(i=0; i<=5; i=i+1)
									 begin
										for(j=0; j<=3; j=j+1)
												  begin
												 flag_local = 1'b1;
												 for(k=0; k<=3; k=k+1)
															begin
																	if((empty[(7*i)+(j+k)]==1'b0) || (game_data[(7*i)+(j+k)]==1'b0))
																	begin
																		flag_local = 1'b0;
																	end
															end
												 if(flag_local == 1'b1)
												 begin
													flag = 1'b1;
												 end
												end
									 end
                                                        
								  // LINE DOWN - WIN CONDITION
								  for(i=0; i<=6; i=i+1)
									 begin
										for(j=0; j<=2; j=j+1)
										  begin
											 flag_local = 1'b1;
											 for(k=0; k<=3; k=k+1)
											 begin
												  if((empty[(7*(j+k))+i]==1'b0) || (game_data[(7*(j+k))+i]==1'b0))
											     begin
													flag_local = 1'b0;
												  end
												end
											 if(flag_local == 1'b1)
											 begin
												  flag = 1'b1;
											end
										end
									 end
                                                        
				  // DIAGONALS - WIN CONDITION
				  for(i=0; i<=2; i=i+1)
							 begin
										for(j=0; j<=3; j=j+1)
												  begin
															 flag_local = 1'b1;
															 flag_local2 = 1'b1;
															 for(k=0; k<=3; k=k+1)
																begin
																  if((empty[(7*i)+j+(8*k)]==1'b0) || (game_data[(7*i)+j+(8*k)]==1'b0))
																			 begin
																						flag_local = 1'b0;
																			 end
																  if((empty[(7*i)+3+j+(6*k)]==1'b0) || (game_data[(7*i)+3+j+(6*k)]==1'b0))
																			 begin
																						flag_local2 = 1'b0;
																			 end
																end
															 if(flag_local == 1'b1 || flag_local2 == 1'b1)
																		begin
																				  flag = 1'b1;
																		end
												  end
							 end

									  // FINAL CHECK
									  if(flag == 1'b1)
												 begin
															state <= END;
															win_con <= 2'b10;
												 end
									end
                                        
                                      
                      endcase
                     end
                end

endmodule
