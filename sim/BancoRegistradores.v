module BancoRegistradores (Hab_Escrita, Sel_C_A, Sel_B, reset, clock, A, B, WC);      

// Sel_C_A endereco da entrada de dados e da saida de dados A, sua função depende do estado de "Hab_Escrita"   
   
  input reset, clock;
  input [31:0] WC; 					// Novo registro
  input [3:0] Sel_C_A, Sel_B;
  input Hab_Escrita; 

  output reg [31:0] A, B;

  reg [31:0] registrador [15:0];	// Um vetor de 16 registradores de 32 bits

	  initial begin

	  	registrador[0] 	= 32'b00001000001000000000000000000000;
		registrador[1] 	= 32'b00000000000000000000000011000000;
		registrador[2] 	= 32'b00000000000000000000000100110000;
		registrador[3] 	= 32'b00000000001100000000000000000000;
		registrador[4] 	= 32'b00000000000011000000000000000000;
		registrador[5] 	= 32'b00000000000000000000000110000000;
		registrador[6] 	= 32'b00001000000000000001000000000000;
		registrador[7] 	= 32'b10000000000000000001000000000000;
		registrador[8] 	= 32'b10000000000000000000000000010000;
		registrador[9] 	= 32'b00000000000000000000000000010000;
		registrador[10]	= 32'b00000000000000000000000000000001;
		registrador[11]	= 32'b00000000000000000000000000000100;
		registrador[12]	= 32'b00000000000000000100000100000000;
		registrador[13]	= 32'b00000000000000000100000000100000;
		registrador[14]	= 32'b00000000000000100000000000100000;
		registrador[15]	= 32'b00000000000000000001000000000000;

	  end
	

	always @(negedge clock, posedge reset) begin
		  
		if(reset) begin 
			registrador[0] 	= 32'b00000000000000000000000000000000;
			registrador[1] 	= 32'b00000000000000000000000000000000;
			registrador[2] 	= 32'b00000000000000000000000000000000;
			registrador[3] 	= 32'b00000000000000000000000000000000;
			registrador[4] 	= 32'b00000000000000000000000000000000;
			registrador[5] 	= 32'b00000000000000000000000000000000;
			registrador[6] 	= 32'b00000000000000000000000000000000;
			registrador[7] 	= 32'b00000000000000000000000000000000;
			registrador[8] 	= 32'b00000000000000000000000000000000;
			registrador[9] 	= 32'b00000000000000000000000000000000;
			registrador[10]	= 32'b00000000000000000000000000000000;
			registrador[11]	= 32'b00000000000000000000000000000000;
			registrador[12]	= 32'b00000000000000000000000000000000;
			registrador[13]	= 32'b00000000000000000000000000000000;
			registrador[14]	= 32'b00000000000000000000000000000000;
			registrador[15]	= 32'b00000000000000000000000000000000;
		end

		else if(Hab_Escrita) begin 
			registrador[Sel_C_A] = WC; 
			A = registrador[Sel_C_A];
		end 

		else begin
			A = registrador[Sel_C_A]; 	   
			B = registrador[Sel_B];
		end
	end
	
endmodule