// -----------------------------------------------------------------------------
// AUTHOR        
// Matheus Borges
// -----------------------------------------------------------------------------

module memoriaDados(read_file, write_file, WE, CLK, ADDRESS, DATA, Q);

  input wire read_file, write_file, WE, CLK;
  input wire[31:0] ADDRESS;       // Endereço
  input wire[31:0] DATA;          // Entrada
  output wire[31:0] Q;            // Saída

  parameter dim = 1024;
  reg[31:0] ram_mem[0:dim-1];

  integer i;
  initial begin
    for(i = 0; i < dim; i = i + 1)
      ram_mem[i] = {32{1'b0}};

    $readmemh("ram.in", ram_mem);
  end 

  assign Q = ram_mem[ADDRESS];

  always @(posedge CLK)                 //escreve em nível alto
    if (WE == 1'b1)
      ram_mem[ADDRESS] <= DATA;

  always @(read_file)
    if(read_file == 1'b1)
      $readmemh("ram.in", ram_mem);

  always @(write_file)
    if(write_file == 1'b1)
      $writememh("data.out", ram_mem);
endmodule
