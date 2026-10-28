module sinegen (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    input  logic [7:0] incr, // incr determines how much the counter increases on each rising clock edge
    output logic [7:0] dout
);

logic [7:0] address;

counter addrCounter (
    .clk   (clk),
    .rst   (rst),
    .en    (en),
    .incr  (incr),
    .count (address)
);

rom sineROM (
    .clk  (clk),
    .addr (address),
    .dout (dout)
);

endmodule



