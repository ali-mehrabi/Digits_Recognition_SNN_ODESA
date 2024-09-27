module wlif
#(
parameter p_width = 8,
parameter p_nbit = 8)
(
input                        i_event,
input                        i_rst_n,
input                        i_clk,
input   [p_width-1:0]        i_weight,
output                       o_clr,
output  [p_width+p_nbit-1:0] o_do
);

wire [p_width + p_nbit - 1:0]  w_shifted_weight;
reg  [p_width + p_nbit-1:0]    r_mul_counter;
reg                            r_state;

assign w_shifted_weight = {i_weight, {(p_nbit){1'b0}}};
always @(posedge i_clk or negedge i_rst_n) 
begin 
  if(!i_rst_n)	
      r_mul_counter <= 0;	  
  else 
     case(i_event)
	    1:begin
            r_mul_counter <= w_shifted_weight; 
          end
       0:begin
			if(r_mul_counter > i_weight)
			   r_mul_counter <= r_mul_counter - i_weight;
			else 
			   r_mul_counter <= 0;
          end
      endcase		  
end

always @(posedge i_clk or negedge i_rst_n) 
begin 
  if(!i_rst_n)	  
	r_state <= 1'b0;
  else
    case(r_state)
	 0:begin
		 r_state <= 1'b1;	 
	   end
	 1:begin
         if(i_event) 
		    r_state <= 1'b0;	 
	   end	   		   
	endcase   
end
assign o_clr = ~r_state;
assign o_do  = r_mul_counter[p_width+p_nbit-1:0];
endmodule 