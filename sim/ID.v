include "BancoRegistradores.v";
include "Extensor.v";
include "MuxResul.v";


module ID(clock, BR_HabEscrita, EXcontrole, Sel_C_A, Sel_B, constante, A, B, constanteExtendida, muxResultado, controle, ULA, MD, PC);
  input clock;
  input wire BR_HabEscrita, EXcontrole;
  input wire [3:0] Sel_C_A, Sel_B;
  input wire [15:0] constante;
  input wire [31:0] muxResultado;
  input wire [31:0] A, B, constanteExtendida;
  input [31:0] ULA, MD, PC;
  input wire [1:0] controle; 
 
    
  BancoRegistradores BancoRegistradores(
  .Hab_Escrita(BR_HabEscrita), 
  .Sel_C_A(Sel_C_A), 
  .Sel_B(Sel_B), 
  .clock(clock), 
  .A(A), 
  .B(B),
  .WC(muxResultado)
  );


  Extensor Extensor(
  .Controle(EXcontrole), 
  .ConstanteIn(constante), 
  .ConstanteOut(constanteExtendida)
  );	  
 
   

  MuxResul MuxResul(
  .ULA(ULA), 
  .MD(MD), 
  .PC(PC), 
  .saida(muxResultado),
  .controle(controle)
  ); 
  
endmodule 