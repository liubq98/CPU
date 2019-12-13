`timescale 1ns / 1ps

module PC(
    input clk, PCWre, RST,
    input [31:0] i_pc,
    output reg [31:0] o_pc
    );
    always @(posedge clk) begin //当pcWre改变的时候或者RST改变的时候再检测
        if(RST) o_pc <= 0;
        else if(PCWre) o_pc <= i_pc;
    end
endmodule