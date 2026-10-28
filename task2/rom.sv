module rom #(
    parameter ADDRESS_WIDTH = 8,
              DATA_WIDTH = 8
)(
    input  logic                     clk,
    input  logic [ADDRESS_WIDTH-1:0] addr1,
    input  logic [ADDRESS_WIDTH-1:0] addr2,
    output logic [DATA_WIDTH-1:0]    dout1,
    output logic [DATA_WIDTH-1:0]    dout2
);

logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0]; // Creates a ROM array with 2^ADDRESS_WIDTH memory locations, each storing DATA_WIDTH bits

initial begin
    $display("Loading rom.");
    $readmemh("sinerom.mem", rom_array); // $readmemh() reads hexadecimal values from sinerom.mem and loads them into the ROM when the simulation starts
end

always_ff @(posedge clk) begin
    // output is synchronous 
    dout1 <= rom_array[addr1]; // The ROM reads the value at address addr and updates dout only on the rising edge of clk
    dout2 <= rom_array[addr2];
end

endmodule
