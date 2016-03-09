module MuxPC(BR, PC, saida, controle);
  input controle;
  input [31:0] BR, PC; 
  output reg [31:0] saida; 
   
   always @(controle or BR or PC)
	  	case(controle)

			1'b1: saida = BR;
			1'b0: saida = PC;	

		endcase
endmodule