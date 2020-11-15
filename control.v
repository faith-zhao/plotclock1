module  control(
				clk,
				rst_n,
				time_h1,
				time_h2,
				time_m1,
				time_m2,
				sec,
				pwm_out1,
				pwm_out2,
				pwm_out3
);
input   clk;
input   rst_n;
input  [4:0]    time_h1;
input  [4:0]    time_h2;
input  [4:0]    time_m1;
input  [4:0]    time_m2;
input  [7:0]    sec;
output reg pwm_out1;
output reg pwm_out2;
output reg pwm_out3;

reg clk_20ms;
reg [7:0] x;
reg [7:0] y;
reg [31:0] cnt;
reg [31:0] cnt_clk;
reg [15:0] cnt_20ms;
wire [31:0] cnt_r1;
wire [31:0] cnt_r2;
reg [31:0] cnt_r3;

calculate calculate0(
    .x  (x),
    .y  (y),
    .result_1   (cnt_r1),
    .result_2   (cnt_r2)
);

always@(posedge clk_20ms or negedge rst_n)begin
    if(!rst_n) begin
        cnt_r3 <= 100000;
    end
    
    else if(sec>=0 && sec<2) begin               //抬动降1
        if(cnt_20ms <= 10) begin
            cnt_r3 <= 100000;
        end
        else if(cnt_20ms > 10 && cnt_20ms <= 90) begin
            case(time_h1)
                4'd0,4'd2,4'd3,4'd4,4'd7,4'd8: x <= 13 +7;
                4'd1,4'd5,4'd6,4'd9: x <= 21 +7;
                default;
            endcase
            case(time_h1)
                4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7: y <= 36;
                4'd8,4'd9: y <= 28;
                default;
            endcase
        end
        else if(cnt_20ms > 90 && cnt_20ms <= 100) begin
            cnt_r3 <= 156000;
        end
        else;
    end
    
    else if(sec>=2 && sec<4) begin          //画第一位
        if(cnt_20ms > 100+0 && cnt_20ms <= 100+8 ) begin               //1
            case(time_h1)
                0,2,3,7: x <= x+1;
                5,6,9: x <= x-1;
                8: y <= y+1;
                1,4: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 100+8 && cnt_20ms <= 100+16 ) begin              //2
            case(time_h1)
                4,8: x <= x+1;
                9: y <= y+1;
                0,1,2,3,5,6,7: y <= y-1;
            default;
            endcase
        end
        else if(cnt_20ms > 100+16 && cnt_20ms <= 100+24 ) begin              //3
            case(time_h1)
                5,9: x <= x+1;
                2,3: x <= x-1;
                4: y <= y+1;
                0,6,7,8: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 100+24 && cnt_20ms <= 100+32 ) begin              //4
            case(time_h1)
                3,6: x <= x+1;
                0: x <= x-1;
                2,4,5,8,9: y <= y-1;
                default;
            endcase
        end   
        else if(cnt_20ms > 100+32 && cnt_20ms <= 100+40 ) begin              //5
            case(time_h1)
                2: x <= x+1;
                5,8: x <= x-1;
                0,6: y <= y+1;
                3,4,9: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 100+40 && cnt_20ms <= 100+48 ) begin              //6
            case(time_h1)
                3,6,9: x <= x-1;
                0,8: y <= y+1;
                default;
            endcase
        end        
        else if(cnt_20ms > 100+48 && cnt_20ms <= 100+56 ) begin              //7
            case(time_h1)
                8: x <= x+1;
                default;
            endcase
        end  
        else;
    end
    
    else if(sec>=4 && sec<5) begin               //抬动降2
        if(cnt_20ms <= 200+10) begin
            cnt_r3 <= 100000;
        end
        else if(cnt_20ms > 200+10 && cnt_20ms <= 200+40) begin
            case(time_h2)
                4'd0,4'd2,4'd3,4'd4,4'd7,4'd8: x <= 13 + 11 +7;
                4'd1,4'd5,4'd6,4'd9: x <= 21 + 11 +7;
                default;
            endcase
            case(time_h2)
                4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7: y <= 36;
                4'd8,4'd9: y <= 28;
                default;
            endcase
        end
        else if(cnt_20ms > 200+40 && cnt_20ms <= 200+50) begin
            cnt_r3 <= 157500;
        end
        else;
    end   

    else if(sec>=5 && sec<7) begin          //画第二位
        if(cnt_20ms > 250+0 && cnt_20ms <= 250+8 ) begin               //1
            case(time_h2)
                0,2,3,7: x <= x+1;
                5,6,9: x <= x-1;
                8: y <= y+1;
                1,4: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 250+8 && cnt_20ms <= 250+16 ) begin              //2
            case(time_h2)
                4,8: x <= x+1;
                9: y <= y+1;
                0,1,2,3,5,6,7: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 250+16 && cnt_20ms <= 250+24 ) begin              //3
            case(time_h2)
                5,9: x <= x+1;
                2,3: x <= x-1;
                4: y <= y+1;
                0,6,7,8: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 250+24 && cnt_20ms <= 250+32 ) begin              //4
            case(time_h2)
                3,6: x <= x+1;
                0: x <= x-1;
                2,4,5,8,9: y <= y-1;
                default;
            endcase
        end   
        else if(cnt_20ms > 250+32 && cnt_20ms <= 250+40 ) begin              //5
            case(time_h2)
                2: x <= x+1;
                5,8: x <= x-1;
                0,6: y <= y+1;
                3,4,9: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 250+40 && cnt_20ms <= 250+48 ) begin              //6
            case(time_h2)
                3,6,9: x <= x-1;
                0,8: y <= y+1;
                default;
            endcase
        end        
        else if(cnt_20ms > 250+48 && cnt_20ms <= 250+56 ) begin              //7
            case(time_h2)
                8: x <= x+1;
                default;
            endcase
        end  
        else;
    end 
    
    else if(sec>=7 && sec<8) begin               //抬动降3
        if(cnt_20ms <= 350+10) begin
            cnt_r3 <= 100000;
        end
        else if(cnt_20ms > 350+10 && cnt_20ms <= 350+40) begin
            x <= 35 +7;
            y <= 35;
        end
        else if(cnt_20ms > 350+40 && cnt_20ms <= 350+50) begin
            cnt_r3 <= 154000;
        end
        else;
    end  
    
    else if(sec>=8 && sec<9) begin               //抬动降4
        if(cnt_20ms <= 400+10) begin
            cnt_r3 <= 100000;
        end
        else if(cnt_20ms > 400+10 && cnt_20ms <= 400+40) begin
            x <= 35 +7;
            y <= 25;
        end
        else if(cnt_20ms > 400+40 && cnt_20ms <= 400+50) begin
            cnt_r3 <= 154000;
        end
        else;
    end
    
    else if(sec>=9 && sec<10) begin               //抬动降5
        if(cnt_20ms <= 450+10) begin
            cnt_r3 <= 100000;
        end
        else if(cnt_20ms > 450+10 && cnt_20ms <= 450+40) begin
            case(time_m1)
                4'd0,4'd2,4'd3,4'd4,4'd7,4'd8: x <= 13 + 25 +7;
                4'd1,4'd5,4'd6,4'd9: x <= 21 + 25 +7;
                default;
            endcase
            case(time_m1)
                4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7: y <= 36;
                4'd8,4'd9: y <= 28;
                default;
            endcase
        end
        else if(cnt_20ms > 450+40 && cnt_20ms <= 450+50) begin
            cnt_r3 <= 154000;
        end
        else;
    end      
    
    else if(sec>=10 && sec<12) begin          //画第三位
        if(cnt_20ms > 500+0 && cnt_20ms <= 500+7 ) begin               //1
            case(time_m1)
                0,2,3,7: x <= x+1;
                5,6,9: x <= x-1;
                8: y <= y+1;
                1,4: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 500+7 && cnt_20ms <= 500+14 ) begin              //2
            case(time_m1)
                4,8: x <= x+1;
                9: y <= y+1;
                0,1,2,3,5,6,7: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 500+14 && cnt_20ms <= 500+21 ) begin              //3
            case(time_m1)
                5,9: x <= x+1;
                2,3: x <= x-1;
                4: y <= y+1;
                0,6,7,8: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 500+21 && cnt_20ms <= 500+28 ) begin              //4
            case(time_m1)
                3,6: x <= x+1;
                0: x <= x-1;
                2,4,5,8,9: y <= y-1;
                default;
            endcase
        end   
        else if(cnt_20ms > 500+28 && cnt_20ms <= 500+35 ) begin              //5
            case(time_m1)
                2: x <= x+1;
                5,8: x <= x-1;
                0,6: y <= y+1;
                3,4,9: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 500+35 && cnt_20ms <= 500+42 ) begin              //6
            case(time_m1)
                3,6,9: x <= x-1;
                0,8: y <= y+1;
                default;
            endcase
        end        
        else if(cnt_20ms > 500+42 && cnt_20ms <= 500+49 ) begin              //7
            case(time_m1)
                8: x <= x+1;
                default;
            endcase
        end  
        else;
    end 
    
    else if(sec>=12 && sec<13) begin               //抬动降6
        if(cnt_20ms <= 600+10) begin
            cnt_r3 <= 100000;
        end
        else if(cnt_20ms > 600+10 && cnt_20ms <= 600+40) begin
            case(time_m2)
                4'd0,4'd2,4'd3,4'd4,4'd7,4'd8: x <= 13 + 36 +7;
                4'd1,4'd5,4'd6,4'd9: x <= 21 + 36 +7;
                default;
            endcase
            case(time_m2)
                4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7: y <= 36;
                4'd8,4'd9: y <= 28;
                default;
            endcase
        end
        else if(cnt_20ms > 600+40 && cnt_20ms <= 600+50) begin
            cnt_r3 <= 154000;
        end
        else;
    end   

    else if(sec>=13 && sec<15) begin          //画第四位
        if(cnt_20ms > 650+0 && cnt_20ms <= 650+6 ) begin               //1
            case(time_m2)
                0,2,3,7: x <= x+1;
                5,6,9: x <= x-1;
                8: y <= y+1;
                1,4: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 650+6 && cnt_20ms <= 650+12 ) begin              //2
            case(time_m2)
                4,8: x <= x+1;
                9: y <= y+1;
                0,1,2,3,5,6,7: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 650+12 && cnt_20ms <= 650+18 ) begin              //3
            case(time_m2)
                5,9: x <= x+1;
                2,3: x <= x-1;
                4: y <= y+1;
                0,6,7,8: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 650+18 && cnt_20ms <= 650+24 ) begin              //4
            case(time_m2)
                3,6: x <= x+1;
                0: x <= x-1;
                2,4,5,8,9: y <= y-1;
                default;
            endcase
        end   
        else if(cnt_20ms > 650+24 && cnt_20ms <= 650+30 ) begin              //5
            case(time_m2)
                2: x <= x+1;
                5,8: x <= x-1;
                0,6: y <= y+1;
                3,4,9: y <= y-1;
                default;
            endcase
        end
        else if(cnt_20ms > 650+30 && cnt_20ms <= 650+36 ) begin              //6
            case(time_m2)
                3,6,9: x <= x-1;
                0,8: y <= y+1;
                default;
            endcase
        end        
        else if(cnt_20ms > 650+36 && cnt_20ms <= 650+42 ) begin              //7
            case(time_m2)
                8: x <= x+1;
                default;
            endcase
        end  
        else;
    end 

    else if(sec>=15 && sec<16) begin               //抬动降7到笔擦
        if(cnt_20ms <= 750+10) begin
            cnt_r3 <= 100000;
        end
        else if(cnt_20ms > 750+10 && cnt_20ms <= 750+40) begin
            x <= 77;
            y <= 46;
        end
        else if(cnt_20ms > 750+40 && cnt_20ms <= 750+50) begin
            cnt_r3 <= 154000;
        end
        else;
    end  

    else if(sec>=51 && sec<57) begin                //清屏
        cnt_r3 <= 158500;
        if(cnt_20ms > 2550 && cnt_20ms <= 2550+50) begin
            x <= 55 + 7;
            y <= 40;
        end
        else if(cnt_20ms > 2550+50 && cnt_20ms <= 2550+90) begin
            cnt_r3 <= 160000;
            x <= x-1;
        end
        else if(cnt_20ms > 2550+90 && cnt_20ms <= 2550+99) begin
            y <= y-1;
        end
        else if(cnt_20ms > 2550+99 && cnt_20ms <= 2550+139) begin
            x <= x+1;
        end     
        else if(cnt_20ms > 2550+139 && cnt_20ms <= 2550+148) begin
            cnt_r3 <= 158500;
            y <= y-1;
        end
        else if(cnt_20ms > 2550+148 && cnt_20ms <= 2550+186) begin
            x <= x-1;
        end
        else if(cnt_20ms > 2550+186 && cnt_20ms <= 2550+195) begin
            y <= y-1;
        end
        else if(cnt_20ms > 2550+195 && cnt_20ms <= 2550+235) begin
            x <= x+1;
        end     
        else if(cnt_20ms > 2550+235 && cnt_20ms <= 2550+244) begin
            y <= y-1;
        end
        else if(cnt_20ms > 2550+244 && cnt_20ms <= 2550+282) begin
            x <= x-1;
        end
        else;
    end
    
        else if(sec>=57 && sec<59) begin               //最后动到笔擦
            x <= 77;
            y <= 46;

        end
    
    else if(sec >=59 && sec <60) begin
        cnt_r3 <= 100000;
    end
    
    else begin
      cnt_r3 <= 154000; 
    end

