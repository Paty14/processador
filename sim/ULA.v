module ULA(A, B, OP, RESULT, O, C, S, Z);


	input signed [31:0] A, B; 
	input [4:0] OP;

	output reg signed [31:0] RESULT;
	output reg O, C, S, Z;					
	reg [32:0] RegAuxiliar;		   			//Auxilia na identificação de carry e overflow


	initial begin

		assign O = 1'b0;
		assign C = 1'b0;
		assign S = 1'b0;
		assign Z = 1'b0;

	end

	always @(A or B or OP) begin


		case (OP)

			//operações aritméticas

			5'b00000: RegAuxiliar = A+B; 
			5'b00001: RegAuxiliar = A+B+1;
			5'b00011: RegAuxiliar = A+1;
			5'b00100: RegAuxiliar = A-B-1;
			5'b00101: RegAuxiliar = A-B;
			5'b00110: RegAuxiliar = A-1;

			//operações lógicas

			5'b01000:begin 					//deslocamento lógico
			   	RegAuxiliar = A << 1;
				C = RegAuxiliar[32];
				RESULT = RegAuxiliar[31:0];
			end
			5'b01001:begin					//deslocamento aritimetico
				C = A[0];
			   	RegAuxiliar = A >>> 1;
				RESULT = RegAuxiliar[31:0];
		    end
			5'b10011: RESULT = B;			//passb
			5'b11111: RESULT = 1;			//ones
			5'b10000: RESULT = 0;			//zeros
			5'b10001: RESULT = A & B;		//and
			5'b10010: RESULT = (~A) & B;	//andnota
			5'b10100: RESULT = A & (~B);	//andnotb
			5'b10101: RESULT = A;			//passa
			5'b10110: RESULT = A ^ B;		//xor
			5'b10111: RESULT = A | B;		//or
			5'b11000: RESULT = (~A) & (~B); //nad
			5'b11001: RESULT = ~(A ^ B);	//xnor
			5'b11010: RESULT = (~A);		//passnota
			5'b11011: RESULT = (~A) | (B);	//ornota
			5'b11100: RESULT = (~B);		//passnotb
			5'b11101: RESULT = A | (~B);	//ornotb
			5'b11110: RESULT = (~A) | (~B);	//nor

			//operações com constantes

			5'b01100: RESULT = B;			//loadlit
			5'b01101: RESULT = B | (A & 32'b00000000000000001111111111111111);	//lcl
			5'b01110: RESULT = B | (A & 32'b11111111111111110000000000000000);	//lch

			default : RESULT = 1'd0;

		endcase

		if (!(OP == 5'b11111))begin 		//Se não for a operação ones	 
			if(RESULT == 0)
				Z = 1;
			else
				Z = 0;
			if(!(OP==5'b10000))				//Se não for a operação zeros a flag de sinal é setada com o valor da posição mais significativa
				S = RESULT[31];			
		end

		if(OP==5'b00000 || OP==5'b00001 || OP==5'b00011 || OP==5'b00100 || OP==5'b00101 ||OP==5'b00110) begin
			C = RegAuxiliar[32];
			RESULT = RegAuxiliar[31:0];

			if ((A[31] == B[31]) && (RESULT[31] != A[31]))
				O = 1;
			else
				O = 0;
		end

	end
endmodule