module tracer
#(parameter p_width = 8)
(
input                    i_event,
input                    i_rst_n,
input                    i_clk,
output  [p_width-1:0]    o_trace
);
//this version can get up to two spikes. 
//parameter p_decay_width = p_width;
reg  [p_width:0]         r_counter;
always @(posedge i_clk or negedge i_rst_n) 
begin 
  if(!i_rst_n)	
    r_counter <= 0; 
  else
    begin
      if(i_event) 
        r_counter <= {(p_width){1'b1}}; //+r_counter
      else 
	    if(r_counter > 0)
	      begin
            r_counter <= r_counter - 1;
	      end
	end	  
end
assign o_trace  = r_counter;
endmodule 