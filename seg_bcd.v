module seg_bcd(
	input clk,
	input rst_n,
	output[7:0] seg_sel,
	output[7:0] seg_data,
	output[7:0] seg_datatwo,
	input [23:0]seg_bcd
);

wire[6:0] seg7_data_0;
seg_decoder seg_decoder_m0(
	.bin_data(seg_bcd[23:20]),
	.seg_data(seg7_data_0)
);
wire[6:0] seg7_data_1;
seg_decoder seg_decoder_m1(
	.bin_data(seg_bcd[19:16]),
	.seg_data(seg7_data_1)
);
wire[6:0] seg7_data_2;
seg_decoder seg_decoder_m2(
	.bin_data(seg_bcd[15:12]),
	.seg_data(seg7_data_2)
);
wire[6:0] seg7_data_3;
seg_decoder seg_decoder_m3(
	.bin_data(seg_bcd[11:8]),
	.seg_data(seg7_data_3)
);
wire[6:0] seg7_data_4;
seg_decoder seg_decoder_m4(
	.bin_data(seg_bcd[7:4]),
	.seg_data(seg7_data_4)
);

wire[6:0] seg7_data_5;
seg_decoder seg_decoder_m5(
	.bin_data(seg_bcd[3:0]),
	.seg_data(seg7_data_5)
);
wire[7:0] seg_data_0;
wire[7:0] seg_data_1;
wire[7:0] seg_data_2;
wire[7:0] seg_data_3;
wire[7:0] seg_data_4;
wire[7:0] seg_data_5;
assign seg_data_0 = {1'b0,seg7_data_0};
assign seg_data_1 = {1'b1,seg7_data_1};
assign seg_data_2 = {1'b0,seg7_data_2};
assign seg_data_3 = {1'b1,seg7_data_3};
assign seg_data_4 = {1'b0,seg7_data_4};
assign seg_data_5 = {1'b0,seg7_data_5};
seg_scan seg_scan_m0(
	.clk(clk),
	.rst_n(rst_n),
	.seg_sel(seg_sel),
	.seg_data(seg_data),
	.seg_datatwo(seg_datatwo),
	.seg_data_0(seg_data_0),
	.seg_data_1(seg_data_1),
	.seg_data_2(seg_data_2),
	.seg_data_3(seg_data_3),
	.seg_data_4(seg_data_4),
	.seg_data_5(seg_data_5)
);
endmodule 