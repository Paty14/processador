library verilog;
use verilog.vl_types.all;
entity MuxPC is
    port(
        BR              : in     vl_logic_vector(31 downto 0);
        PC              : in     vl_logic_vector(31 downto 0);
        saida           : out    vl_logic_vector(31 downto 0);
        controle        : in     vl_logic
    );
end MuxPC;
