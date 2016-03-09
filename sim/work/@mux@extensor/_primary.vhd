library verilog;
use verilog.vl_types.all;
entity MuxExtensor is
    port(
        BR              : in     vl_logic_vector(31 downto 0);
        EX              : in     vl_logic_vector(31 downto 0);
        saida           : out    vl_logic_vector(31 downto 0);
        controle        : in     vl_logic
    );
end MuxExtensor;
