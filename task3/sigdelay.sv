module sigdelay (
    input  logic       clk,
    input  logic       rst,
    input  logic       wr,
    input  logic       rd,
    input  logic [8:0] offset, // offset is 9 bits instead of 8 as ram contains 512 memory locations
    input  logic [7:0] mic_signal,
    output logic [7:0] delayed_signal
);

logic [8:0] wr_addr;
logic [8:0] rd_addr;

assign rd_addr = wr_addr - offset;

counter #(
    .WIDTH(9) // In Task 2, our counter was 8 bits wide. Here we've overridden its default width
) addrCounter (
    .clk   (clk),
    .rst   (rst),
    .en    (1'b1),
    .incr  (9'd1),
    .count (wr_addr)
);

ram #(
    .ADDRESS_WIDTH(9),
    .DATA_WIDTH(8)
) audioRAM (
    .clk     (clk),
    .wr_en   (wr),
    .rd_en   (rd),
    .wr_addr (wr_addr), // selects where to store the incoming sample
    .rd_addr (rd_addr), //selects which previous sample to retrieve
    .din     (mic_signal), // sends the microphone sample into RAM
    .dout    (delayed_signal) // sends the retrieved sample to our output
);

endmodule
