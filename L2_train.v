
module L2_train
#(
parameter p_width = 8,
parameter p_shift = 8,
parameter p_n = 10,
parameter p_s = 5,
parameter p_deltaT = 'h3f,
parameter p_eta = 8, 
parameter p_default_thr = 19'hff00,
parameter p_default_w = 'hff)
(
 input                                  i_clk,
 input                                  i_trace_clk,
 input                                  i_rst_n,
 input  [p_n:1]                         i_lv2_spikeout,
 input  [p_s:1]                         i_syncout,
 input                                  i_endof_epochs, 
 input  [p_n:1]                         i_label,
 input  [p_n*(p_width+p_shift+4)-1:0]  i_sv,
 //output                                 o_gas,
 output [p_n*(p_s*p_width)-1:0]         o_weights,
 output [p_n*(p_width+p_shift+4)-1:0]  o_thresholds
);


localparam  p_thr_width = p_width+p_shift+4;
localparam  p_z = 8-$clog2(p_eta);

parameter p_wait_clks = 12;
parameter p_pass_lv2_2 = 11;
 
wire                         w_is_label;
wire                         w_is_winner;
wire [p_n*(p_s*p_width)-1:0] w_weights;
wire [p_n*p_thr_width-1:0]   w_thresholds;
wire  [p_thr_width-1:0]      w_sv[p_n:1];
wire  [p_thr_width-1:0]      w_lv[p_n:1];
wire  [p_width-1:0]          w_ts[p_s:1];

reg                          r_stop_n;
reg  [p_n:1]                 r_winner;
reg  [p_n:1]                 r_label;
//reg                          r_is_winner;
reg                          r_is_label;
reg                          r_training_active;
reg  [$clog2(p_wait_clks):0] r_counter;
reg  [p_width-1:0]           r_ts[p_s:1];
reg   [p_thr_width-1:0]      r_threshold[p_n:1];
reg   [p_width-1:0]          r_w[p_n:1][p_s:1];
reg   [2:0]                   r_state;

genvar i,j;
integer n,s;

function [p_width-1:0] calwt;
input [p_width-1:0]     a;
input [p_width-1:0]     b;
reg   [(p_width+8)-1:0] c;
begin
  c = {a,8'b0}- {a, {p_z{1'b0}}} + {b, {p_z{1'b0}}} ;
  calwt = c[(p_width+8)-1:8];
end	
endfunction	

function [p_thr_width-1:0] calthr;
input [p_thr_width-1:0] a,b; 
reg   [p_thr_width+8-1:0] c;
begin
  c = {a,8'b0}- {a,{p_z{1'b0}}} + {b, {p_z{1'b0}}};
  calthr = c[(p_thr_width+8)-1:8]; 
end	
endfunction	


assign w_is_winner = (i_lv2_spikeout == 0)? 0:1;
assign w_is_label  = (i_label==0)? 0: 1;


//assign w_spikeout = (i_lv2_spikeout == 0) ? 1'b0:1'b1; 
assign w_input_event_on  = ((i_syncout == 0))?  1'b0:1'b1; 
assign o_thresholds = {r_threshold[10],r_threshold[9], r_threshold[8],r_threshold[7], r_threshold[6],r_threshold[5],r_threshold[4], r_threshold[3],r_threshold[2], r_threshold[1]};
assign w_pass_l2 = (r_counter == p_pass_lv2_2)? 1'b1:1'b0;


generate
for(i=1;i<= p_n;i=i+1)
begin: gen_w_lv
  assign  w_sv[i] = i_sv[i*(p_thr_width)-1: (i-1)*(p_thr_width)];
end

for(i=1;i<= p_n;i=i+1)
  begin: gen_lv_reg
	lv_reg
	#(.p_width(p_thr_width)) u_lv
	(
		.i_spike(i_lv2_spikeout[i]),
		.i_rst_n(i_rst_n),
		.i_sv(w_sv[i]),
		.o_lv(w_lv[i])
	);
  end
  
for(i=1;i<= p_s;i=i+1)
  begin:gen_tracer
    tracer
	#(.p_width(p_width))  u_trace
	(
	.i_event(i_syncout[i]),
	.i_rst_n(i_rst_n),
	.i_clk(i_trace_clk),
	.o_trace(w_ts[i])
	);
  end
  
for(j=1; j<=p_n; j=j+1)
  begin:for_weights
	for(i=1; i<=p_s; i=i+1)
	  begin: gen_weight_assigns
		assign o_weights[((j-1)*p_s+i)*p_width - 1 : ((j-1)*p_s + i-1)*p_width] = r_w[j][i];
	  end
  end
 
for(i=1;i<=p_n;i=i+1) 
  begin:gen_latch
	always @(posedge i_lv2_spikeout[i] or negedge r_stop_n) 
	begin
	  if(!r_stop_n)
		  r_winner[i] <= 1'b0;
	  else 
		  r_winner[i] <= 1'b1; 
	end 
  end
endgenerate


always @(negedge w_is_winner or negedge i_rst_n)
   begin	
	 if(!i_rst_n)
		begin
		  for(s = 1; s<= p_s; s=s+1)
		     r_ts[s] <= {(p_width){1'b0}};		
		end
	  else
		begin
		  for(s = 1; s<= p_s; s=s+1)
		     r_ts[s] <= w_ts[s];	
		end
   end


always @(posedge i_clk or negedge i_rst_n) 
begin
  if(!i_rst_n)
     r_stop_n <= 1'b0;
  else 
    if(r_counter >= p_wait_clks) 
      r_stop_n <= 1'b0;
    else
      r_stop_n <= 1'b1; 
end

always @(posedge w_input_event_on or negedge r_stop_n) 
begin
  if(!r_stop_n)
    r_training_active <= 1'b0;
  else
    r_training_active <= 1'b1;
end

always @(negedge i_clk or negedge r_stop_n)
begin 
   if(!r_stop_n)
     r_counter <= 0;
   else if((r_is_label || (r_winner!= 0)) && !i_endof_epochs)
     r_counter <= r_counter +1'b1; 
end	

// Latch label
always @(posedge w_is_label or negedge r_stop_n)
begin
  if(!r_stop_n)
    r_is_label <= 1'b0;
  else
    r_is_label <= 1'b1;
end

always @(posedge w_is_label or negedge r_stop_n)
begin
  if(!r_stop_n)
    r_label <= 4'b0;
  else
    r_label <= i_label;
end


always@(posedge i_clk or negedge i_rst_n)
begin 
  if(!i_rst_n)
    begin
	for(n=1; n<=p_n; n=n+1)
	  begin
	    r_threshold[n] <= p_default_thr;
	    for(s=1; s<=p_s; s=s+1)
		  begin
	        r_w[n][s] <= p_default_w;
          end
	  end	  
	  r_state <= 0;
	end   
  else
	begin
	  if(w_pass_l2 & r_is_label) 
	     begin
		    if(r_winner == r_label)
			  begin
			    for(n=1; n<=p_n; n= n+1) 
				  begin
				    if(r_label[n]) 
					  begin
					    r_threshold[n] <= calthr(r_threshold[n],w_sv[n]);	
			            for(s=1;s<= p_s; s=s+1)
						  begin
						    r_w[n][s] <= calwt(r_w[n][s],r_ts[s]);
						  end
					  end
			      end
			  end
			else
			  begin  
			    for(n=1; n<=p_n; n= n+1) 
				  begin
				    if(r_label[n]) 
					  begin
					    r_threshold[n] <= r_threshold[n]- p_deltaT;	
					  end
			      end			  
			  end  
		 end
    end
end	

endmodule