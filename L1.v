module L1
#(parameter p_width = 8,
  parameter p_shift = 8,
  parameter p_n = 10,
  parameter p_s = 25,
  parameter p_deltaT = 'h3f,
  parameter p_eta = 8, 
  parameter p_default_thr = 'hff00,
  parameter p_default_w = 'hff)
(
input  i_clk,
input  i_rst_n,
input  [p_s:1]  i_event,
input  i_gas,
input  i_endof_epochs,
output [p_n:1]  o_spike
);


wire  [p_n*p_s*p_width-1: 0]          w_weight;
wire  [p_n*(p_width+p_shift+5)-1:0]   w_threshold;
wire  [p_n*(p_width+p_shift+5)-1:0]   w_sv;
wire  [p_s:1]                         w_sync;


L1_neurons
#(.p_width(p_width),
  .p_shift(p_shift),
  .p_n(p_n),
  .p_s(p_s)) u_l1_neurons
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



L1_train
#(
.p_width(p_width),
.p_shift(p_shift),
.p_n(p_n),
.p_s(p_s),
.p_deltaT(p_deltaT),
.p_eta(p_eta), 
.p_default_thr(p_default_thr),
.p_default_w (p_default_w)) u_l1_train
(
.i_clk(i_clk),
.i_trace_clk(i_clk),
.i_rst_n(i_rst_n),
.i_lvl_spikeout(o_spike),
.i_gas(i_gas),
.i_syncout(w_sync),
.i_endof_epochs(i_endof_epochs), 
.i_sv(w_sv),
.o_weights(w_weight),
.o_thresholds(w_threshold)
);
endmodule 