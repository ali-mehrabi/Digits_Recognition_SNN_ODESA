module comp_5in
#(parameter  p_width = 19)
(
input                 i_clk,
input                 i_rst_n,
input  [p_width-1:0]  i_a,
input  [p_width-1:0]  i_b,
input  [p_width-1:0]  i_c,
input  [p_width-1:0]  i_d,
input  [p_width-1:0]  i_e,
output [5:1]          o_index,
output [p_width-1:0]  o_result
);

wire  [4:0]  w_l1, w_l2, w_l3, w_l4, w_index;
wire  w_z, w_t1, w_t2, w_t3, w_t4;
wire  [p_width-1:0] w_a1, w_a2, w_a3, w_a4;
reg   [4:0] r_index;
assign w_z = ((i_a | i_b | i_c | i_d | i_e)==0)? 1'b1:1'b0;

assign w_t1 = (i_a>=i_b)?   1'b1:1'b0;
assign w_t2 = (i_c>= w_a3)? 1'b1:1'b0;
assign w_t3 = (i_d>=i_e)?   1'b1:1'b0;
assign w_t4 = (w_a1>=w_a2)? 1'b1:1'b0;

assign w_a1 = (w_t1)? i_a: i_b;
assign w_a2 = (w_t2)? i_c: w_a3;
assign w_a3 = (w_t3)? i_d: i_e;
assign w_a4 = (w_t4)? w_a1: w_a2;
assign o_result = w_z? {p_width{1'b0}}:w_a4;
assign w_l1 = (w_t1)? 5'b00001: 5'b00010;
assign w_l2 = (w_t2)? 5'b00100: w_l3;
assign w_l3 = (w_t3)? 5'b01000: 5'b10000;
assign w_l4 = (w_t4)? w_l1: w_l2;
assign w_index = w_z? 5'b00000:w_l4;
wire w_nclk; 
assign w_nclk = ~i_clk;
assign o_index = r_index;
always @( posedge w_nclk or negedge i_rst_n)
begin
if(!i_rst_n) 
  r_index <= 5'b00000;
else 
  r_index <= w_index;
end

endmodule