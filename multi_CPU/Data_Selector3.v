`timescale 1ns / 1ps

module Data_Selector3(
    input [4:0] A, B, C,
    input [1:0] Sign,
    output reg [4:0] Y
    );
    always@(A or B or C or Sign) begin
        if(Sign == 2'b00) Y = A;
        else if(Sign == 2'b01) Y = B;
        else Y = C;    
    end
endmodule
