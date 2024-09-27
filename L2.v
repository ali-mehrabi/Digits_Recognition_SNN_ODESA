module  L2
#(parameter p_width = 8,
  parameter p_shift = 8,
  parameter p_n = 10,
  parameter p_s = 10,
  parameter p_deltaT = 'h0ff,
  parameter p_eta = 8, 
  parameter p_default_thr = 20'hff00,
  parameter p_default_w = 'hff)
(
input  i_clk,
input  i_rst_n,
input  [p_s:1]  i_event,
input  [p_n:1]  i_label,
input           i_endof_epochs,
output          o_gas,
output [p_n:1]  o_spike
);

assign o_gas = (i_label == 0)? 0:1;

wire  [p_n*p_s*p_width-1: 0]          w_weight;
wire  [p_n*(p_width+p_shift+4)-1:0]   w_threshold;
wire  [p_n*(p_width+p_shift+4)-1:0]   w_sv;
wire  [p_s:1]                         w_sync;


L2_neurons
#(.p_width(p_width),
  .p_shift(p_shift),
  .p_n(p_n),
  .p_s(p_s)) u_l2_neurons
(
.i_clk(i_clk),
.i_rst_n(i_rst_n),
.i_event(i_event),
.i_weight(w_weight),
.i_threshold(w_threshold),
.o_sv(w_sv),
.o_sync(w_sync),
.o_spike(o_spike)
);



L2_train
#(
.p_width(p_width),
.p_shift(p_shift),
.p_n(p_n),
.p_s(p_s),
.p_deltaT(p_deltaT),
.p_eta(p_eta), 
.p_default_thr(p_default_thr),
.p_default_w (p_default_w)) u_l2_train
(
.i_clk(i_clk),
.i_trace_clk(i_clk),
.i_rst_n(i_rst_n),
.i_lv2_spikeout(o_spike),
.i_syncout(w_sync),
.i_endof_epochs(i_endof_epochs),
.i_label(i_label), 
.i_sv(w_sv),
.o_weights(w_weight),
.o_thresholds(w_threshold)
);
endmodule 