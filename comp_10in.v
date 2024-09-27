module comp_10in
#(parameter  p_width = 19)
(
input                 i_clk,
input                 i_rst_n,
input  [p_width-1:0]  i_a,
input  [p_width-1:0]  i_b,
input  [p_width-1:0]  i_c,
input  [p_width-1:0]  i_d,
input  [p_width-1:0]  i_e,
input  [p_width-1:0]  i_f,
input  [p_width-1:0]  i_g,
input  [p_width-1:0]  i_h,
input  [p_width-1:0]  i_i,
input  [p_width-1:0]  i_j,
output [10:1]         o_index,
output [p_width-1:0]  o_result
);


wire [5:1] w_index1, w_index2;
wire [p_width-1:0] w_result1, w_result2;

assign o_index = (w_result1 >= w_result2)? {5'b0, w_index1} : {w_index2,5'b0};
assign o_result = (w_result1 >= w_result2)? w_result1 : w_result2;
comp_5in 
#(
.p_width(p_width)
 ) u_comp1
(    
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
	.i_a(i_a),
	.i_b(i_b),
	.i_c(i_c),
	.i_d(i_d),
    .i_e(i_e),	
	.o_result(w_result1),
	.o_index(w_index1)
	);
	
comp_5in 
#(
.p_width(p_width)
 ) u_comp2
(    
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
	.i_a(i_f),
	.i_b(i_g),
	.i_c(i_h),
	.i_d(i_i),
    .i_e(i_j),	
	.o_result(w_result2),
	.o_index(w_index2)
	);
	
endmodule	