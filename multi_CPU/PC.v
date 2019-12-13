`timescale 1ns / 1ps

module PC(
    input clk, PCWre, RST,
    input [31:0] i_pc,
    output reg [31:0] o_pc
    );
    always @(posedge clk) begin //��pcWre�ı��ʱ�����RST�ı��ʱ���ټ��
        if(RST) o_pc <= 0;
        else if(PCWre) o_pc <= i_pc;
    end
endmodule