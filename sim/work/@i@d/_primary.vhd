library verilog;
use verilog.vl_types.all;
entity ID is
    port(
        clock           : in     vl_logic;
        BR_HabEscrita   : in     vl_logic;
        EXcontrole      : in     vl_logic;
        Sel_C_A         : in     vl_logic_vector(3 downto 0);
        Sel_B           : in     vl_logic_vector(3 downto 0);
        constante       : in     vl_logic_vector(15 downto 0);
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        constanteExtendida: in     vl_logic_vector(31 downto 0);
        muxResultado    : in     vl_logic_vector(31 downto 0);
        controle        : in     vl_logic_vector(1 downto 0);
        ULA             : in     vl_logic_vector(31 downto 0);
        MD              : in     vl_logic_vector(31 downto 0);
        PC              : in     vl_logic_vector(31 downto 0)
    );
end ID;
