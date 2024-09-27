module adder_5in
#(
parameter p_width= 16)
(
input  [p_width-1:0] i_a01,
input  [p_width-1:0] i_a02,
input  [p_width-1:0] i_a03,
input  [p_width-1:0] i_a04,
input  [p_width-1:0] i_a05,
output [p_width+2:0] o_s 
);

wire [p_width-1:0]  w_p0;
wire [p_width-1:0]  w_p1;
wire [p_width-1:0]  w_h0;
wire [p_width-1:0]  w_h1;
wire [p_width-1:0]  w_h2;
wire [p_width-1:0]  w_h3;
wire [p_width-1:0]  w_g0;
wire [p_width-1:0]  w_g1;
wire [p_width-1:0]  w_s;
wire [p_width-1:0]  w_c1;
wire [p_width-1:0]  w_c2;
assign w_s = w_p0^w_p1^i_a05;
assign w_p0 = i_a01^i_a02;
assign w_p1 = i_a03^i_a04;
assign w_g0 = i_a01&i_a02;
assign w_g1 = i_a03&i_a04;
assign w_h0 = i_a01 & i_a05;
assign w_h1 = i_a02 & i_a05;
assign w_h2 = i_a03 & i_a05;
assign w_h3 = i_a04 & i_a05;

assign w_c1 = (w_g0^w_g1^w_h0)^(w_h1^w_h2)^((w_p0&w_p1)^w_h3);
assign w_c2 = ((w_g0&w_g1) | (w_g0&w_h2)) | (w_g0&w_h3) | ((w_g1&w_h0) | (w_g1&w_h1));
assign o_s = {1'b0, w_c2, 2'b00} + {2'b0, w_c1, 1'b0} + {3'b00, w_s};

endmodule