module adder_10in
#(
parameter p_width= 16)
(
input  [p_width-1:0] i_a01,
input  [p_width-1:0] i_a02,
input  [p_width-1:0] i_a03,
input  [p_width-1:0] i_a04,
input  [p_width-1:0] i_a05,
input  [p_width-1:0] i_a06,
input  [p_width-1:0] i_a07,
input  [p_width-1:0] i_a08,
input  [p_width-1:0] i_a09,
input  [p_width-1:0] i_a10,
output [p_width+3:0] o_s 
);

wire [p_width+2:0] w_s1;
wire [p_width+2:0] w_s2;

adder_5in
#(.p_width(p_width)) u_adder_1
(
.i_a01(i_a01),
.i_a02(i_a02),
.i_a03(i_a03),
.i_a04(i_a04),
.i_a05(i_a05),
.o_s(w_s1)
);

adder_5in
#(.p_width(p_width)) u_adder_2
(
.i_a01(i_a06),
.i_a02(i_a07),
.i_a03(i_a08),
.i_a04(i_a09),
.i_a05(i_a10),
.o_s(w_s2)
);
assign o_s = {1'b0,w_s1} + {1'b0, w_s2};
endmodule