module auto_trainer_tb();

reg r_clk, r_rst_n;
wire w_end_of_epochs;
wire [5:1] w_test_vector;
wire [10:1] w_label;

auto_trainer
#(
.p_sample_num(10),
.p_sample_len(5),
.p_spike_delay(8),
.p_pattern_delay(5000),
.p_epochs(400)
) u_test_trainer
  (
	.i_clk(r_clk),
	.i_rst_n(r_rst_n),
	.o_end_of_epochs(w_end_of_epochs),
	.o_test_vector(w_test_vector),
	.o_label(w_label)
  );

always #10 r_clk <= ~ r_clk; 
initial 
begin
r_clk  = 0; 
r_rst_n = 0;
#25 r_rst_n = 1;
end

endmodule