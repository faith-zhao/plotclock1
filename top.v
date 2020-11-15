module top(
    input        clk,   
    input        rst_n,
    output       rtc_sclk,
    output       rtc_ce,
    inout        rtc_data,
    output [7:0] seg_sel,
    output [7:0] seg_data,
    output [7:0] seg_datatwo,
    output pwm_out1,
    output pwm_out2,
    output pwm_out3
    );

wire[7:0] read_second;
wire[7:0] read_minute;
wire[7:0] read_hour;
wire[7:0] read_date;
wire[7:0] read_month;
wire[7:0] read_week;
wire[7:0] read_year;
wire[7:0] second;
assign second = 10 * read_second[7:4] + read_second[3:0];

seg_bcd seg_bcd_m0(
    .clk          (clk),
    .rst_n        (rst_n),
    .seg_sel      (seg_sel),
    .seg_data     (seg_data),
    .seg_datatwo     (seg_datatwo),
    .seg_bcd      ({read_hour,read_minute,read_second})
);

control control_m0(
    .clk        (clk),
    .rst_n      (rst_n),
    .time_h1    (read_hour[7:4]),
    .time_h2    (read_hour[3:0]),
    .time_m1    (read_minute[7:4]),
    .time_m2    (read_minute[3:0]),
    .sec        (second),
    .pwm_out1   (pwm_out1),
    .pwm_out2   (pwm_out2),
    .pwm_out3   (pwm_out3)
);


ds1302_test ds1302_test_m0(
    .rst         (~rst_n),
    .clk         (clk),
    .ds1302_ce   (rtc_ce),
    .ds1302_sclk (rtc_sclk),
    .ds1302_io   (rtc_data),
    .read_second (read_second),
    .read_minute (read_minute),
    .read_hour   (read_hour),
    .read_date   (read_date),
    .read_month  (read_month),
    .read_week   (read_week),
    .read_year   (read_year)
);
endmodule 
    
    