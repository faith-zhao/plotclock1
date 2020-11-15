
module seg_scan(
	input           clk,
	input           rst_n,
	output reg[7:0] seg_sel,      
	output reg[7:0] seg_data,     
	output reg[7:0] seg_datatwo,
	input[7:0]      seg_data_0,
	input[7:0]      seg_data_1,
	input[7:0]      seg_data_2,
	input[7:0]      seg_data_3,
	input[7:0]      seg_data_4,
	input[7:0]      seg_data_5
);
parameter SCAN_FREQ = 200;     
parameter CLK_FREQ = 100000000; 

parameter SCAN_COUNT = CLK_FREQ /(SCAN_FREQ * 6) - 1;

reg[31:0] scan_timer;  
reg[31:0] scan_timertwo;
reg[3:0] scan_sel;     
reg[3:0] scan_seltwo;
always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		scan_timer <= 32'd0;
		scan_sel <= 4'd0;
	end
	else if(scan_timer >= SCAN_COUNT)
	begin
		scan_timer <= 32'd0;
		if(scan_sel == 4'd3)
			scan_sel <= 4'd0;
		else
			scan_sel <= scan_sel + 4'd1;
	end
	else
		begin
			scan_timer <= scan_timer + 32'd1;
		end
end
always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		seg_sel <= 6'b000000;
		seg_data <= 8'hff;
	end
	else
	begin
		case(scan_sel)
			4'd0:
			begin
				seg_sel[3:0] <= 4'b0001;
				seg_data <= seg_data_0;
			end
			4'd1:
			begin
				seg_sel[3:0] <= 4'b0010;
				seg_data <= seg_data_1;
			end
			4'd2:
			begin
				seg_sel[3:0] <= 4'b0100;
				seg_data <= seg_data_2;
			end
			4'd3:
			begin
				seg_sel[3:0] <= 4'b1000;
				seg_data <= seg_data_3;
			end

			default:
			begin
				seg_sel[3:0] <= 4'b0000;
				seg_data <= 8'hff;
			end
		endcase
		
		case(scan_seltwo)
            4'd0:
            begin
                seg_sel[7:4] <= 4'b0001;
                seg_datatwo <= seg_data_4;
            end
            4'd1:
            begin
                seg_sel[7:4] <= 4'b0010;
                seg_datatwo <= seg_data_5;
            end
            4'd2:
            begin
                seg_sel[7:4] <= 4'b0100;
                seg_datatwo <= 0;
            end
            4'd3:
            begin
                seg_sel[7:4] <= 4'b1000;
                seg_datatwo <= 0;
            end
			default:
            begin
                seg_sel[7:4] <= 4'b0000;
                seg_datatwo <= 8'hff;
            end	
            endcase
    end
end

always@(posedge clk or negedge rst_n)
begin
	if(rst_n == 1'b0)
	begin
		scan_timertwo <= 32'd0;
		scan_seltwo <= 4'd0;
	end
	else if(scan_timertwo >= SCAN_COUNT)
	begin
		scan_timertwo <= 32'd0;
		if(scan_seltwo == 4'd3)
			scan_seltwo <= 4'd0;
		else
			scan_seltwo <= scan_seltwo + 4'd1;
	end
	else
		begin
			scan_timertwo <= scan_timertwo + 32'd1;
		end
end

endmodule