`timescale 1ns / 1ps

module Data_Selector2(
    input [31:0] A, B,
    input Sign,
    output reg [31:0] Y
    );
    always@(A or B or Sign) begin
        Y = Sign ? B : A; //ѡ���ź�Ϊ1��ѡA��ǰ��Ĳ�����
    end
endmodule
