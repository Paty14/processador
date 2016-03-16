module MuxResul(ULA, MD, PC, saida, controle);
  input [1:0] controle;
  input [31:0] ULA, MD, PC; 
  output reg [31:0] saida; 
   
  	always @(controle or ULA or MD or PC)
 		case (controle)

 			2'b00: saida = ULA;
 			2'b01: saida = MD;
 			2'b10: saida = PC;
	
		endcase

endmodule