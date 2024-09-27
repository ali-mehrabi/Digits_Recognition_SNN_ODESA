module  digits_network_tb();

reg r_clk, r_rst_n;
wire [10:1] w_output_spike;

always #10 r_clk <= ~ r_clk; 
initial 
begin
r_clk  = 0; 
r_rst_n = 0;
#25 r_rst_n = 1;
end


digits_network  u_network
(
	.i_clk(r_clk),
	.i_rst_n(r_rst_n),
	.o_output_spike(w_output_spike)
);


endmodule