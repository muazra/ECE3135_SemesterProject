// Connect Four VGA
//`timescale 1ns / 1ps

module connect_four_vga
        (game_data, empty, clk, sys_clk, reset,
        vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b
        );
        
        /* INPUTS */
        input [41:0] game_data; // 0 is player 1, 1 is player 2
        input [41:0] empty; // 0 is empty, 1 is taken
        input clk, sys_clk, reset;
        
        /* OUTPUTS */
        output vga_h_sync, vga_v_sync;
        output reg vga_r, vga_g, vga_b;
        
        /* LOCAL SIGNALS */
        wire inDisplayArea; //to draw squares
        wire [9:0] CounterX; //for pixels accross
        wire [9:0] CounterY; //for pixels up-down
        reg [9:0] positionX = 60;
        reg [9:0] positionY = 60;
        wire lines, p1, p2;//grid and squares for players
        
		  //generate colors on screen
        always @(posedge sys_clk)
					 begin
                        vga_r <= p1 & inDisplayArea;
                        vga_b <= p2 & inDisplayArea;
                        vga_g <= lines & inDisplayArea;
                end
        //sync output signal to screen
        sync sync(.clk(clk), .reset(reset), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));

        // green(create grid)
        assign lines = 
                        (CounterX >= 38 && CounterX <= 42) || 
                        (CounterX >= 118 && CounterX <= 122) || 
                        (CounterX >= 198 && CounterX <= 202) ||
                        (CounterX >= 278 && CounterX <= 282) ||
                        (CounterX >= 358 && CounterX <= 362) ||
                        (CounterX >= 438 && CounterX <= 442) ||
                        (CounterX >= 518 && CounterX <= 522) ||
                        (CounterX >= 598 && CounterX <= 602) ||
                        ((CounterX >= 38 && CounterX <= 602) && (
                        (CounterY >= 75 && CounterY <= 79) || 
                        (CounterY >= 155 && CounterY <= 159) ||
                        (CounterY >= 235 && CounterY <= 239) ||
                        (CounterY >= 315 && CounterY <= 319) ||
                        (CounterY >= 395 && CounterY <= 399) ||
                        (CounterY >= 475 && CounterY <= 479)));
        
        //red squares
        assign p1 = 
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 410 && CounterY <= 464 && (empty[0]==1) && (game_data[0]==0)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 410 && CounterY <= 464 && (empty[1]==1) && (game_data[1]==0)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 410 && CounterY <= 464 && (empty[2]==1) && (game_data[2]==0)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 410 && CounterY <= 464 && (empty[3]==1) && (game_data[3]==0)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 410 && CounterY <= 464 && (empty[4]==1) && (game_data[4]==0)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 410 && CounterY <= 464 && (empty[5]==1) && (game_data[5]==0)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 410 && CounterY <= 464 && (empty[6]==1) && (game_data[6]==0)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 330 && CounterY <= 384 && (empty[7]==1) && (game_data[7]==0)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 330 && CounterY <= 384 && (empty[8]==1) && (game_data[8]==0)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 330 && CounterY <= 384 && (empty[9]==1) && (game_data[9]==0)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 330 && CounterY <= 384 && (empty[10]==1) && (game_data[10]==0)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 330 && CounterY <= 384 && (empty[11]==1) && (game_data[11]==0)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 330 && CounterY <= 384 && (empty[12]==1) && (game_data[12]==0)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 330 && CounterY <= 384 && (empty[13]==1) && (game_data[13]==0)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 250 && CounterY <= 304 && (empty[14]==1) && (game_data[14]==0)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 250 && CounterY <= 304 && (empty[15]==1) && (game_data[15]==0)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 250 && CounterY <= 304 && (empty[16]==1) && (game_data[16]==0)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 250 && CounterY <= 304 && (empty[17]==1) && (game_data[17]==0)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 250 && CounterY <= 304 && (empty[18]==1) && (game_data[18]==0)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 250 && CounterY <= 304 && (empty[19]==1) && (game_data[19]==0)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 250 && CounterY <= 304 && (empty[20]==1) && (game_data[20]==0)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 170 && CounterY <= 224 && (empty[21]==1) && (game_data[21]==0)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 170 && CounterY <= 224 && (empty[22]==1) && (game_data[22]==0)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 170 && CounterY <= 224 && (empty[23]==1) && (game_data[23]==0)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 170 && CounterY <= 224 && (empty[24]==1) && (game_data[24]==0)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 170 && CounterY <= 224 && (empty[25]==1) && (game_data[25]==0)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 170 && CounterY <= 224 && (empty[26]==1) && (game_data[26]==0)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 170 && CounterY <= 224 && (empty[27]==1) && (game_data[27]==0)) ||                        
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 90 && CounterY <= 144 && (empty[28]==1) && (game_data[28]==0)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 90 && CounterY <= 144 && (empty[29]==1) && (game_data[29]==0)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 90 && CounterY <= 144 && (empty[30]==1) && (game_data[30]==0)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 90 && CounterY <= 144 && (empty[31]==1) && (game_data[31]==0)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 90 && CounterY <= 144 && (empty[32]==1) && (game_data[32]==0)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 90 && CounterY <= 144 && (empty[33]==1) && (game_data[33]==0)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 90 && CounterY <= 144 && (empty[34]==1) && (game_data[34]==0)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 10 && CounterY <= 64 && (empty[35]==1) && (game_data[35]==0)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 10 && CounterY <= 64 && (empty[36]==1) && (game_data[36]==0)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 10 && CounterY <= 64 && (empty[37]==1) && (game_data[37]==0)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 10 && CounterY <= 64 && (empty[38]==1) && (game_data[38]==0)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 10 && CounterY <= 64 && (empty[39]==1) && (game_data[39]==0)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 10 && CounterY <= 64 && (empty[40]==1) && (game_data[40]==0)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 10 && CounterY <= 64 && (empty[41]==1) && (game_data[41]==0));
        
        // blue squares
        assign p2 = 
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 410 && CounterY <= 464 && (empty[0]==1) && (game_data[0]==1)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 410 && CounterY <= 464 && (empty[1]==1) && (game_data[1]==1)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 410 && CounterY <= 464 && (empty[2]==1) && (game_data[2]==1)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 410 && CounterY <= 464 && (empty[3]==1) && (game_data[3]==1)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 410 && CounterY <= 464 && (empty[4]==1) && (game_data[4]==1)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 410 && CounterY <= 464 && (empty[5]==1) && (game_data[5]==1)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 410 && CounterY <= 464 && (empty[6]==1) && (game_data[6]==1)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 330 && CounterY <= 384 && (empty[7]==1) && (game_data[7]==1)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 330 && CounterY <= 384 && (empty[8]==1) && (game_data[8]==1)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 330 && CounterY <= 384 && (empty[9]==1) && (game_data[9]==1)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 330 && CounterY <= 384 && (empty[10]==1) && (game_data[10]==1)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 330 && CounterY <= 384 && (empty[11]==1) && (game_data[11]==1)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 330 && CounterY <= 384 && (empty[12]==1) && (game_data[12]==1)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 330 && CounterY <= 384 && (empty[13]==1) && (game_data[13]==1)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 250 && CounterY <= 304 && (empty[14]==1) && (game_data[14]==1)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 250 && CounterY <= 304 && (empty[15]==1) && (game_data[15]==1)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 250 && CounterY <= 304 && (empty[16]==1) && (game_data[16]==1)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 250 && CounterY <= 304 && (empty[17]==1) && (game_data[17]==1)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 250 && CounterY <= 304 && (empty[18]==1) && (game_data[18]==1)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 250 && CounterY <= 304 && (empty[19]==1) && (game_data[19]==1)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 250 && CounterY <= 304 && (empty[20]==1) && (game_data[20]==1)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 170 && CounterY <= 224 && (empty[21]==1) && (game_data[21]==1)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 170 && CounterY <= 224 && (empty[22]==1) && (game_data[22]==1)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 170 && CounterY <= 224 && (empty[23]==1) && (game_data[23]==1)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 170 && CounterY <= 224 && (empty[24]==1) && (game_data[24]==1)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 170 && CounterY <= 224 && (empty[25]==1) && (game_data[25]==1)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 170 && CounterY <= 224 && (empty[26]==1) && (game_data[26]==1)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 170 && CounterY <= 224 && (empty[27]==1) && (game_data[27]==1)) ||                        
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 90 && CounterY <= 144 && (empty[28]==1) && (game_data[28]==1)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 90 && CounterY <= 144 && (empty[29]==1) && (game_data[29]==1)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 90 && CounterY <= 144 && (empty[30]==1) && (game_data[30]==1)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 90 && CounterY <= 144 && (empty[31]==1) && (game_data[31]==1)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 90 && CounterY <= 144 && (empty[32]==1) && (game_data[32]==1)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 90 && CounterY <= 144 && (empty[33]==1) && (game_data[33]==1)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 90 && CounterY <= 144 && (empty[34]==1) && (game_data[34]==1)) ||
                        (CounterX >= 53 && CounterX <= 107 && CounterY >= 10 && CounterY <= 64 && (empty[35]==1) && (game_data[35]==1)) ||
                        (CounterX >= 133 && CounterX <= 187 && CounterY >= 10 && CounterY <= 64 && (empty[36]==1) && (game_data[36]==1)) ||
                        (CounterX >= 213 && CounterX <= 267 && CounterY >= 10 && CounterY <= 64 && (empty[37]==1) && (game_data[37]==1)) ||
                        (CounterX >= 293 && CounterX <= 347 && CounterY >= 10 && CounterY <= 64 && (empty[38]==1) && (game_data[38]==1)) ||
                        (CounterX >= 373 && CounterX <= 427 && CounterY >= 10 && CounterY <= 64 && (empty[39]==1) && (game_data[39]==1)) ||
                        (CounterX >= 453 && CounterX <= 507 && CounterY >= 10 && CounterY <= 64 && (empty[40]==1) && (game_data[40]==1)) ||
                        (CounterX >= 533 && CounterX <= 587 && CounterY >= 10 && CounterY <= 64 && (empty[41]==1) && (game_data[41]==1));

endmodule
