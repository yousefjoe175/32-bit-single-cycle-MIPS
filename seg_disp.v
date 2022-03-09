module seg_disp (
    output    reg    [7:0]   Result,
    output    reg    [3:0]   tube_enables,
    input     wire   [15:0]  count_val,
    input     wire   [1:0]   dig_pointer,
    input     wire           clk,
    input     wire           rst
);

reg    [3:0]   sel_count_val;

always @(posedge clk or negedge rst)
    begin
        if (!rst)
            begin
                sel_count_val <= 4'b0;
                tube_enables  <= 4'b1110;
            end
        else 
            begin
                case (dig_pointer)
                    2'b00   :  begin
                                tube_enables <= 4'b1110;
                                sel_count_val   <= count_val[3:0];               
                            end
                    2'b01   :  begin
                                tube_enables <= 4'b1101;
                                sel_count_val            <= count_val[7:4];               
                            end
                    2'b10   :  begin
                                tube_enables <= 4'b1011;
                                sel_count_val            <= count_val[11:8];               
                            end
                    2'b11   :  begin
                                tube_enables <= 4'b0111;
                                sel_count_val            <= count_val[15:12];               
                            end
                    default :  begin
                                tube_enables <= 4'b1110;
                                sel_count_val            <= count_val[3:0];               
                            end
                endcase
            end
    end

always @(*)
    begin
        case (sel_count_val)
            4'b0000    :   begin
                            Result = 8'b10000001;
                        end
            4'b0001    :   begin
                            Result = 8'b11001111;
                        end
            4'b0010    :   begin
                            Result = 8'b10010010;
                        end
            4'b0011    :   begin
                            Result = 8'b10000110;
                        end
            4'b0100    :   begin
                            Result = 8'b11001100;
                        end
            4'b0101    :   begin
                            Result = 8'b10100100;
                        end
            4'b0110    :   begin
                            Result = 8'b10000010;
                        end
            4'b0111    :   begin
                            Result = 8'b10001111;
                        end
            4'b1000    :   begin
                            Result = 8'b10000000;
                        end
            4'b1001    :   begin
                            Result = 8'b10000100;
                        end
            4'b1010    :   begin
                            Result = 8'b10001000;
                        end
            4'b1011    :   begin
                            Result = 8'b11100000;
                        end
            4'b1100    :   begin
                            Result = 8'b10110001;
                        end
            4'b1101    :   begin
                            Result = 8'b11000010;
                        end
            4'b1110    :   begin
                            Result = 8'b10110000;
                        end
            4'b1111    :   begin
                            Result = 8'b10111000;
                        end  
            default    :   begin
                            Result = 8'b10000001;
                        end 
        endcase                   
    end
endmodule