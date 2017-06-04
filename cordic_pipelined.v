/*
************************************************************************************************
*	File   : cordic_pipelined.v
*	Module : 
*	Author : Lyu Yang
*	Date   : 10,11,2014
*	Description : pipelined cordic
************************************************************************************************
*/
`timescale 1ns / 100ps
module cordic_pipelined #(
	parameter	VEC_WIDTH = 16,
	parameter	ANG_WIDTH = 16 )(
	input	wire							clk,
	input	wire		[ANG_WIDTH-1:0]		z_i,
	output	reg	signed	[VEC_WIDTH-1:0]		cos_o,
	output	reg	signed	[VEC_WIDTH-1:0]		sin_o
);

/* What is cordic?
	Iteration of following equation:
	Xi+1 = Xi + delta*Yi*2^(-i)
	Yi+1 = Yi - delta*Xi*2^(-i)
	Zi+1 = Zi + delta*arctan(2^(-i))
*/

// make sure that this can't be overflowed.
wire signed [VEC_WIDTH  :0] x [0:16];
wire signed [VEC_WIDTH  :0] y [0:16];
wire signed [ANG_WIDTH-1:0] z [0:16];

// 2^(N-1) * 0.6072529
assign x[0] = 17'sd19898;
assign y[0] = 17'sd0;

// PI/2 * 2^16 / 2*PI
wire [ANG_WIDTH-1:0] z_t = z_i - 16'd16384;

// [-PI/2 : PI/2] +PI/4 or -PI/4
assign z[0] = (z_t[ANG_WIDTH-1])? ($signed(z_t) + 16'sd8192) : ($signed(z_t) - 16'sd8192);

// Declare the shift register, remember the sign
reg		sr	[15:0];

// Declare an iterator
integer n;

always @ (posedge clk)
begin
	// Shift everything over, load the incoming data
	for (n = 15; n>0; n = n-1)
	begin
		sr[n] <= sr[n-1];
	end

	// Shift one position in
	sr[0] <= z_t[ANG_WIDTH-1];
end

// the last one
wire sel = sr[15];

// pipelined iteration N from 0 to 16
cordic_cell #(.THETA(16'sd4096),.N(0)) cell0
(
	.clk(clk),
	.x_i(x[0]),
	.y_i(y[0]), 
	.z_i(z[0]),
	.x_o(x[1]),
	.y_o(y[1]),
	.z_o(z[1])
);

cordic_cell #(.THETA(16'sd2418),.N(1)) cell1
(
	.clk(clk),
	.x_i(x[1]),
	.y_i(y[1]), 
	.z_i(z[1]),
	.x_o(x[2]),
	.y_o(y[2]),
	.z_o(z[2])
);

cordic_cell #(.THETA(16'sd1278),.N(2)) cell2
(
	.clk(clk),
	.x_i(x[2]),
	.y_i(y[2]), 
	.z_i(z[2]),
	.x_o(x[3]),
	.y_o(y[3]),
	.z_o(z[3])
);

cordic_cell #(.THETA(16'sd649),.N(3)) cell3
(
	.clk(clk),
	.x_i(x[3]),
	.y_i(y[3]), 
	.z_i(z[3]),
	.x_o(x[4]),
	.y_o(y[4]),
	.z_o(z[4])
);

cordic_cell #(.THETA(16'sd326),.N(4)) cell4
(
	.clk(clk),
	.x_i(x[4]),
	.y_i(y[4]), 
	.z_i(z[4]),
	.x_o(x[5]),
	.y_o(y[5]),
	.z_o(z[5])
);

cordic_cell #(.THETA(16'sd163),.N(5)) cell5
(
	.clk(clk),
	.x_i(x[5]),
	.y_i(y[5]), 
	.z_i(z[5]),
	.x_o(x[6]),
	.y_o(y[6]),
	.z_o(z[6])
);

cordic_cell #(.THETA(16'sd81),.N(6)) cell6
(
	.clk(clk),
	.x_i(x[6]),
	.y_i(y[6]), 
	.z_i(z[6]),
	.x_o(x[7]),
	.y_o(y[7]),
	.z_o(z[7])
);

cordic_cell #(.THETA(16'sd41),.N(7)) cell7
(
	.clk(clk),
	.x_i(x[7]),
	.y_i(y[7]), 
	.z_i(z[7]),
	.x_o(x[8]),
	.y_o(y[8]),
	.z_o(z[8])
);

cordic_cell #(.THETA(16'sd20),.N(8)) cell8
(
	.clk(clk),
	.x_i(x[8]),
	.y_i(y[8]), 
	.z_i(z[8]),
	.x_o(x[9]),
	.y_o(y[9]),
	.z_o(z[9])
);

cordic_cell #(.THETA(16'sd10),.N(9)) cell9
(
	.clk(clk),
	.x_i(x[9]),
	.y_i(y[9]), 
	.z_i(z[9]),
	.x_o(x[10]),
	.y_o(y[10]),
	.z_o(z[10])
);

cordic_cell #(.THETA(16'sd5),.N(10)) cell10
(
	.clk(clk),
	.x_i(x[10]),
	.y_i(y[10]), 
	.z_i(z[10]),
	.x_o(x[11]),
	.y_o(y[11]),
	.z_o(z[11])
);

cordic_cell #(.THETA(16'sd3),.N(11)) cell11
(
	.clk(clk),
	.x_i(x[11]),
	.y_i(y[11]), 
	.z_i(z[11]),
	.x_o(x[12]),
	.y_o(y[12]),
	.z_o(z[12])
);

cordic_cell #(.THETA(16'sd1),.N(12)) cell12
(
	.clk(clk),
	.x_i(x[12]),
	.y_i(y[12]), 
	.z_i(z[12]),
	.x_o(x[13]),
	.y_o(y[13]),
	.z_o(z[13])
);

cordic_cell #(.THETA(16'sd1),.N(13)) cell13
(
	.clk(clk),
	.x_i(x[13]),
	.y_i(y[13]), 
	.z_i(z[13]),
	.x_o(x[14]),
	.y_o(y[14]),
	.z_o(z[14])
);

cordic_cell #(.THETA(16'sd0),.N(14)) cell14
(
	.clk(clk),
	.x_i(x[14]),
	.y_i(y[14]), 
	.z_i(z[14]),
	.x_o(x[15]),
	.y_o(y[15]),
	.z_o(z[15])
);

cordic_cell #(.THETA(16'sd0),.N(15)) cell15
(
	.clk(clk),
	.x_i(x[15]),
	.y_i(y[15]), 
	.z_i(z[15]),
	.x_o(x[16]),
	.y_o(y[16]),
	.z_o(z[16])
);

wire signed [VEC_WIDTH:0] x_t = (sel) ? -y[16] : y[16];
wire signed [VEC_WIDTH:0] y_t = (sel) ? x[16] : -x[16];

// because of data bit is 16, so we can't let it overflow, thus [16'h8001-->16'h7FFF]
always @ (posedge clk)
begin
	cos_o <= (x_t[VEC_WIDTH]) ? ((x_t[VEC_WIDTH-1]==1'b1) ? x_t[15:0] : 16'h8001) : ((x_t[VEC_WIDTH-1]==1'b0) ?x_t[15:0] : 16'h7FFF);
	sin_o <= (y_t[VEC_WIDTH]) ? ((y_t[VEC_WIDTH-1]==1'b1) ? y_t[15:0] : 16'h8001) : ((y_t[VEC_WIDTH-1]==1'b0) ?y_t[15:0] : 16'h7FFF);
end
	
endmodule
