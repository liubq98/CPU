`timescale 1ns / 1ps

module RegFile(
    input clock, RegWre,
    input [4:0] rs, rt, rd, //��������һ��������������ľʹ�ָ���е�std������ѡ���Ľ��
    input [31:0] write_data,
    output reg [31:0] readData1,
    output reg [31:0] readData2
    );
	reg [31:0] register [0:31];
    initial begin
        register[0] = 0;
    end
    
    always @(rs or rt) begin
	   readData1 = register[rs];
	   readData2 = register[rt];
    end

	always @(negedge clock) begin
		if (rd != 0 && RegWre == 1) begin//0�żĴ�����ֵʼ��Ϊ0���Ҳ�����ı�
            register[rd] <= write_data;
        end
        else begin
        end
    end

endmodule