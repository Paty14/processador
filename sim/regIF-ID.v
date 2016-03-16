module regIF (clock, PC, MI);      
 
  input [31:0] PC, MI; 								
  output reg [31:0] saida_PC, saida_MI;
    

	always @(posedge clock) begin

		saida_PC = PC;
		saida_MI = MI;
		
	end
	
endmodule

