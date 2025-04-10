/*
    This file was generated automatically by Alchitry Labs 2.0.30-BETA.
    Do not edit this file directly. Instead edit the original Lucid source.
    This is a temporary file and any changes made to it will be destroyed.
*/

module beta_cpu (
        input wire clk,
        input wire slowclk,
        input wire rst,
        input wire irq,
        input wire [31:0] instruction,
        input wire [31:0] mem_data_input,
        output reg [31:0] ia,
        output reg [31:0] mem_data_address,
        output reg [31:0] mem_data_output,
        output reg wr,
        output reg [3:0][15:0] debug
    );
    logic M_control_system_irq;
    logic M_control_system_z;
    logic [5:0] M_control_system_opcode;
    logic M_control_system_slowclk;
    logic M_control_system_ia31;
    logic [2:0] M_control_system_pcsel;
    logic M_control_system_wasel;
    logic M_control_system_asel;
    logic M_control_system_ra2sel;
    logic M_control_system_bsel;
    logic [5:0] M_control_system_alufn;
    logic [1:0] M_control_system_wdsel;
    logic M_control_system_werf;
    logic M_control_system_wr;
    
    control_unit control_system (
        .clk(clk),
        .rst(rst),
        .irq(M_control_system_irq),
        .z(M_control_system_z),
        .opcode(M_control_system_opcode),
        .slowclk(M_control_system_slowclk),
        .ia31(M_control_system_ia31),
        .pcsel(M_control_system_pcsel),
        .wasel(M_control_system_wasel),
        .asel(M_control_system_asel),
        .ra2sel(M_control_system_ra2sel),
        .bsel(M_control_system_bsel),
        .alufn(M_control_system_alufn),
        .wdsel(M_control_system_wdsel),
        .werf(M_control_system_werf),
        .wr(M_control_system_wr)
    );
    
    
    localparam _MP_SIZE_1662312314 = 6'h20;
    logic [31:0] M_alu_system_a;
    logic [31:0] M_alu_system_b;
    logic [5:0] M_alu_system_alufn;
    logic [31:0] M_alu_system_out;
    logic M_alu_system_z;
    logic M_alu_system_v;
    logic M_alu_system_n;
    logic M_alu_system_illop;
    
    alu #(
        .SIZE(_MP_SIZE_1662312314)
    ) alu_system (
        .clk(clk),
        .rst(rst),
        .a(M_alu_system_a),
        .b(M_alu_system_b),
        .alufn(M_alu_system_alufn),
        .out(M_alu_system_out),
        .z(M_alu_system_z),
        .v(M_alu_system_v),
        .n(M_alu_system_n),
        .illop(M_alu_system_illop)
    );
    
    
    logic [4:0] M_regfile_system_ra;
    logic [4:0] M_regfile_system_rb;
    logic [4:0] M_regfile_system_rc;
    logic M_regfile_system_wasel;
    logic M_regfile_system_ra2sel;
    logic M_regfile_system_werf;
    logic [31:0] M_regfile_system_wdsel_out;
    logic M_regfile_system_slowclk;
    logic M_regfile_system_z;
    logic [31:0] M_regfile_system_rd1;
    logic [31:0] M_regfile_system_rd2;
    logic [31:0] M_regfile_system_mwd;
    
    regfile_unit regfile_system (
        .clk(clk),
        .rst(rst),
        .ra(M_regfile_system_ra),
        .rb(M_regfile_system_rb),
        .rc(M_regfile_system_rc),
        .wasel(M_regfile_system_wasel),
        .ra2sel(M_regfile_system_ra2sel),
        .werf(M_regfile_system_werf),
        .wdsel_out(M_regfile_system_wdsel_out),
        .slowclk(M_regfile_system_slowclk),
        .z(M_regfile_system_z),
        .rd1(M_regfile_system_rd1),
        .rd2(M_regfile_system_rd2),
        .mwd(M_regfile_system_mwd)
    );
    
    
    logic M_pc_system_slowclk;
    logic [15:0] M_pc_system_id;
    logic [2:0] M_pc_system_pcsel;
    logic [31:0] M_pc_system_reg_data_1;
    logic [31:0] M_pc_system_pc_4;
    logic [31:0] M_pc_system_pc_4_sxtc;
    logic [31:0] M_pc_system_pcsel_out;
    logic [31:0] M_pc_system_ia;
    
    pc_unit pc_system (
        .clk(clk),
        .rst(rst),
        .slowclk(M_pc_system_slowclk),
        .id(M_pc_system_id),
        .pcsel(M_pc_system_pcsel),
        .reg_data_1(M_pc_system_reg_data_1),
        .pc_4(M_pc_system_pc_4),
        .pc_4_sxtc(M_pc_system_pc_4_sxtc),
        .pcsel_out(M_pc_system_pcsel_out),
        .ia(M_pc_system_ia)
    );
    
    
    logic [31:0] asel_out;
    logic [31:0] bsel_out;
    logic [31:0] wdsel_out;
    always @* begin
        M_control_system_irq = irq;
        M_control_system_ia31 = M_pc_system_ia[5'h1f];
        M_control_system_opcode = instruction[5'h1f:5'h1a];
        M_control_system_z = M_regfile_system_z;
        M_control_system_slowclk = slowclk;
        M_pc_system_slowclk = slowclk;
        M_pc_system_reg_data_1 = M_regfile_system_rd1;
        M_pc_system_pcsel = M_control_system_pcsel;
        M_pc_system_id = instruction[4'hf:1'h0];
        M_regfile_system_slowclk = slowclk;
        M_regfile_system_ra2sel = M_control_system_ra2sel;
        M_regfile_system_wasel = M_control_system_wasel;
        M_regfile_system_werf = M_control_system_werf;
        M_regfile_system_ra = instruction[5'h14:5'h10];
        M_regfile_system_rb = instruction[4'hf:4'hb];
        M_regfile_system_rc = instruction[5'h19:5'h15];
        M_alu_system_alufn = M_control_system_alufn;
        
        case (M_control_system_asel)
            1'h0: begin
                asel_out = M_regfile_system_rd1;
            end
            1'h1: begin
                asel_out = {1'h0, M_pc_system_pc_4_sxtc[5'h1e:1'h0]};
            end
            default: begin
                asel_out = M_regfile_system_rd1;
            end
        endcase
        
        case (M_control_system_bsel)
            1'h0: begin
                bsel_out = M_regfile_system_rd2;
            end
            1'h1: begin
                bsel_out = {{5'h10{instruction[4'hf]}}, instruction[4'hf:1'h0]};
            end
            default: begin
                bsel_out = M_regfile_system_rd2;
            end
        endcase
        
        case (M_control_system_wdsel)
            2'h0: begin
                wdsel_out = M_pc_system_pc_4;
            end
            2'h1: begin
                wdsel_out = M_alu_system_out;
            end
            2'h2: begin
                wdsel_out = mem_data_input;
            end
            default: begin
                wdsel_out = M_alu_system_out;
            end
        endcase
        M_alu_system_a = asel_out;
        M_alu_system_b = bsel_out;
        M_regfile_system_wdsel_out = wdsel_out;
        ia = M_pc_system_ia;
        mem_data_address = M_alu_system_out;
        mem_data_output = M_regfile_system_mwd;
        wr = M_control_system_wr;
        debug[1'h0][4'hf:1'h0] = M_pc_system_pcsel_out[4'hf:1'h0];
        debug[1'h1][4'hf:1'h0] = asel_out[4'hf:1'h0];
        debug[2'h2][4'hf:1'h0] = bsel_out[4'hf:1'h0];
        debug[2'h3][4'hf:1'h0] = wdsel_out[4'hf:1'h0];
    end
    
    
endmodule