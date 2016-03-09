library verilog;
use verilog.vl_types.all;
entity MUX_ULA is
    port(
        BR              : in     vl_logic_vector(31 downto 0);
        EX              : in     vl_logic_vector(31 downto 0);
        saida           : out    vl_logic_vector(31 downto 0);
        controle        : in     vl_logic
    );
end MUX_ULA;
