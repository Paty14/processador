library verilog;
use verilog.vl_types.all;
entity sp_rom is
    generic(
        ADDRESS_WIDTH   : integer := 32;
        DATA_WIDTH      : integer := 32
    );
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector;
        data            : out    vl_logic_vector;
        ren             : in     vl_logic;
        cen             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDRESS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end sp_rom;
