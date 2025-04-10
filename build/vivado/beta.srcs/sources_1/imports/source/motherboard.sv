/*
    This file was generated automatically by Alchitry Labs 2.0.30-BETA.
    Do not edit this file directly. Instead edit the original Lucid source.
    This is a temporary file and any changes made to it will be destroyed.
*/

module motherboard (
        input wire clk,
        input wire rst,
        input wire [2:0] irq,
        input wire slowclk,
        output reg [31:0] id,
        output reg [31:0] ia,
        output reg [31:0] ma,
        output reg [31:0] mrd,
        output reg [31:0] mwd,
        output reg [31:0] output_buffer,
        output reg [31:0] input_buffer,
        output reg [3:0][15:0] debug
    );
    logic M_beta_slowclk;
    logic M_beta_rst;
    logic M_beta_irq;
    logic [31:0] M_beta_instruction;
    logic [31:0] M_beta_mem_data_input;
    logic [31:0] M_beta_ia;
    logic [31:0] M_beta_mem_data_address;
    logic [31:0] M_beta_mem_data_output;
    logic M_beta_wr;
    logic [3:0][15:0] M_beta_debug;
    
    beta_cpu beta (
        .clk(clk),
        .slowclk(M_beta_slowclk),
        .rst(M_beta_rst),
        .irq(M_beta_irq),
        .instruction(M_beta_instruction),
        .mem_data_input(M_beta_mem_data_input),
        .ia(M_beta_ia),
        .mem_data_address(M_beta_mem_data_address),
        .mem_data_output(M_beta_mem_data_output),
        .wr(M_beta_wr),
        .debug(M_beta_debug)
    );
    
    
    localparam MEMORY_SIZE = 6'h20;
    localparam _MP_WORDS_191515684 = 6'h20;
    logic [4:0] M_instruction_unit_addr;
    logic [31:0] M_instruction_unit_out;
    logic [9:0] M_instruction_unit_numinstr;
    
    instruction_rom #(
        .WORDS(_MP_WORDS_191515684)
    ) instruction_unit (
        .addr(M_instruction_unit_addr),
        .out(M_instruction_unit_out),
        .numinstr(M_instruction_unit_numinstr)
    );
    
    
    localparam _MP_WORDS_1236461689 = 6'h20;
    logic [6:0] M_memory_unit_raddr;
    logic [6:0] M_memory_unit_waddr;
    logic [31:0] M_memory_unit_wd;
    logic M_memory_unit_we;
    logic [31:0] M_memory_unit_mrd;
    logic [6:0] M_memory_unit_ia;
    logic M_memory_unit_instruction_we;
    logic [31:0] M_memory_unit_instruction_wd;
    logic [31:0] M_memory_unit_id;
    
    memory_unit #(
        .WORDS(_MP_WORDS_1236461689)
    ) memory_unit (
        .clk(clk),
        .raddr(M_memory_unit_raddr),
        .waddr(M_memory_unit_waddr),
        .wd(M_memory_unit_wd),
        .we(M_memory_unit_we),
        .mrd(M_memory_unit_mrd),
        .ia(M_memory_unit_ia),
        .instruction_we(M_memory_unit_instruction_we),
        .instruction_wd(M_memory_unit_instruction_wd),
        .id(M_memory_unit_id)
    );
    
    
    logic [31:0] D_system_output_buffer_d, D_system_output_buffer_q = 0;
    logic [31:0] D_system_input_buffer_d, D_system_input_buffer_q = 0;
    logic [4:0] D_writer_counter_d, D_writer_counter_q = 0;
    localparam E_MotherboardStates_INSTRUCTIONLOAD = 3'h0;
    localparam E_MotherboardStates_RUN = 3'h1;
    localparam E_MotherboardStates_LOAD_OUTPUT = 3'h2;
    localparam E_MotherboardStates_DISPLAY_OUTPUT = 3'h3;
    localparam E_MotherboardStates_UPDATE_INPUT = 3'h4;
    logic [2:0] D_motherboard_d, D_motherboard_q = 3'h0;
    always @* begin
        D_system_input_buffer_d = D_system_input_buffer_q;
        D_writer_counter_d = D_writer_counter_q;
        D_motherboard_d = D_motherboard_q;
        D_system_output_buffer_d = D_system_output_buffer_q;
        
        M_instruction_unit_addr = 1'h0;
        M_beta_irq = (|irq);
        if ((|irq)) begin
            if (irq[1'h0]) begin
                D_system_input_buffer_d = 32'hb0;
            end else begin
                if (irq[1'h1]) begin
                    D_system_input_buffer_d = 32'hb1;
                end else begin
                    if (irq[2'h2]) begin
                        D_system_input_buffer_d = 32'hb2;
                    end
                end
            end
        end
        M_beta_slowclk = slowclk;
        M_beta_rst = rst;
        M_beta_instruction = M_memory_unit_id;
        M_beta_mem_data_input = M_memory_unit_mrd;
        M_memory_unit_ia = M_beta_ia[5'h1f:1'h0];
        M_memory_unit_wd = M_beta_mem_data_output;
        M_memory_unit_we = M_beta_wr;
        M_memory_unit_waddr = M_beta_mem_data_address[5'h1f:1'h0];
        M_memory_unit_raddr = M_beta_mem_data_address[5'h1f:1'h0];
        M_memory_unit_instruction_we = 1'h0;
        M_memory_unit_instruction_wd = 32'h0;
        
        case (D_motherboard_q)
            3'h0: begin
                M_beta_rst = 1'h1;
                D_writer_counter_d = D_writer_counter_q + 1'h1;
                M_instruction_unit_addr = D_writer_counter_q;
                M_memory_unit_instruction_wd = M_instruction_unit_out;
                M_memory_unit_instruction_we = 1'h1;
                M_memory_unit_ia = D_writer_counter_q << 2'h2;
                if ((D_writer_counter_q + 1'h1) == 6'h20) begin
                    D_motherboard_d = 3'h1;
                end
            end
            3'h1: begin
                if (slowclk) begin
                    D_motherboard_d = 3'h2;
                end else begin
                    D_motherboard_d = 3'h1;
                end
            end
            3'h2: begin
                M_memory_unit_raddr = 32'hc;
                D_motherboard_d = 3'h3;
            end
            3'h3: begin
                D_system_output_buffer_d = M_memory_unit_mrd;
                D_motherboard_d = 3'h4;
            end
            3'h4: begin
                M_memory_unit_waddr = 32'h10;
                M_memory_unit_wd = D_system_input_buffer_q;
                M_memory_unit_we = 1'h1;
                D_motherboard_d = 3'h1;
            end
        endcase
        output_buffer = D_system_output_buffer_q;
        input_buffer = D_system_input_buffer_q;
        ia = M_beta_ia;
        id = M_memory_unit_id;
        ma = M_beta_mem_data_address;
        mrd = M_memory_unit_mrd;
        mwd = M_beta_mem_data_output;
        debug = M_beta_debug;
    end
    
    
    always @(posedge (clk)) begin
        if ((rst) == 1'b1) begin
            D_system_output_buffer_q <= 0;
            D_system_input_buffer_q <= 0;
            D_motherboard_q <= 3'h0;
        end else begin
            D_system_output_buffer_q <= D_system_output_buffer_d;
            D_system_input_buffer_q <= D_system_input_buffer_d;
            D_motherboard_q <= D_motherboard_d;
        end
    end
    always @(posedge (clk)) begin
        D_writer_counter_q <= D_writer_counter_d;
        
    end
endmodule