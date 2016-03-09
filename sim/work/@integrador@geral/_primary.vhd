library verilog;
use verilog.vl_types.all;
entity IntegradorGeral is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic
    );
end IntegradorGeral;
