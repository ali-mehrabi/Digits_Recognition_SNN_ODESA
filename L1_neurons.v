module L1_neurons
#(parameter p_width = 8,
  parameter p_shift = 8,
  parameter p_n = 10,
  parameter p_s = 25)
(
input  i_clk,
input  i_rst_n,
input  [p_s:1]                         i_event,
input  [p_n*p_s*p_width-1: 0]          i_weight,
input  [p_n*(p_width+p_shift+5)-1:0]   i_threshold,
output [p_n*(p_width+p_shift+5)-1:0]   o_sv,
output [p_s:1]                         o_sync,
output [p_n:1]                         o_spike
);

localparam p_thr_width = p_width+p_shift+5;
genvar i;
genvar j;

wire [p_s*p_width-1:0]          w_weight[p_n:1];
wire [p_thr_width-1:0]          w_threshold[p_n:1];
wire [p_thr_width-1:0]          w_neuronout[p_n:1];
wire [p_s:1]                    w_sync[p_n:1];
wire [p_n:1]                    w_index;
wire [p_n:1]                    w_spike_out;
wire                            w_is_event;
wire [p_thr_width-1:0]          w_sv[p_n:1];

assign o_spike = w_spike_out;
assign w_is_event = (i_event[p_s:1] == 0)? 1'b0:1'b1; 
assign o_sync = w_sync[1];

generate
for(i=1;i<= p_n;i=i+1)
begin: gen_weight_wires
      assign  w_weight[i] = i_weight[i*p_s*p_width-1:(i-1)*(p_s*p_width)];	
end

for(i=1;i<= p_n;i=i+1)
begin :gen_th_wires
  assign  w_threshold[i] = i_threshold[i*(p_thr_width)-1:(i-1)*(p_thr_width)];
  assign  o_sv[i*p_thr_width-1:(i-1)*p_thr_width] = w_sv[i];
end


for(i=1;i<= p_n;i=i+1)
begin:gen_neuron_i
neuron_25in
#(.p_width(p_width),
  .p_shift(p_shift)
 ) u_neuron
(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_event(i_event[p_s:1]),
	.i_weight(w_weight[i]),
	.i_threshold(w_threshold[i]),
	.o_s(w_sv[i]),
	.o_sync(w_sync[i]),
	.o_neuronout(w_neuronout[i])
);
end
endgenerate 


pulse #(.p_n(p_n)) upul_l1
(
	.i_index(w_index),
	.i_spike(w_is_event),
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.o_spike(w_spike_out)
);

	
comp_10in 
#(
.p_width(p_thr_width)
 ) u_comp10
(    
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
	.i_a(w_neuronout[1]),
	.i_b(w_neuronout[2]),
	.i_c(w_neuronout[3]),
	.i_d(w_neuronout[4]),
    .i_e(w_neuronout[5]),
	.i_f(w_neuronout[6]),
	.i_g(w_neuronout[7]),
	.i_h(w_neuronout[8]),
	.i_i(w_neuronout[9]),
    .i_j(w_neuronout[10]),	
	.o_result(),
	.o_index(w_index)
);

endmodule 