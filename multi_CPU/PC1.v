`timescale 1ns / 1ps

module PC1(
    input [31:0] PC4,
    input [31:0] immediate,
    output reg [31:0] o_pc
    );
    always @(immediate or PC4) o_pc = PC4 + immediate * 4;
endmodule