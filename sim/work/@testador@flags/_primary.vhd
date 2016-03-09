library verilog;
use verilog.vl_types.all;
entity TestadorFlags is
    port(
        mux             : out    vl_logic;
        opcode          : in     vl_logic;
        condicao        : in     vl_logic_vector(2 downto 0);
        flags           : in     vl_logic_vector(3 downto 0)
    );
end TestadorFlags;
