module connect_four_lcd
        (sys_clk, reset, win_con, error,
        Q_INI, Q_P1, Q_P1C, Q_P1C2, Q_P2, Q_P2C, Q_P2C2, Q_END, 
        LCD_data, LCD_e, LCD_rs, LCD_rw, LCD_bl
        );
        
        /* INPUTS */
        input reset, sys_clk;
        input Q_INI, Q_P1, Q_P1C, Q_P1C2, Q_P2, Q_P2C, Q_P2C2, Q_END;
        input [1:0] win_con; // 00 = none/draw, 10 = player 1, 11 = player 2
        input error; // 00 = Normal, 01 = Wrong Player, 10 = Not Valid Switch Input, 11 = Column is Full

        /* OUTPUTS */
        output [7:0] LCD_data;
        output LCD_e, LCD_rs, LCD_rw, LCD_bl;
        assign LCD_bl = 0;

        /* LOCAL SIGNALS */
        reg [7:0] data1, data2, data3, data4, data5, data6, data7, data8,
                data9, data10, data11, data12, data13, data14, data15, data16,
                data17, data18, data19, data20, data21, data22, data23, data24,
                data25, data26, data27, data28, data29, data30, data31, data32;        
                        
        always @(*)
                begin 
                        if(error == 1'b1)
                                begin
                                        data1 = "P";
                                        data2 = "l";
                                        data3 = "a";
                                        data4 = "y";
                                        data5 = "e";
                                        data6 = "r";
                                        data7 = " ";
                                        data8 = (Q_P1 || Q_P1C || Q_P1C2) ? bin2x(1) : bin2x(2);
                                        data9 = " ";
                                        data10 = "T";
                                        data11 = "u";
                                        data12 = "r";
                                        data13 = "n";
                                        data14 = " ";
                                        data15 = " ";
                                        data16 = " ";
                                        data17 = "C";
                                        data18 = "o";
                                        data19 = "l";
                                        data20 = "u";
                                        data21 = "m";
                                        data22 = "n";
                                        data23 = " ";
                                        data24 = "I";
                                        data25 = "s";
                                        data26 = " ";
                                        data27 = "F";
                                        data28 = "u";
                                        data29 = "l";
                                        data30 = "l";
                                        data31 = " ";
                                        data32 = " ";                                
                                end
                        else 
                                begin
                                        if (Q_INI || Q_P1 || Q_P1C || Q_P1C2)
                                                begin
                                                        data1 = "P";
                                                        data2 = "l";
                                                        data3 = "a";
                                                        data4 = "y";
                                                        data5 = "e";
                                                        data6 = "r";
                                                        data7 = " ";
                                                        data8 = bin2x(1); 
                                                        data9 = " ";
                                                        data10 = "T";
                                                        data11 = "u";
                                                        data12 = "r";
                                                        data13 = "n";
                                                        data14 = " ";
                                                        data15 = " ";
                                                        data16 = " ";
                                                        data17 = " ";
                                                        data18 = " ";
                                                        data19 = " ";
                                                        data20 = " ";
                                                        data21 = " ";
                                                        data22 = " ";
                                                        data23 = " ";
                                                        data24 = " ";
                                                        data25 = " ";
                                                        data26 = " ";
                                                        data27 = " ";
                                                        data28 = " ";
                                                        data29 = " ";
                                                        data30 = " ";
                                                        data31 = " ";
                                                        data32 = " ";        
                                                end
                                        if (Q_P2 || Q_P2C || Q_P2C2)
                                                begin
                                                        data1 = "P";
                                                        data2 = "l";
                                                        data3 = "a";
                                                        data4 = "y";
                                                        data5 = "e";
                                                        data6 = "r";
                                                        data7 = " ";
                                                        data8 = bin2x(2); 
                                                        data9 = " ";
                                                        data10 = "T";
                                                        data11 = "u";
                                                        data12 = "r";
                                                        data13 = "n";
                                                        data14 = " ";
                                                        data15 = " ";
                                                        data16 = " ";
                                                        data17 = " ";
                                                        data18 = " ";
                                                        data19 = " ";
                                                        data20 = " ";
                                                        data21 = " ";
                                                        data22 = " ";
                                                        data23 = " ";
                                                        data24 = " ";
                                                        data25 = " ";
                                                        data26 = " ";
                                                        data27 = " ";
                                                        data28 = " ";
                                                        data29 = " ";
                                                        data30 = " ";
                                                        data31 = " ";
                                                        data32 = " ";                                                        
                                                end
                                        if (Q_END)
                                                begin
                                                        if(win_con == 2'b01)
                                                                begin
                                                                        data1 = "P";
                                                                        data2 = "l";
                                                                        data3 = "a";
                                                                        data4 = "y";
                                                                        data5 = "e";
                                                                        data6 = "r";
                                                                        data7 = " ";
                                                                        data8 = bin2x(1); 
                                                                        data9 = " ";
                                                                        data10 = "W";
                                                                        data11 = "i";
                                                                        data12 = "n";
                                                                        data13 = "s";
                                                                        data14 = " ";
                                                                        data15 = " ";
                                                                        data16 = " ";
                                                                        data17 = " ";
                                                                        data18 = " ";
                                                                        data19 = " ";
                                                                        data20 = " ";
                                                                        data21 = " ";
                                                                        data22 = " ";
                                                                        data23 = " ";
                                                                        data24 = " ";
                                                                        data25 = " ";
                                                                        data26 = " ";
                                                                        data27 = " ";
                                                                        data28 = " ";
                                                                        data29 = " ";
                                                                        data30 = " ";
                                                                        data31 = " ";
                                                                        data32 = " ";        
                                                                end
                                                        else if(win_con == 2'b10)
                                                                begin
                                                                        data1 = "P";
                                                                        data2 = "l";
                                                                        data3 = "a";
                                                                        data4 = "y";
                                                                        data5 = "e";
                                                                        data6 = "r";
                                                                        data7 = " ";
                                                                        data8 = bin2x(2); 
                                                                        data9 = " ";
                                                                        data10 = "W";
                                                                        data11 = "i";
                                                                        data12 = "n";
                                                                        data13 = "s";
                                                                        data14 = " ";
                                                                        data15 = " ";
                                                                        data16 = " ";
                                                                        data17 = " ";
                                                                        data18 = " ";
                                                                        data19 = " ";
                                                                        data20 = " ";
                                                                        data21 = " ";
                                                                        data22 = " ";
                                                                        data23 = " ";
                                                                        data24 = " ";
                                                                        data25 = " ";
                                                                        data26 = " ";
                                                                        data27 = " ";
                                                                        data28 = " ";
                                                                        data29 = " ";
                                                                        data30 = " ";
                                                                        data31 = " ";
                                                                        data32 = " ";        
                                                                end
                                                        else
                                                                begin
                                                                        data1 = "G";
                                                                        data2 = "a";
                                                                        data3 = "m";
                                                                        data4 = "e";
                                                                        data5 = " ";
                                                                        data6 = "I";
                                                                        data7 = "s";
                                                                        data8 = " "; 
                                                                        data9 = "A";
                                                                        data10 = " ";
                                                                        data11 = "D";
                                                                        data12 = "r";
                                                                        data13 = "a";
                                                                        data14 = "w";
                                                                        data15 = " ";
                                                                        data16 = " ";
                                                                        data17 = " ";
                                                                        data18 = " ";
                                                                        data19 = " ";
                                                                        data20 = " ";
                                                                        data21 = " ";
                                                                        data22 = " ";
                                                                        data23 = " ";
                                                                        data24 = " ";
                                                                        data25 = " ";
                                                                        data26 = " ";
                                                                        data27 = " ";
                                                                        data28 = " ";
                                                                        data29 = " ";
                                                                        data30 = " ";
                                                                        data31 = " ";
                                                                        data32 = " ";        
                                                                end
                                                end
                                end
                end 

        lcd lcd (
                .clk(sys_clk), 
                .reset(reset), 
                .lcd_data(LCD_data), 
                .lcd_e(LCD_e), 
                .lcd_rs(LCD_rs),
                .lcd_rw(LCD_rw),
                .data_f1(data1), .data_f2(data2), .data_f3(data3), .data_f4(data4), .data_f5(data5),.data_f6(data6), 
                .data_f7(data7), .data_f8(data8), .data_f9(data9), .data_f10(data10), .data_f11(data11), .data_f12(data12), 
                .data_f13(data13), .data_f14(data14), .data_f15(data15), .data_f16(data16),.data_s1(data17), .data_s2(data18), 
                .data_s3(data19), .data_s4(data20), .data_s5(data21),.data_s6(data22), .data_s7(data23), .data_s8(data24),
                .data_s9(data25), .data_s10(data26), .data_s11(data27), .data_s12(data28), .data_s13(data29), .data_s14(data30),
                .data_s15(data31), .data_s16(data32)
        );
                
        function [7:0] bin2x;
                input [3:0] data;
                        begin
                                case (data)
                                        4'h0:        bin2x = "0";4'h1:        bin2x = "1";4'h2:        bin2x = "2";4'h3:        bin2x = "3";
                                        4'h4:        bin2x = "4";4'h5:        bin2x = "5";4'h6:        bin2x = "6";4'h7:        bin2x = "7";
                                        4'h8:        bin2x = "8";4'h9:        bin2x = "9";4'hA:        bin2x = "A";4'hB:        bin2x = "B";
                                        4'hC:        bin2x = "C";4'hD:        bin2x = "D";4'hE:        bin2x = "E";4'hF:        bin2x = "F";
                                        default:bin2x = "0";
                                endcase
                        end
        endfunction

endmodule