end             //结束


always@(posedge clk or negedge rst_n)begin              //20ms计数
	if(!rst_n)
	   cnt_20ms <= 16'd0;
	else if(sec==59)
	   cnt_20ms <= 16'd0;
	else if(cnt_clk == 2000000)
	   cnt_20ms <= cnt_20ms + 1;
	else cnt_20ms <= cnt_20ms;
end

always@(posedge clk or negedge rst_n)begin              //普通cnt
	if(!rst_n)
		cnt <= 31'd0;
	else if(cnt >= 2000000)
		cnt <= 31'd0;
	else
		cnt <= cnt + 1'b1;
end
always@(posedge clk or negedge rst_n)begin              //为了便于20ms计数的cnt_clk
    if(!rst_n)
		cnt_clk <= 31'd0;
	else if(sec == 59)
		cnt_clk <= 31'd0;
	else if(cnt_clk >= 2000000)
		cnt_clk <= 31'd0;
	else
		cnt_clk <= cnt_clk + 1'b1;
end

always@(posedge clk or negedge rst_n)begin          //分频
    if(!rst_n)
        clk_20ms <= 31'd0;
	else if(sec == 59)
        clk_20ms <= 31'd0;
    else if(cnt_clk <= 1000000)
        clk_20ms <= 1;
    else
        clk_20ms <= 0;
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		pwm_out1 <= 1'b0;
	else if(cnt_clk <= cnt_r1)
		pwm_out1 <= 1'b1;
	else
		pwm_out1 <= 1'b0;
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		pwm_out2 <= 1'b0;
	else if(cnt_clk <= cnt_r2)
		pwm_out2 <= 1'b1;
	else
		pwm_out2 <= 1'b0;
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		pwm_out3 <= 1'b0;
	else if(cnt_clk <= cnt_r3)
		pwm_out3 <= 1'b1;
	else
		pwm_out3 <= 1'b0;
end

endmodule