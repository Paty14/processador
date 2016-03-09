library verilog;
use verilog.vl_types.all;
entity ULA is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        OP              : in     vl_logic_vector(4 downto 0);
        RESULT          : out    vl_logic_vector(31 downto 0);
        O               : out    vl_logic;
        C               : out    vl_logic;
        S               : out    vl_logic;
        Z               : out    vl_logic
    );
end ULA;
