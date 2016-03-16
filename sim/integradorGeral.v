include "IF.v"; 
include "ID.v";
include "EX.v";
include "UnidadeControle.v";
include "MuxResul.v";
include "memoriaDados.v";
include "MuxExtensor.v";

module IntegradorGeral(clock, reset);
  input clock, reset;
  wire controlePC, ren, Hab_Escrita_Banco, Hab_Escrita_Memoria, Controle_Mux1, Jump_True_False, controle_MuxPC, hab_jump;
  wire [1:0] Controle_MuxResul;
  wire EXcontrole;
  wire [3:0]  BR_Sel_C_A, BR_Sel_B;
  wire [2:0] condicaoJump;
  wire [4:0] atualizaFlag;
  wire [4:0] ULA_OP;
  wire [15:0] constante;
  wire [31:0] instrucao, Saida_ULA, Saida_MemoriaDados, A, B, constanteExtendida, PC;

  
  UnidadeControle UnidadeControle(
    .clock(clock), 
    .reset(1'b0), 
    .instrucao(instrucao),
    .Controle_Mux2(Controle_MuxResul), 
    .EXcontrole(EXcontrole),
    .BR_Sel_C_A(BR_Sel_C_A), 
    .BR_Sel_B(BR_Sel_B),
    .condicaoJump(condicaoJump),
    .atualizaFlag(atualizaFlag),
    .ULA_OP(ULA_OP),
    .constante(constante), 
    .ren(ren),
    .Hab_Escrita_Banco(Hab_Escrita_Banco), 
    .Hab_Escrita_Memoria(Hab_Escrita_Memoria),
    .Controle_Mux1(Controle_Mux1),
    .hab_jump(Jump_True_False),
    .controle_MuxPC(controle_MuxPC),
    .controlePC(controlePC)
  );

  
  IF IF(
    .clock(clock), 
    .instrucao(instrucao),
    .controle_PC(controlePC), 
    .ren(ren), 
    .jumpPC(Saida_ULA),
    .habJump(hab_jump),
    .pc_out(PC)
  );

  
  ID ID(
    .clock(clock), 
    .BR_HabEscrita(Hab_Escrita_Banco), 
    .EXcontrole(EXcontrole), 
    .Sel_C_A(BR_Sel_C_A), 
    .Sel_B(BR_Sel_B),   
    .constante(constante), 
    .A(A), 
    .B(B), 
    .constanteExtendida(constanteExtendida),
    .controle(Controle_MuxResul), 
    .MD(Saida_MemoriaDados),
    .PC(PC),
    .ULA(Saida_ULA)
  );
  

  EX EX(
    .clock(clock),  
    .ULA_OP(ULA_OP), 
    .A(A), 
    .B(B), 
    .constanteExtendida(constanteExtendida),
    .Saida_ULA(Saida_ULA), 
    .PC(PC),
    .controleMuxPC(controle_MuxPC),
    .atualizaFlag(atualizaFlag),
    .condicaoJump(condicaoJump),
    .hab_jump(hab_jump),
    .Jump_True_False(Jump_True_False),
    .Hab_EscritaMemoria(Hab_Escrita_Memoria),
    .controleMuxExtensor(Controle_Mux1),
    .Saida_MemoriaDados(Saida_MemoriaDados)
  );
 
endmodule