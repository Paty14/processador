module TestadorFlags(mux, opcode, condicao, flags);

	input opcode; 							// indica se é jtrue ou jfalse
	input [3:0] flags; 						// Z = 0; C = 1; S = 2; O = 3
	input [2:0] condicao;   				// sinal de controle que vem da UC.
	output reg mux; 
	
	
	always @(opcode or flags or condicao)	
		case (condicao)

			3'b000: begin 					// Condição TRUE
				if (opcode)begin			//jtrue
					mux = 1'b1;	
				end
				else begin					//jfalse
					mux = 1'b0;
				end
			end
	
			3'b001: begin  					// resultado da ALU deu negativo
				if (opcode) begin			//jtrue
					if(flags[2]) mux = 1'b1;
					else mux = 1'b0;
				end
				else begin					//jfalse
					if(flags[2]) mux = 1'b0;
					else mux = 1'b1;
				end
			end

			3'b101: begin 					//Resultado ALU zero
				if (opcode)begin			//jtrue
					if(flags[0]) mux = 1'b1;
					else mux = 1'b0;
				end
				else begin					//jfalse
					if (flags[0]) mux = 1'b0;
					else mux = 1'b1;
				end
			end

			3'b100: begin 					//Carry da ALU
				if (opcode)begin			//jtrue
					if(flags[1]) mux = 1'b1;
					else mux = 1'b0;
				end
				else begin					//jfalse
					if (flags[1]) mux = 1'b0;
					else mux = 1'b1;
				end
			end

			3'b101: begin 					//Resultado ALU negativo ou zero
				if (opcode)begin			//jtrue
					if(flags[0] || flags[2]) mux = 1'b1;
					else mux = 1'b0;
				end
				else begin					//jfalse
					if (flags[0] || flags[2]) mux = 1'b0;
					else mux = 1'b1;
				end
			end

			3'b111: begin 					//Resultado ALU overflow
				if (opcode)begin			//jtrue
					if(flags[3]) mux = 1'b1;
					else mux = 1'b0;
				end
				else begin					//jfalse
					if (flags[3]) mux = 1'b0;
					else mux = 1'b1;
				end
			end

			default: mux = 1'b0;
								
		endcase
	
endmodule