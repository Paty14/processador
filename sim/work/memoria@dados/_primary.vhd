library verilog;
use verilog.vl_types.all;
entity memoriaDados is
    generic(
        dim             : integer := 1024
    );
    port(
        read_file       : in     vl_logic;
        write_file      : in     vl_logic;
        WE              : in     vl_logic;
        CLK             : in     vl_logic;
        ADDRESS         : in     vl_logic_vector(31 downto 0);
        DATA            : in     vl_logic_vector(31 downto 0);
        Q               : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of dim : constant is 1;
end memoriaDados;
