library verilog;
use verilog.vl_types.all;
entity UnidadeControle is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        instrucao       : in     vl_logic_vector(31 downto 0);
        controlePC      : out    vl_logic;
        ren             : out    vl_logic;
        cen             : out    vl_logic;
        BR_Sel_C_A      : out    vl_logic_vector(3 downto 0);
        BR_Sel_B        : out    vl_logic_vector(3 downto 0);
        Hab_Escrita_Banco: out    vl_logic;
        Hab_Escrita_Memoria: out    vl_logic;
        constante       : out    vl_logic_vector(15 downto 0);
        EXcontrole      : out    vl_logic;
        ULA_OP          : out    vl_logic_vector(4 downto 0);
        hab_jump        : out    vl_logic;
        atualizaFlag    : out    vl_logic_vector(4 downto 0);
        condicaoJump    : out    vl_logic_vector(2 downto 0);
        controle_MuxPC  : out    vl_logic;
        Controle_Mux1   : out    vl_logic;
        Controle_Mux2   : out    vl_logic_vector(1 downto 0)
    );
end UnidadeControle;
