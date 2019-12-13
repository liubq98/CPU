`timescale 1ns / 1ps

module PC4(
    input [31:0] i_pc,
    output reg [31:0] o_pc
    );
    always @(i_pc) o_pc = i_pc + 4;
endmodule