module ID-EX(clock, PC, MI, A, B, extensor, ULA, MD)

input clock;
input [31:0] PC, MI, A, B, extensor, ULA, MD; 
input [1:0] controleMuxResul;	
input ControleEXtensor, controleMuxExtensor, controleMD, OpULA, controleMuxPC, Hab_EscritaBanco, controleRF;


output reg [31:0] saida_PC, saida_MI, saida_A, saida_B, saida_extensor, saida_ULA, saida_MD;
output reg [1:0] s_controleMuxResul;
output reg  s_ControleEXtensor, s_controleMuxExtensor, s_controleMD, s_OpULA, s_controleMuxPC, s_Hab_EscritaBanco, s_controleRF;


	always @ (posedge clock) begin

		saida_PC = PC;
		saida_MI = MI;
		saida_A = A;
		saida_B = B;
		saida_extensor = extensor;
		s_ControleEXtensor = ControleEXtensor;
		s_controleMuxExtensor = controleMuxExtensor;
		s_controleMD = controleMD;
		s_OpULA = OpULA;
		s_controleMuxPC = controleMuxPC;
		s_Hab_EscritaBanco = Hab_EscritaBanco;
		s_controleRF = controleRF;
		saida_ULA = ULA;
		saida_MD = MD;
		s_controleMuxResul = controleMuxResul;

	end

endmodule