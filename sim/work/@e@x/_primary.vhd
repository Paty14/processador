library verilog;
use verilog.vl_types.all;
entity EX is
    port(
        clock           : in     vl_logic;
        controleMuxExtensor: in     vl_logic;
        ULA_OP          : in     vl_logic_vector(4 downto 0);
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        constanteExtendida: in     vl_logic_vector(31 downto 0);
        Saida_ULA       : out    vl_logic_vector(31 downto 0);
        PC              : in     vl_logic_vector(31 downto 0);
        controleMuxPC   : in     vl_logic;
        atualizaFlag    : in     vl_logic_vector(4 downto 0);
        condicaoJump    : in     vl_logic_vector(2 downto 0);
        Jump_True_False : in     vl_logic;
        hab_jump        : out    vl_logic;
        Saida_MemoriaDados: out    vl_logic_vector(31 downto 0);
        Hab_EscritaMemoria: in     vl_logic
    );
end EX;
