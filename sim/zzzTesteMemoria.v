include "ram.v"; 

module zzzTesteMemoria();
  reg clock = 1'd1; 
  reg [12:0] count_stop = 1'd0;  
  reg[31:0] pc_out;
  
  always #5 clock = ~clock;		
    
  always begin
	#1
	if(count_stop>=13'b1001110001000) $stop;
	count_stop = count_stop+1'b1;
	
	if((count_stop/10)==0)
		pc_out = pc_out+1;
  end

  
  	ram ram(
	.CLK(clock), 
	.ADDRESS(pc_out),
	.WE(1'b1) 
	);
	
endmodule
