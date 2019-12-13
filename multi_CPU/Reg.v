`timescale 1ns / 1ps

module Reg(
    input [31:0] i_data,  
    input clk, Sign,
    output reg [31:0] o_data
    );  
    always @(posedge clk) begin
        if(Sign) o_data <= i_data;
    end
endmodule