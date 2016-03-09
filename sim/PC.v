module PC(sinal_controle, clock, sinal_jump, pc_out, pc_jump);

  input sinal_controle, clock, sinal_jump;
  input [31:0] pc_jump;
  reg [31:0] pc_in;
  output reg [31:0] pc_out;

  initial begin
  		pc_in = 32'b00000000000000000000000000000000;
		pc_out = 32'b00000000000000000000000000000000;

  end


  always @(posedge clock) 
  begin
	if(sinal_controle) 
		if(pc_in < 32'b11111111111111111111111111111111) 
		  pc_out = (pc_in+1);
		else 
		  pc_out = 32'b00000000000000000000000000000000;
		  
	else if(sinal_jump) 
		 pc_out = pc_jump;
	
	pc_in = pc_out;	
  end

endmodule