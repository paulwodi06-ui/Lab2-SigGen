module ram #(
    parameter ADDRESS_WIDTH = 9,
              DATA_WIDTH = 8
)(
    input logic clk,
    input logic wr_en, // enables writing
    input logic rd_en, // enables reading 
    input logic [ADDRESS_WIDTH-1:0] wr_addr, // address to store a sample 
    input logic [ADDRESS_WIDTH-1:0] rd_addr, // address to retrieve a sample 
    input logic [DATA_WIDTH-1:0] din, // incoming microphone sample 
    output logic [DATA_WIDTH-1:0] dout // retrieved, delayed sample 
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) begin
    if (wr_en)
        ram_array[wr_addr] <= din; // When wr_en = 1, we store the value of din at the memory location specified by wr_addr

    if (rd_en)
        dout <= ram_array[rd_addr]; // When rd_en = 1, we read the value stored at rd_addr and update dout
end

endmodule
