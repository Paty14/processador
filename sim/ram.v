// -----------------------------------------------------------------------------
// AUTHOR: Matheus Borges   
// 
// Alteração: Patricia Gomes
// -----------------------------------------------------------------------------

`ifndef ROM_FILE
  `define ROM_FILE "rom.out"
`endif

module ram(Reset, WE, CLK, ADDRESS, Q);

  input  Reset, WE, CLK;
  input [31:0] ADDRESS;          // Endereço
  output reg[31:0] Q;            // Saída

  parameter dim = 1024;
  reg[31:0] ram_mem[0:dim-1];

  initial
	$readmemh(`ROM_FILE, ram_mem); 

	always @ (negedge CLK) begin
		if(Reset)  
			Q = {32{1'b0}};
		if(WE)		
			Q = ram_mem[ADDRESS];			
	end
endmodule
