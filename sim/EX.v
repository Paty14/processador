include "RegistradorFlags.v";
include "TestadorFlags.v";
include "MuxPC.v";
include "MuxExtensor.v";
include "ULA.v";
include "memoriaDados.v";

module EX(clock, controleMuxExtensor, ULA_OP, A, B, constanteExtendida, Saida_ULA, PC, controleMuxPC, atualizaFlag, condicaoJump, Jump_True_False, hab_jump, Saida_MemoriaDados, Hab_EscritaMemoria);
  input clock;
  input wire controleMuxExtensor, controleMuxPC, Jump_True_False, Hab_EscritaMemoria;
  input [4:0] ULA_OP;
  input [2:0] condicaoJump;
  input [4:0] atualizaFlag;
  input [31:0] A, B, constanteExtendida, PC;
  output [31:0] Saida_ULA, Saida_MemoriaDados;
  output hab_jump;
  wire [31:0] saida_Mux, saida_MuxPC; 
  wire Z, C, S, O;
  wire [3:0] ZCSO;
  
  TestadorFlags TestadorFlags(
  .flags(ZCSO), 
  .condicao(condicaoJump), 
  .opcode(Jump_True_False), 
  .mux(hab_jump)
  );
  
  
  RegistradorFlags RegistradorFlags(
		.Z(Z), 
		.C(C), 
		.S(S), 
		.O(O), 
		.controleOperacao(atualizaFlag), 
		.flags(ZCSO),
		.clock(clock)
	);
  
  
  MuxPC MuxPC(
  .BR(A), 
  .PC(PC), 
  .saida(saida_MuxPC),
  .controle(controleMuxPC)
  );
  

  MuxExtensor MuxExtensor(
  .BR(B), 
  .EX(constanteExtendida), 
  .saida(saida_Mux),
  .controle(controleMuxExtensor)
  );
  

  ULA ULA(
  .A(saida_MuxPC), 
  .B(saida_Mux), 
  .OP(ULA_OP), 
  .RESULT(Saida_ULA),
  .Z(Z), 
  .C(C), 
  .S(S), 
  .O(O)
  );  
  
  memoriaDados memoriaDados (
  .CLK(clock),
  .ADDRESS(A),
  .DATA(B), 
  .Q(Saida_MemoriaDados),
  .WE(Hab_EscritaMemoria)  
  );


endmodule 