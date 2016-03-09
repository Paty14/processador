module MuxExtensor(BR, EX, saida, controle);
  input controle;
  input [31:0] BR, EX; 
  output reg [31:0] saida; 
  
 	always @(controle or BR or EX)

		case (controle)
			1'b0: saida = BR;
			1'b1: saida = EX;	
		endcase
		
	endmodule