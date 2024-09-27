module pulse
#(parameter p_n = 5)
(
input      [p_n:1] i_index,
input            i_spike,
input            i_clk,
input            i_rst_n,
output     [p_n:1] o_spike
);

parameter  p_pass_delay = 3;
wire       w_q1;
wire       w_is_spike;
wire       w_is_spike_latched;
wire       w_rst;
reg       r_rst;
reg [1:0] r_state;
reg [2:0] r_counter;
reg [p_n:1] r_index;

assign o_spike = (r_state==2)? r_index: {p_n{1'b0}}; 
assign w_rst = ~r_rst ;
assign w_is_spike = (i_index == 0) ? 1'b0:1'b1;


flipflop u_i_spike_latch
( 
	.i_d(1'b1),
	.i_clk(i_spike),
	.i_clr(r_rst),
	.o_q(w_q1),
	.o_qb()
);

flipflop u_index_latch
( 
	.i_d(w_is_spike),
	.i_clk(i_clk),
	.i_clr(r_rst),
	.o_q(w_is_spike_latched),
	.o_qb()
);

always@(posedge i_clk or negedge w_rst)
begin
  if(!w_rst) 
    r_counter <= 3'b0;
  else if(w_q1)
    r_counter <= r_counter +1'b1;
end

always@(posedge i_clk or negedge i_rst_n)
begin
  if(!i_rst_n) 
    begin
      r_rst <= 1; 
	  r_state <= 0; 
	  r_index <= 0;
	end
  else
    begin
       case(r_state)
	    0:begin
		    r_rst <= 0;
		    if(w_is_spike_latched & w_q1)
			  r_state <= 1;
			else if (r_counter >=3'b011)
			  r_state <= 3;
		  end
	    1:begin
		    r_rst <= 1;
			r_index <= i_index;
			r_state <= 2;
		  end
	    2:begin
		   // r_rst <= 1;
			r_state <= 3;
		  end		  
	    3:begin
		    r_index <= 0;
		    r_state <= 0;
			r_rst <= 1;
		  end		  
       endcase		  
    end	
end

endmodule

