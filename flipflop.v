
module flipflop 
( 
input   i_d,
input   i_clk,
input   i_clr,
output  o_q,
output  o_qb
);
wire   w_reset;
assign w_reset = ~i_clr;
reg     r_q;
assign  o_q  = r_q;
assign  o_qb = (i_clr == 1'b1)? 1'b1:~r_q;

always @(posedge i_clk or negedge w_reset)
begin
if(!w_reset)
  r_q <= 1'b0;
else 
  r_q <= i_d;
end

endmodule
