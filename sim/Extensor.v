module Extensor(Controle, ConstanteIn, ConstanteOut);

	input Controle; 
	input [15:0] ConstanteIn;
	output reg [31:0] ConstanteOut; 
	
	
	always @(Controle or ConstanteIn)	begin	// Mudanca
		case(Controle)
			1'b0: begin  							// loadlit, lcl e lch
				ConstanteOut[31:16] =  {16{ConstanteIn[15]}};
				ConstanteOut[15:0] = ConstanteIn[15:0];
			end
			
			1'b1: begin 							// jump
				ConstanteOut[31:12] =  {20{ConstanteIn[11]}};
				ConstanteOut[11:0] = ConstanteIn[11:0];
			end 
			
		endcase
	end
endmodule