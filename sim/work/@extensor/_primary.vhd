library verilog;
use verilog.vl_types.all;
entity Extensor is
    port(
        Controle        : in     vl_logic;
        ConstanteIn     : in     vl_logic_vector(15 downto 0);
        ConstanteOut    : out    vl_logic_vector(31 downto 0)
    );
end Extensor;
