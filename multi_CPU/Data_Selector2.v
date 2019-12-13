`timescale 1ns / 1ps

module Data_Selector2(
    input [31:0] A, B,
    input Sign,
    output reg [31:0] Y
    );
    always@(A or B or Sign) begin
        Y = Sign ? B : A; //选择信号为1则选A（前面的参数）
    end
endmodule
