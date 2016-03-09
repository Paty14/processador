
module UnidadeControle (clock, reset, instrucao, controlePC, ren, cen, BR_Sel_C_A, BR_Sel_B, Hab_Escrita_Banco, Hab_Escrita_Memoria, constante, EXcontrole, ULA_OP, hab_jump, atualizaFlag, condicaoJump, controle_MuxPC, Controle_Mux1, Controle_Mux2);


  input reset, clock;
  input  [31:0] instrucao;
  output reg [1:0] Controle_Mux2;
  output reg EXcontrole;
  output reg [3:0] BR_Sel_C_A, BR_Sel_B;
  output reg [2:0] condicaoJump;
  output reg [4:0] atualizaFlag;
  output reg [4:0] ULA_OP;
  output reg [15:0] constante;
  output reg controlePC, ren, cen, Hab_Escrita_Banco, Hab_Escrita_Memoria, Controle_Mux1, hab_jump, controle_MuxPC;
  reg [1:0] estado, prox_estado;
  reg [4:0] auxULA_OP; 


  initial begin
   estado = 2'b00; 
  end 

  always @(posedge clock) begin
  	estado <= prox_estado;
  end
     
  	always @(estado)
  	begin
	    case(estado)

		    //-----------------------------------------------------------IF-------------------------------------------------------------

		    2'b00:begin  
				prox_estado = 2'b01; 
				Hab_Escrita_Banco = 1'b0;
				ren = 1'b0; 
				controlePC = 1'b1;
				
		    end

		    //------------------------------------------------------------ID------------------------------------------------------------

		    2'b01:begin 
		        prox_estado = 2'b10;                                                                                       
				controlePC = 1'b0; 	 
				ren = 1'b0; 
				Hab_Escrita_Memoria = 1'b0;
				Hab_Escrita_Banco = 1'b0; 
				controle_MuxPC = 1'b1;									 


				if(instrucao[31:29] == 3'b001) begin					  // Operações de lógica e aritmética
					BR_Sel_C_A = instrucao[19:16];                                                                          
				    BR_Sel_B = instrucao[15:12]; 
				end
				

				else if (instrucao[31:29] == 3'b010) begin                // Operações constante                                                    
					constante = instrucao[15:0];  
					BR_Sel_C_A = instrucao[23:20]; 	                                                                        
					EXcontrole = 1'b0;  
				end

				
				else if(instrucao[31:29] == 3'b100) begin 				   // Operações de acesso à memória                
				    BR_Sel_C_A = instrucao[19:16];                                                                          
				    BR_Sel_B = instrucao[15:12];  			
				end 
			
				 
				else if(instrucao[31:29] == 3'b000) begin                  // Operações de Jump
					if(instrucao[26:24] == 3'b000) begin 				   // Jump False
						EXcontrole = 1'b1;        
						condicaoJump = instrucao[14:12];      
						hab_jump = 1'b0;    
						controle_MuxPC = 1'b0;	
					end 

					else if(instrucao[26:24] == 3'b001) begin              // Jump True
						EXcontrole = 1'b1; 
						condicaoJump = instrucao[14:12];
						hab_jump = 1'b1;
						controle_MuxPC = 1'b0; 
						
					end 

					else if(instrucao[26:24] == 3'b010) begin              // Jump Incondicional
						constante = instrucao[11:0];                                                                          
						EXcontrole = 1'b1;
					end
				end

				else if(instrucao[31:29] == 3'b110) begin                  // Operações de Jump and link e register
					if(instrucao[26:24] == 3'b011) begin                   // Jump and link
						BR_Sel_B = 4'b1111;								   // Escreve no registrador 15 o valor de PC+1
						Controle_Mux2 = 2'b01;                             // Indica que a saída do mux será o pc+1
						Hab_Escrita_Banco = 1'b1;                          // Habilita a escrita no banco de registradores
						BR_Sel_B = instrucao[15:12];                       // Manda para a saída do banco o valor do registrador referenciado por RB
					end 

					else if(instrucao[26:24] == 3'b100) begin              // Jump register
						BR_Sel_B = instrucao[15:12];					   // Manda para a saída do banco o valor do registrador referenciado por RB
					end 
				end
			end

			//-----------------------------------------------------------EX-------------------------------------------------------------
		      
		    2'b10:begin    
		        prox_estado = 2'b11;
				condicaoJump = 3'b111;
				Controle_Mux1 = 1'b1;       									


				if(instrucao[31:29] == 3'b110) begin  						
					if (instrucao[26:24] == 3'b011) begin  					// Se é jump and link
						auxULA_OP[4:0] = 5'b10011;    						// Operação passb (pego o valor da saída B do banco de registradores)
						condicaoJump = 3'b000;       						// Indica por testador de flags pra fazer o jump
						hab_jump = 1'b1;              						// Indico que a condição precisa ser verdadeira 
					end
				end
				
				if(instrucao[31:29] == 3'b100) begin 						// Memória
					Controle_Mux1 = 1'b0; 
					if(instrucao[24] == 1'b1) begin							// Store
						Hab_Escrita_Banco = 1'b0;  
						Hab_Escrita_Memoria = 1'b1;
					end	
					else begin                                                                       
						auxULA_OP[1:0] = instrucao[24];  
					end 
				end
				
							
			    if(instrucao[31:29] == 3'b000) 
					if(instrucao[26:24] == 3'b010) begin                    // Jump Incondicional
						controle_MuxPC = 1'b0;
						auxULA_OP[4:0] = 5'b00000;							// Operação de add
						condicaoJump = 3'b000;
						hab_jump = 1'b1;	
					end  
				
					if(instrucao[26:24] == 3'b000) begin                    // Jump False
						condicaoJump = instrucao[14:12];
						hab_jump = 1'b0;
						
					end 

					if(instrucao[26:24] == 3'b001) begin                 	// Jump True
						condicaoJump = instrucao[14:12];
						hab_jump = 1'b1;
						
					end
				
					auxULA_OP[4:2] = instrucao[31:29];  
				    ULA_OP = auxULA_OP;

				end

		    //-----------------------------------------------------------WB-------------------------------------------------------------

		    2'b11:begin  
		        prox_estado = 2'b00;
						
				Controle_Mux2 = 2'b00;		
				Hab_Escrita_Banco = 1'b1;	
				BR_Sel_C_A = instrucao[23:20];
				hab_jump = 1'b0;
				
				if((instrucao[31:29] == 3'b100) & (instrucao[24] == 1'b0))     // Load
				    Controle_Mux2 = 2'b01;
					
				if(
					((instrucao[31:29] == 3'b100) & (instrucao[24] == 1'b1)) |
					(instrucao[31:29] == 3'b000) | (instrucao[31:29] == 3'b110)  // operacao Store ou Jump
				) 	
					Hab_Escrita_Banco = 1'b0;
				
		     end

		    //--------------------------------------------------------------------------------------------------------------------------

		    default: begin 
				prox_estado = 2'b00;
			end
	     
	    endcase

	end //fim do always

endmodule

