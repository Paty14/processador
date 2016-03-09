include "ram.v";  
include "PC.v";  


module IF(clock, instrucao, controle_PC, jumpPC, habJump, pc_out, WE, ren);
	input habJump, clock;
    input wire [31:0] jumpPC;
    input wire controle_PC, WE, ren;
	output [31:0] instrucao;
	output wire [31:0] pc_out;

	ram ram(
	.CLK(clock), 
	.ADDRESS(pc_out),
	.Q(instrucao), 
	.WE(ren) 
	);
	
	PC PC(
	.clock(clock), 
	.pc_out(pc_out),
	.sinal_controle(controle_PC),
	.pc_jump(jumpPC), 
	.sinal_jump(habJump)
	);

endmodule 
