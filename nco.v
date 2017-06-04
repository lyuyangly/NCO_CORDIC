/*
************************************************************************************************
*	File   : NCO.v
*	Module : 
*	Author : Lyu Yang
*	Date   : 10,11,2014
*	Description : pipelined nco
************************************************************************************************
*/
`timescale 1ns / 100ps
module nco #(
	parameter	VEC_WIDTH = 16,
	parameter	ANG_WIDTH = 16,
	parameter	ACC_WIDTH = 32	)(
	input	wire						clk_i,
	input	wire						rst_n,
	input	wire	[ACC_WIDTH-1:0]		acc_i,
	output	signed	[VEC_WIDTH-1:0]		cos_o,
	output	signed	[VEC_WIDTH-1:0]		sin_o
	);

/* What is cordic?
	Iteration of following equation:
	Xi+1 = Xi + delta*Yi*2^(-i)
	Yi+1 = Yi - delta*Xi*2^(-i)
	Zi+1 = Zi + delta*arctan(2^(-i))
*/

// Accumulator
reg		[ACC_WIDTH-1:0]		acc;

always @ (posedge clk_i, negedge rst_n)
begin
	if (!rst_n)
		acc <= 'd0;
	else
		acc <= acc + acc_i;
end

wire [ANG_WIDTH-1:0] z_i = acc[ACC_WIDTH-1 : ACC_WIDTH-ANG_WIDTH+1];

cordic_pipelined #(
	.VEC_WIDTH		(VEC_WIDTH),
	.ANG_WIDTH		(ANG_WIDTH)
)	cordic_inst (
	.clk			(clk_i),
	.z_i			(z_i),
	.cos_o			(cos_o), 
	.sin_o			(sin_o)
);
	
endmodule
