`timescale 1ns/1ns
module nco_tb;

reg clk;
reg rst;

// Clock Generation
initial
begin
	clk = 0;
	forever
		#5 clk = ~clk;
end

// Reset Generation 
initial
begin
		  rst = 0;
	#12 rst = 1;
end


initial
begin
	#10000 $stop;
end


wire signed [15:0] x_o, y_o;

// Install Moudle Under Test

nco dut
(
	.clk_i(clk),
	.rst_n(rst),
	.acc_i(32'd42949673),
	.cos_o(x_o), 
	.sin_o(y_o)
);

endmodule
