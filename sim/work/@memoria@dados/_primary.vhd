library verilog;
use verilog.vl_types.all;
entity MemoriaDados is
    port(
        Hab_Escrita     : in     vl_logic;
        endereco        : in     vl_logic_vector(31 downto 0);
        entrada         : in     vl_logic_vector(31 downto 0);
        saida           : out    vl_logic_vector(31 downto 0);
        reset           : in     vl_logic;
        clock           : in     vl_logic
    );
end MemoriaDados;
