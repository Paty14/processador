library verilog;
use verilog.vl_types.all;
entity MuxResul is
    port(
        ULA             : in     vl_logic_vector(31 downto 0);
        MD              : in     vl_logic_vector(31 downto 0);
        PC              : in     vl_logic_vector(31 downto 0);
        saida           : out    vl_logic_vector(31 downto 0);
        controle        : in     vl_logic_vector(1 downto 0)
    );
end MuxResul;
