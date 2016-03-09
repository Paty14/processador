library verilog;
use verilog.vl_types.all;
entity BancoRegistradores is
    port(
        Hab_Escrita     : in     vl_logic;
        Sel_C_A         : in     vl_logic_vector(3 downto 0);
        Sel_B           : in     vl_logic_vector(3 downto 0);
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        A               : out    vl_logic_vector(31 downto 0);
        B               : out    vl_logic_vector(31 downto 0);
        WC              : in     vl_logic_vector(31 downto 0)
    );
end BancoRegistradores;
