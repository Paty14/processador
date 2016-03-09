library verilog;
use verilog.vl_types.all;
entity \IF\ is
    port(
        clock           : in     vl_logic;
        instrucao       : out    vl_logic_vector(31 downto 0);
        controle_PC     : in     vl_logic;
        jumpPC          : in     vl_logic_vector(31 downto 0);
        habJump         : in     vl_logic;
        pc_out          : out    vl_logic_vector(31 downto 0);
        WE              : in     vl_logic;
        ren             : in     vl_logic
    );
end \IF\;
