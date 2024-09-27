
module auto_trainer
#(
parameter  p_sample_num = 10,
parameter  p_sample_len = 10,
parameter  p_spike_delay = 200,
parameter  p_pattern_delay = 200,
parameter  p_epochs = 400
)
(
input          i_clk,
input          i_rst_n,
output         o_end_of_epochs,
output [25:1]  o_test_vector,
output [10:1]  o_label
);


parameter  p_test_len = 10;//p_sample_num * p_sample_len;


reg                                r_end_of_epochs;
reg   [2:0]                        r_state; 
reg   [$clog2(p_test_len-1):0]     r_address; 
reg   [34:0]                       r_data;
reg   [$clog2(p_pattern_delay):0]  r_counter;
reg   [$clog2(p_epochs):0]         r_epochs;
reg   [$clog2(p_spike_delay):0]    r_sp_counter;
reg   [34:0]                       r_ram[0:9]; 
 

assign o_test_vector = r_data[34:10];
assign o_label       = r_data[9:0];
assign o_end_of_epochs = r_end_of_epochs;

initial
begin
$readmemb("\digits1d.mem" ,r_ram); 
end




always @(posedge ~i_clk or negedge i_rst_n) 
begin 
if(!i_rst_n) 
  begin
    r_state   <= 0; 
	r_data    <= 0; 
	r_counter <= 0;
	r_address <= 0;
	r_epochs  <= 1;
	r_end_of_epochs <= 0;
	r_sp_counter <= 0;
  end
else 
   case(r_state) 
    0:begin 
	    if(r_counter < p_pattern_delay) 
		   r_counter <= r_counter+1;
		else 
		  begin
		    r_counter <= 0;
			r_state <= 1;
		  end
	  end
	1:begin
        r_data <= r_ram[r_address];
		r_state <= 2;
      end	
	2:begin
		r_data <= 0;
		r_state<=3;
		/*if (r_sp_counter < p_spike_delay)
		   r_sp_counter <= r_sp_counter+1;
		else
		  begin
            r_sp_counter <= 0;
		    if(r_counter < p_sample_len - 1)
		      begin
		        r_counter <= r_counter+1;
			    r_address <= r_address+1;
				r_state <= 1;
		      end
		    else
		      begin
		        r_counter <= 0;
		  	    r_state <= 3;
		      end
		  end	*/  
	  end 
	3:begin	 
        if(r_counter < p_pattern_delay)
		  r_counter <= r_counter+1;
		else
		  begin
		    r_counter <= 0; 
		    if(r_address < (p_test_len-1)) 
              begin		
			    r_address <= r_address+1;
			    r_state <= 1;
			  end
			else
			  r_state <= 4;
		  end
	  end	  	
	4:begin
		if(r_epochs < p_epochs) 
		  begin
		    r_epochs <= r_epochs+1;
			r_address <= 0;
		    r_state <= 0;
		  end
		else
	      r_end_of_epochs <=1;
	  end		  
   endcase
end

endmodule

