include "IntegradorGeral.v";

module testeIntegracao();


	reg clock;
	integer arquivo, count_clock=-10, count_stop = 1'd0, numero_falhas=0, numero_acertos=0;
    reg [31:0]instrucao, AUX, pc_out, A, B, constanteExtendida, Saida_ULA, Saida_MemoriaDados;
	
    IntegradorGeral integradorGeral(
    	.clock(clock)
    );
  
	initial begin
	    clock=1;
		arquivo = $fopen("TesteControle.txt");
	end
	
	always #5 clock = ~clock;					//delay de 5 pulsos
  
	always begin
		instrucao = integradorGeral.instrucao; 
		pc_out = integradorGeral.IF.PC.pc_out;
		A = integradorGeral.ID.A;
		B = integradorGeral.ID.B;
		constanteExtendida = integradorGeral.ID.constanteExtendida;
		Saida_ULA = integradorGeral.EX.Saida_ULA;
		Saida_MemoriaDados = integradorGeral.Saida_MemoriaDados;
		
		if(count_clock==6) 
			$fdisplay(arquivo,"PC (antes) %b  Instrução %b ", pc_out, instrucao);	
		
		if(count_clock==11) 
			$fdisplay(arquivo,"PC (depois) %b", pc_out);
		
		//------------------------------------------------- operações tipo R ------------------------------------------------
		if(count_clock==16) begin
			if(instrucao[31:29] == 3'b001) begin		      
				$fdisplay(arquivo,"A >> Endereço_Registro %b : Dado_Registro %b = %d ", instrucao[19:16], A, A);
		        $fdisplay(arquivo,"B >> Endereço_Registro %b : Dado_Registro %b = %d ", instrucao[15:12], B, B);				
			end 

		//------------------------------------------------- operações com constante ------------------------------------------------
			else if(instrucao[31:29] == 3'b010)           
		        $fdisplay(arquivo,"Const. >> Constante %b = %d : Constante_Extendida %b = %d ", instrucao[15:0], instrucao[15:0], constanteExtendida, constanteExtendida);				
		end

		//------------------------------------------------- operações de acesso à memória -------------------------------------------
		if(count_clock==26)begin       // load
			if((instrucao[31:29] == 3'b100) & (instrucao[24] == 1'b0))
				$fdisplay(arquivo,"Mem[%b] : Saida Mem %b = %d", instrucao[19:16], Saida_MemoriaDados, Saida_MemoriaDados); 
				 
			if((instrucao[31:29] == 3'b100) & (instrucao[24] == 1'b1)) begin     // store
				$fdisplay(arquivo,"B : Saida B %b = %d",B, B); 
				$fdisplay(arquivo,"End. Mem %b = %d ", A, A); 
			    $fdisplay(arquivo,"Mem[A] Antes %b = %d ", Saida_MemoriaDados, Saida_MemoriaDados);
		 	end 
		end
		
		if(count_clock==31)begin
			if((instrucao[31:29] == 3'b100) & (instrucao[24] != 1'b1)) begin     //store
			   $fdisplay(arquivo,"End. C %b = %d ", instrucao[23:20], instrucao[23:20]); 
			   $fdisplay(arquivo,"C Antes %b = %d ", A, A); 
			end
		end
		
		if(count_clock==36)begin
			if((instrucao[31:29] == 3'b100) & (instrucao[24] == 1'b1)) 
			   $fdisplay(arquivo,"Mem[A] Depois %b = %d \n", Saida_MemoriaDados, Saida_MemoriaDados);
			else
			   $fdisplay(arquivo,"C Depois %b = %d \n", A, A); 
		end

		//------------------------------------------------- operações com constante -------------------------------------------
		
		if(count_clock==27) begin
			if(instrucao[31:29] == 3'b010) begin 
				AUX[31:16] =  {16{instrucao[15]}};
				AUX[15:0] =  instrucao[15:0];
				$fdisplay(arquivo,"C = Constante");
			end
				
			if(instrucao[31:29] == 3'b010) begin
				if(instrucao[28:24] == 5'b01101) begin                                                                              
					AUX = instrucao[15:0];
					AUX = AUX | (A & 32'b11111111111111110000000000000000);
					$fdisplay(arquivo,"C = Const16 | (C&0xffff0000)");
				end 
				else if(instrucao[28:24] == 5'b01110) begin 
					AUX = 32'b00000000000000000000000000000000;
					AUX[31:16] = instrucao[15:0]; 					
					AUX = AUX | (A & 32'b00000000000000001111111111111111);
					$fdisplay(arquivo,"C = (Const16 « 16) | (C&0x0000ffff)");
				end  
			end  
		end

		//------------------------------------------------- operações R -----------------------------------------------------
					
			if((instrucao[31:29] == 3'b001) & (instrucao[28:24])) 
				case (instrucao[28:24])
					5'b00000: begin AUX = A+B; 			$fdisplay(arquivo,"C = A+B"); end
					5'b00001: begin AUX = A+B+1; 		$fdisplay(arquivo,"C = A+B+1"); end
					5'b00011: begin AUX = A+1; 			$fdisplay(arquivo,"C = A+1"); end
					5'b00100: begin AUX = A-B-1; 		$fdisplay(arquivo,"C = A-B-1"); end
					5'b00101: begin AUX = A-B; 			$fdisplay(arquivo,"C = A-B"); end
					5'b00110: begin AUX = A-1; 			$fdisplay(arquivo,"C = A-1"); end			
					5'b01000: begin AUX = A << 1; 		$fdisplay(arquivo,"C = A << 1"); end
					5'b01001: begin AUX = A >>> 1; 		$fdisplay(arquivo,"C = A >>> 1"); end
					5'b10011: begin AUX = B; 			$fdisplay(arquivo,"C = B"); end
					5'b11111: begin AUX = 1; 			$fdisplay(arquivo,"C = 1"); end
					5'b10000: begin AUX = 0; 			$fdisplay(arquivo,"C = 0"); end
					5'b10001: begin AUX = A & B; 		$fdisplay(arquivo,"C = A & B"); end
					5'b10010: begin AUX = (~A) & B; 	$fdisplay(arquivo,"C = (~A) & B"); end
					5'b10100: begin AUX = A & (~B); 	$fdisplay(arquivo,"C = A & (~B)"); end
					5'b10101: begin AUX = A; 			$fdisplay(arquivo,"C = A"); end
					5'b10110: begin AUX = A ^ B; 		$fdisplay(arquivo,"C = A ^ B"); end
					5'b10111: begin AUX = A | B; 		$fdisplay(arquivo,"C = A | B"); end
					5'b11000: begin AUX = (~A) & (~B); 	$fdisplay(arquivo,"C = (~A) & (~B)"); end
					5'b11001: begin AUX = ~(A ^ B); 	$fdisplay(arquivo,"C = ~(A ^ B)"); end
					5'b11010: begin AUX = (~A); 		$fdisplay(arquivo,"C = (~A)"); end
					5'b11011: begin AUX = (~A) | (B); 	$fdisplay(arquivo,"C = (~A) | (B)"); end
					5'b11100: begin AUX = (~B); 		$fdisplay(arquivo,"C = (~B)"); end
					5'b11101: begin AUX = A | (~B); 	$fdisplay(arquivo,"C = A | (~B)"); end
					5'b11110: begin AUX = (~A) | (~B); 	$fdisplay(arquivo,"C = (~A) | (~B)"); end
				endcase

			$fdisplay(arquivo,"Resultado Obtido %b = %d - Resultado Esperado %b = %d", Saida_ULA, Saida_ULA, AUX, AUX);
			if(Saida_ULA != AUX)begin
				numero_falhas=numero_falhas+1;
				$fdisplay(arquivo,"Falha");
			end
			else begin
				numero_acertos=numero_acertos+1;
				$fdisplay(arquivo,"Acerto");
			end

		//-----------------------------------------------------------simulando --------------------------------------------------------
		
		if(count_stop<=11000) begin	
			$fdisplay(arquivo,"Falhas = %d", numero_falhas);
			$fdisplay(arquivo,"Acertos = %d", numero_acertos);
			$fclose(arquivo);
			
		end	
		
		if(count_clock>=40)               // Contador Ciclos
			count_clock = 0;
		#1
		count_stop = count_stop+1;
		count_clock = count_clock+1;
	end	
endmodule 
