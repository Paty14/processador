library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        sinal_controle  : in     vl_logic;
        clock           : in     vl_logic;
        sinal_jump      : in     vl_logic;
        pc_out          : out    vl_logic_vector(31 downto 0);
        pc_jump         : in     vl_logic_vector(31 downto 0)
    );
end PC;
