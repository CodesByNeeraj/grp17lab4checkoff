/*
    This file was generated automatically by Alchitry Labs 2.0.30-BETA.
    Do not edit this file directly. Instead edit the original Lucid source.
    This is a temporary file and any changes made to it will be destroyed.
*/

module multiplier (
        input wire [31:0] a,
        input wire [31:0] b,
        output reg [31:0] mul
    );
    logic [31:0] R_3a26c69e_i;
    logic [31:0] RR_3a26c69e_i;
    logic [31:0] R_5e3767d0_i;
    logic [31:0] RR_5e3767d0_i;
    logic [31:0] R_2daabbb4_j;
    logic [31:0] RR_2daabbb4_j;
    logic [495:0] M_fa_a;
    logic [495:0] M_fa_b;
    logic [495:0] M_fa_cin;
    logic [495:0] M_fa_s;
    logic [495:0] M_fa_cout;
    
    genvar idx_0_343896073;
    
    generate
        for (idx_0_343896073 = 0; idx_0_343896073 < 496; idx_0_343896073 = idx_0_343896073 + 1) begin: forLoop_idx_0_343896073
            fa fa (
                .a(M_fa_a[idx_0_343896073]),
                .b(M_fa_b[idx_0_343896073]),
                .cin(M_fa_cin[idx_0_343896073]),
                .s(M_fa_s[idx_0_343896073]),
                .cout(M_fa_cout[idx_0_343896073])
            );
        end
    endgenerate
    
    
    logic [8:0] current_row_fa_index;
    logic [8:0] previous_row_fa_index;
    always @* begin
        mul[1'h0] = b[1'h0] & a[1'h0];
        for (RR_3a26c69e_i = 0; RR_3a26c69e_i < 5'h1f; RR_3a26c69e_i = RR_3a26c69e_i + 1) begin
      R_3a26c69e_i = (0) + RR_3a26c69e_i * (1);
            M_fa_a[R_3a26c69e_i] = a[R_3a26c69e_i] & b[1'h1];
            M_fa_b[R_3a26c69e_i] = a[R_3a26c69e_i + 1'h1] & b[1'h0];
            if (R_3a26c69e_i == 1'h0) begin
                M_fa_cin[R_3a26c69e_i] = 1'h0;
            end else begin
                M_fa_cin[R_3a26c69e_i] = M_fa_cout[R_3a26c69e_i - 1'h1];
            end
        end
        previous_row_fa_index = 1'h0;
        current_row_fa_index = 5'h1f;
        mul[1'h1] = M_fa_s[previous_row_fa_index];
        for (RR_5e3767d0_i = 0; RR_5e3767d0_i < 5'h1d; RR_5e3767d0_i = RR_5e3767d0_i + 1) begin
      R_5e3767d0_i = (2'h2) + RR_5e3767d0_i * (1);
            for (RR_2daabbb4_j = 0; RR_2daabbb4_j < 6'h20 - R_5e3767d0_i; RR_2daabbb4_j = RR_2daabbb4_j + 1) begin
        R_2daabbb4_j = (0) + RR_2daabbb4_j * (1);
                M_fa_a[current_row_fa_index + R_2daabbb4_j] = a[R_2daabbb4_j] & b[R_5e3767d0_i];
                M_fa_b[current_row_fa_index + R_2daabbb4_j] = M_fa_s[previous_row_fa_index + 1'h1 + R_2daabbb4_j];
                if (R_2daabbb4_j == 1'h0) begin
                    M_fa_cin[current_row_fa_index + R_2daabbb4_j] = 1'h0;
                end else begin
                    M_fa_cin[current_row_fa_index + R_2daabbb4_j] = M_fa_cout[current_row_fa_index + R_2daabbb4_j - 1'h1];
                end
            end
            previous_row_fa_index = current_row_fa_index;
            current_row_fa_index = current_row_fa_index + 6'h20 - R_5e3767d0_i;
            mul[R_5e3767d0_i] = M_fa_s[previous_row_fa_index];
        end
        M_fa_a[9'h1ef] = a[1'h0] & b[5'h1f];
        M_fa_b[9'h1ef] = M_fa_s[9'h1ee];
        M_fa_cin[9'h1ef] = 1'h0;
        mul[5'h1f] = M_fa_s[9'h1ef];
    end
    
    
endmodule