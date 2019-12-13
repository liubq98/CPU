`timescale 1ns / 1ps

module PC( clk, reset, PCWre, nextPC, curPC);
    input clk, reset, PCWre;    // clkΪʱ���źţ�resetΪ�����źţ�PCWreΪPCʹ���ź�
    input [31:0] nextPC;        // nextPCΪ�¸�PCֵ
    output reg [31:0] curPC;   // ��ǰPCֵ

	// �����ش���
    always@(posedge clk) begin
        if( reset == 0)
            curPC <= 0;  // PC��ֵΪ0, ��0��ַ��ʼ
        else if (PCWre)
			curPC = nextPC;  // ����ָ��ĵ�ַ
    end
endmodule