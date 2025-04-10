/*
    This file was generated automatically by Alchitry Labs 2.0.30-BETA.
    Do not edit this file directly. Instead edit the original Lucid source.
    This is a temporary file and any changes made to it will be destroyed.
*/

module instruction_rom #(
        parameter WORDS = 5'h10
    ) (
        input wire [($clog2(WORDS))-1:0] addr,
        output reg [31:0] out,
        output reg [9:0] numinstr
    );
    localparam logic [10:0][31:0] INSTRUCTIONS = {{32'h0, 32'hc0ff0001, 32'h800000a, 32'h314b0004, 32'h643f0000, 32'h607f0000, 32'hc0bf0064, 32'h31070008, 32'h90610800, 32'hc07f0005, 32'hc03f0005}};
    localparam NUM_OF_INSTRUCTIONS = 6'hb;
    always @* begin
        if (addr < 6'hb) begin
            out = INSTRUCTIONS[addr];
        end else begin
            out = 1'h0;
        end
        numinstr = 6'hb;
    end
    
    
endmodule