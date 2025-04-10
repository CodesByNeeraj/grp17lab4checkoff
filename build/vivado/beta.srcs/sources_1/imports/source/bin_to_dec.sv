/*
    This file was generated automatically by Alchitry Labs 2.0.30-BETA.
    Do not edit this file directly. Instead edit the original Lucid source.
    This is a temporary file and any changes made to it will be destroyed.
*/

module bin_to_dec #(
        parameter DIGITS = 3'h4,
        parameter LEADING_ZEROS = 1'h0
    ) (
        input wire [($clog2((64'(4'ha) ** (DIGITS))))-1:0] value,
        output reg [(DIGITS)-1:0][3:0] digits
    );
    logic [31:0] R_37720638_j;
    logic [31:0] RR_37720638_j;
    logic [31:0] R_0cca7b2d_i;
    logic [31:0] RR_0cca7b2d_i;
    logic [($bits(value))-1:0] L_72b19528_remainder;
    logic L_72b19528_blank;
    logic [($bits(value))-1:0] L_28bc3934_scale;
    logic [($bits(value))-1:0] L_1e2ce276_sub_value;
    always @* begin
        digits = {DIGITS{{{4'hb}}}};
        L_72b19528_remainder = value;
        L_72b19528_blank = !LEADING_ZEROS;
        if (value < (64'(4'ha) ** (DIGITS))) begin
            for (RR_37720638_j = 0; RR_37720638_j < DIGITS; RR_37720638_j = RR_37720638_j + 1) begin
        R_37720638_j = (DIGITS - 1'h1) + RR_37720638_j * (-2'sh1);
                L_28bc3934_scale = (64'(4'ha) ** (R_37720638_j));
                if (L_72b19528_remainder < L_28bc3934_scale) begin
                    if (R_37720638_j != 1'h0 && L_72b19528_blank) begin
                        digits[R_37720638_j] = 4'ha;
                    end else begin
                        digits[R_37720638_j] = 1'h0;
                    end
                end else begin
                    L_72b19528_blank = 1'h0;
                    L_1e2ce276_sub_value = 1'h0;
                    for (RR_0cca7b2d_i = 0; RR_0cca7b2d_i < 4'h9; RR_0cca7b2d_i = RR_0cca7b2d_i + 1) begin
            R_0cca7b2d_i = (4'h9) + RR_0cca7b2d_i * (-2'sh1);
                        if (L_72b19528_remainder < (R_0cca7b2d_i + 1'h1) * L_28bc3934_scale) begin
                            digits[R_37720638_j] = R_0cca7b2d_i;
                            L_1e2ce276_sub_value = R_0cca7b2d_i * L_28bc3934_scale;
                        end
                    end
                    L_72b19528_remainder = L_72b19528_remainder - L_1e2ce276_sub_value;
                end
            end
        end
    end
    
    
endmodule