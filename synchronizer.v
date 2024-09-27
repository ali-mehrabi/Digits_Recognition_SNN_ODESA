
module synchronizer
(
input                 i_event,
input                 i_clk,
input                 i_clr,
output                o_syncout
);

wire w_q1;
wire w_syncout;
assign  o_syncout = w_syncout;

flipflop ff1
( 
	.i_d(1'b1),
	.i_clk(i_event),
	.i_clr(i_clr),
	.o_q(w_q1),
	.o_qb()
);

flipflop ff2
( 
	.i_d(w_q1),
	.i_clk(i_clk),
	.i_clr(i_clr),
	.o_q(w_syncout),
	.o_qb()
);

endmodule 