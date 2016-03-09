module RegistradorFlags(Z, C, S, O, controleOperacao, flags, clock, reset);

	input Z, C, S, O; 						// Flags 
	input [4:0] controleOperacao;   		// Controle que indica as operações
	output reg [3:0] flags;          		// Saída das flags
	input clock, reset;
	
always @(negedge clock or posedge reset or controleOperacao)
	begin
		if(reset) begin
			flags[0] = 1'b0;
			flags[1] = 1'b0;
			flags[2] = 1'b0;
			flags[3] = 1'b0;
		end
	
		case(controleOperacao)

			5'b00000, 5'b00001,
			5'b00011, 5'b00100,
			5'b00101, 5'b00110: begin 			// Atualiza todas as flags
				flags[0] = Z;
				flags[1] = C;
				flags[2] = S;	
				flags[3] = O;	
			end

			5'b01000, 5'b01001: begin 			// Atualiza as flags Z, C e S
				flags[0] = Z;
				flags[1] = C;
				flags[2] = S;
			end		
				
			5'b10001, 5'b10010, 
			5'b10100, 5'b10101, 
			5'b10110, 5'b10111, 
			5'b11000, 5'b11001, 
			5'b11010, 5'b11011, 
			5'b11100, 5'b11101, 
			5'b11110, 5'b10011: begin 			// Atualiza as flags Z e S
				flags[0] = Z;	
				flags[2] = S;	
			end

			5'b10000: flags[0] = Z;				// Atualiza a flag Z
				
			default: begin end 					// Não atualiza nenhuma flag

		endcase
	end

endmodule 