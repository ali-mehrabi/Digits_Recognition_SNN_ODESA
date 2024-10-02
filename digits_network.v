module  digits_network
(
input         i_clk,
input         i_rst_n,
output [10:1] o_output_spike
);

parameter p_width1 = 8;
parameter p_shift1 = 7;
parameter p_width2 = 8;
parameter p_shift2 = 7;
parameter p_n1 = 10;
parameter p_s1 = 25;
parameter p_n2 = 10;
parameter p_s2 = 10;
parameter p_deltaT1 = 'h7ff;
parameter p_deltaT2 = 'h1ff;
parameter p_eta1 = 8; 
parameter p_eta2 = 8; 
parameter p_default_thr1 = 'h08000;
parameter p_default_thr2 = 'h08000;
parameter p_default_w1 = 'hff;
parameter p_default_w2 = 'hff;

// training spikes parameters
parameter p_spike_delay = 10;
parameter p_pattern_delay = 400;
parameter p_sample_num = 10;
parameter p_sample_len = 5;
parameter p_epochs = 1000; 
  
wire  [p_s1:1]  w_test_vector;
wire            w_epochs;
wire  [p_n1:1]  w_l1_spikes;
wire  [p_n2:1]  w_label;
wire  w_gas;
L1
#(
	.p_width(p_width1),
	.p_shift(p_shift1),
	.p_n(p_n1),
	.p_s(p_s1),
	.p_deltaT(p_deltaT1),
	.p_eta(p_eta1), 
	.p_default_thr(p_default_thr1),
	.p_default_w(p_default_w1))      u_l1
(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_gas(w_gas),
	.i_event(w_test_vector),
	.i_endof_epochs(w_epochs),
	.o_spike(w_l1_spikes)
);



L2
#(
	.p_width(p_width2),
	.p_shift(p_shift2),
	.p_n(p_n2),
	.p_s(p_s2),
	.p_deltaT(p_deltaT2),
	.p_eta(p_eta2), 
	.p_default_thr(p_default_thr2),
	.p_default_w(p_default_w2)
) u_l2
(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_event(w_l1_spikes),
	.i_endof_epochs(w_epochs),
	.i_label(w_label),
	.o_gas(w_gas),
	.o_spike(o_output_spike)
);




auto_trainer #(
.p_sample_num(p_sample_num),
.p_sample_len(p_sample_len),
.p_spike_delay(p_spike_delay),
.p_pattern_delay(p_pattern_delay),
.p_epochs(p_epochs)
) u_trainer 
(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.o_end_of_epochs(w_epochs),
	.o_test_vector(w_test_vector),
	.o_label(w_label)
);

endmodule