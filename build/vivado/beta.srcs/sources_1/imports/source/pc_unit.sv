/*
    This file was generated automatically by Alchitry Labs 2.0.30-BETA.
    Do not edit this file directly. Instead edit the original Lucid source.
    This is a temporary file and any changes made to it will be destroyed.
*/

module pc_unit (
        input wire clk,
        input wire rst,
        input wire slowclk,
        input wire [15:0] id,
        input wire [2:0] pcsel,
        input wire [31:0] reg_data_1,
        output reg [31:0] pc_4,
        output reg [31:0] pc_4_sxtc,
        output reg [31:0] pcsel_out,
        output reg [31:0] ia
    );
    logic [31:0] D_pc_d, D_pc_q = 1'h0;
    logic [31:0] pcsel_out_sig;
    logic [31:0] pc_4sxtc32_sig;
    logic [31:0] pc_4sxtc_sig;
    logic [31:0] pc_4sig;
    logic [31:0] pc_4raw;
    always @* begin
        D_pc_d = D_pc_q;
        
        D_pc_d = D_pc_q;
        pcsel_out_sig = 1'h0;
        pc_4sxtc_sig = 1'h0;
        pc_4raw = D_pc_q + 3'h4;
        pc_4sig = {D_pc_q[5'h1f], pc_4raw[5'h1e:1'h0]};
        pc_4sxtc32_sig = D_pc_q + 3'h4 + {{4'he{id[4'hf]}}, id[4'hf:1'h0], 2'h0};
        pc_4sxtc_sig = {D_pc_q[5'h1f], pc_4sxtc32_sig[5'h1e:1'h0]};
        
        case (pcsel)
            3'h0: begin
                pcsel_out_sig = pc_4sig;
            end
            3'h1: begin
                pcsel_out_sig = pc_4sxtc_sig;
            end
            3'h2: begin
                pcsel_out_sig = {D_pc_q[5'h1f] & reg_data_1[5'h1f], reg_data_1[5'h1e:1'h0]};
            end
            3'h3: begin
                pcsel_out_sig = 32'h80000004;
            end
            3'h4: begin
                pcsel_out_sig = 32'h80000008;
            end
            default: begin
                pcsel_out_sig = D_pc_q;
            end
        endcase
        if (slowclk) begin
            D_pc_d = {pcsel_out_sig[5'h1f:2'h2], 2'h0};
        end
        if (rst) begin
            D_pc_d = 32'h80000000;
        end
        ia = D_pc_q;
        pc_4 = pc_4sig;
        pc_4_sxtc = pc_4sxtc_sig;
        pcsel_out = pcsel_out_sig;
    end
    
    
    always @(posedge (clk)) begin
        D_pc_q <= D_pc_d;
        
    end
endmodule