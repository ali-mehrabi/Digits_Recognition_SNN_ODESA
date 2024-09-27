module neuron_25in
#(
parameter p_width = 8,
parameter p_shift = 8)
(
input   [25:1]                 i_event,
input                          i_rst_n,
input                          i_clk,
input   [p_width+p_shift+4:0]  i_threshold,
input   [25*p_width-1:0]       i_weight,
output  [25:1]                 o_sync,
output  [p_width+p_shift+4:0]  o_s,
output  [p_width+p_shift+4:0]  o_neuronout
);
localparam p_add_width = p_width+p_shift+4;

wire [p_add_width-1:0]  w_s1;
wire [p_add_width-1:0]  w_s2;
wire [p_add_width-2:0]  w_s3;
wire [p_add_width+0:0]  w_neuron_sum;
wire [10*p_width -1:0]  w_weight1;
wire [10*p_width -1:0]  w_weight2;
wire [ 5*p_width -1:0]  w_weight3;
assign o_neuronout = (w_neuron_sum > i_threshold) ? w_neuron_sum:{(p_width+p_shift+5){1'b0}}; 

assign o_s = w_neuron_sum;

assign w_neuron_sum = w_s1+w_s2+ {3'b0,w_s3};


assign w_weight1 = i_weight[10*p_width -1: 0]; 
assign w_weight2 = i_weight[20*p_width -1: 10*p_width];
assign w_weight3 = i_weight[25*p_width -1: 20*p_width];
 

subn_10in 
#(
.p_width(p_width),
.p_shift(p_shift)) u_subn_1
(
.i_event(i_event[10:1]),
.i_rst_n(i_rst_n),
.i_clk(i_clk),
.i_weight(w_weight1),
.o_sync(o_sync[10:1]),
.o_s(w_s1)
);


subn_10in 
#(
.p_width(p_width),
.p_shift(p_shift)) u_subn_2
(
.i_event(i_event[20:11]),
.i_rst_n(i_rst_n),
.i_clk(i_clk),
.i_weight(w_weight2),
.o_sync(o_sync[20:11]),
.o_s(w_s2)
);

subn_5in 
#(
.p_width(p_width),
.p_shift(p_shift)) u_subn_3
(
.i_event(i_event[25:21]),
.i_rst_n(i_rst_n),
.i_clk(i_clk),
.i_weight(w_weight3),
.o_sync(o_sync[25:21]),
.o_s(w_s3)
);


endmodule