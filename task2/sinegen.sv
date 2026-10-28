module sinegen (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    input  logic [7:0] offset,
    input  logic [7:0] incr, // incr determines how much the counter increases on each rising clock edge
    output logic [7:0] dout1,
    output logic [7:0] dout2
);

logic [7:0] address1;
logic [7:0] address2;

assign address2 = address1 + offset; // assign creates a continuous assignment. Whenever address1 or offset changes, the combinational circuit updates address2


counter addrCounter (
    .clk   (clk),
    .rst   (rst),
    .en    (en),
    .incr  (incr),
    .count (address1)
);

rom sineROM (
    .clk   (clk),
    .addr1 (address1),
    .addr2 (address2),
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule



