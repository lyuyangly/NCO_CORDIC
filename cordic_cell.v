/*
************************************************************************************************
*	File   : cordic_cell.v
*	Module : 
*	Author : Lyu Yang
*	Date   : 10,11,2014
*	Description : pipelined cordic cell
************************************************************************************************
*/
`timescale 1ns / 100ps
module cordic_cell #(
	parameter	VEC_WIDTH = 16,
	parameter	ANG_WIDTH = 16,
	parameter	THETA = 0,
	parameter	N = 0	)(
	input	wire							clk,
	input  	wire	signed	[VEC_WIDTH  :0] x_i,
	input  	wire	signed	[VEC_WIDTH  :0] y_i,
	input  	wire	signed	[ANG_WIDTH-1:0] z_i,
	output	reg 	signed	[VEC_WIDTH  :0] x_o,
	output	reg 	signed	[VEC_WIDTH  :0] y_o,
	output	reg 	signed	[ANG_WIDTH-1:0] z_o
);

always @ (posedge clk)
begin
	if (z_i[ANG_WIDTH-1] == 1'b0)	// theta is positive, Anti-clockwise
	begin
		x_o <= x_i - (y_i >>> N);
		y_o <= y_i + (x_i >>> N);
		z_o <= z_i - THETA;
	end
	else begin						// theta is negative, clockwise
		x_o <= x_i + (y_i >>> N);
		y_o <= y_i - (x_i >>> N);
		z_o <= z_i + THETA;
	end
end

endmodule
