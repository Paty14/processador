library verilog;
use verilog.vl_types.all;
entity ram is
    generic(
        dim             : integer := 1024
    );
    port(
        Reset           : in     vl_logic;
        WE              : in     vl_logic;
        CLK             : in     vl_logic;
        ADDRESS         : in     vl_logic_vector(31 downto 0);
        Q               : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of dim : constant is 1;
end ram;
