`timescale 1ns / 1ps

module nextPC(
    input [31:0] A, B, C, D,
    input [1:0] PCSrc,
    input clk,
    output reg [31:0] Y
    );
    always @(posedge clk) begin
        if(PCSrc == 2'b00) assign Y = A;
        else if(PCSrc == 2'b01) assign Y = B;
        else if(PCSrc == 2'b10) assign Y = C;
        else assign Y = D;
    end
endmodule
