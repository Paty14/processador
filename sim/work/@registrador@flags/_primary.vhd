library verilog;
use verilog.vl_types.all;
entity RegistradorFlags is
    port(
        Z               : in     vl_logic;
        C               : in     vl_logic;
        S               : in     vl_logic;
        O               : in     vl_logic;
        controleOperacao: in     vl_logic_vector(4 downto 0);
        flags           : out    vl_logic_vector(3 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic
    );
end RegistradorFlags;
