module neuron_10in 
#(
parameter p_width = 8,
parameter p_shift = 8)
(
input   [10:1]                  i_event,
input                           i_rst_n,
input                           i_clk,
input   [10*p_width-1:0]        i_weight,
input   [p_width+p_shift+3:0]   i_threshold,
output  [p_width+p_shift+3:0]   o_neuronout,
output  [10:1]                  o_sync,
output  [p_width+p_shift+3:0]   o_s
);

localparam p_adder_width = p_width+p_shift;
wire [p_adder_width-1:0] w_a[10:1];
wire [p_width-1:0] w_weight[10:1];
genvar i; 

assign o_neuronout = (o_s> i_threshold) ? o_s:{(p_width+p_shift+4){1'b0}}; 
generate

for(i = 1; i<=10; i= i+1)
  begin:gen_weigths
    assign w_weight[i] = i_weight[i*p_width-1:(i-1)*p_width];
  end
for(i = 1; i<=10; i= i+1)
  begin:gen_synapse_i
	synapse 
	#(
	.p_width(p_width),
	.p_shift(p_shift) ) u_synapse_i
	(
	.i_event(i_event[i]),
	.i_rst_n(i_rst_n),
	.i_clk(i_clk),
	.i_weight(w_weight[i]),
	.o_sync(o_sync[i]),
	.o_do(w_a[i])
	);
  end
endgenerate

adder_10in
#(.p_width(p_adder_width)) u_adder_1
(
.i_a01(w_a[1]),
.i_a02(w_a[2]),
.i_a03(w_a[3]),
.i_a04(w_a[4]),
.i_a05(w_a[5]),
.i_a06(w_a[6]),
.i_a07(w_a[7]),
.i_a08(w_a[8]),
.i_a09(w_a[9]),
.i_a10(w_a[10]),
.o_s(o_s)
);
endmodule