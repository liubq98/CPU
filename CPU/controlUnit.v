`timescale 1ns / 1ps

module controlUnit(  
    input [5:0] opcode,  
    input zero,
    output reg PCWre,  
    output reg ALUSrcA,  
    output reg ALUSrcB,  
    output reg DBDataSrc,  
    output reg RegWre,  
    output reg InsMemRW,  
    output reg RD,  
    output reg WR,  
    output reg RegDst,  
    output reg ExtSel,  
    output reg [1:0] PCSrc,  
    output reg [2:0] ALUOp 
);  
    initial begin  
        RD = 1;  
        WR = 1;  
        RegWre = 0;  
        InsMemRW = 0;  
    end  
    always@ (opcode) begin  
        case(opcode)   
            6'b000000:begin // add  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 1;  
                ALUOp = 3'b000;  
            end  
            6'b000001:begin //addi  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 1;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 0;  
                ExtSel = 1;  
                ALUOp = 3'b000;  
            end  
            6'b000010:begin //sub  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 1;  
                ALUOp = 3'b001;  
            end  
            6'b010000:begin // ori  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 1;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 0;  
                ExtSel = 0;  
                ALUOp = 3'b011;  
            end  
            6'b010001:begin //and  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 1;  
                ALUOp = 3'b100;  
            end  
            6'b010010:begin // or  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 1;  
                ALUOp = 3'b011;  
            end  
            6'b011000:begin //sll  
                PCWre = 1;  
                ALUSrcA = 1;  
                ALUSrcB = 0;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 1;  
                ALUOp = 3'b010;  
            end  
            6'b011011:begin //slti  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 1;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 0;  
                ExtSel = 1;
                ALUOp = 3'b110;  
            end  
            6'b011100:begin //slt  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                DBDataSrc = 0;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                RegDst = 1;  
                ALUOp = 3'b110;  
            end  
            6'b100110:begin //sw  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 1;  
                RegWre = 0;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 0;  
                ExtSel =1;  
                ALUOp = 3'b000;  
            end  
            6'b100111:begin //lw  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 1;  
                DBDataSrc = 1;  
                RegWre = 1;  
                InsMemRW = 1;  
                RD = 0;  
                WR = 1;  
                RegDst = 0;  
                ExtSel = 1;  
                ALUOp = 3'b000;  
            end  
            6'b110000:begin //beq  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                RegWre = 0;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                ExtSel = 1;  
                ALUOp = 3'b001;  
            end  
            6'b110001:begin //bne  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                RegWre = 0;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                ExtSel = 1;  
                ALUOp = 3'b001;
            end  
            6'b110010:begin  
                PCWre = 1;  
                ALUSrcA = 0;  
                ALUSrcB = 0;  
                RegWre = 0;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                ExtSel = 1;  
                ALUOp = 3'b001;  
            end  
            6'b111000:begin //j  
                PCWre = 1;  
                RegWre = 0;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
                ALUOp = 3'b010;  
            end  
            6'b111111:begin //halt  
                PCWre = 1;  
                RegWre = 0;  
                InsMemRW = 1;  
                RD = 1;  
                WR = 1;  
            end  
            default:begin  
                RD = 1;  
                WR = 1;  
                RegWre = 0;  
                InsMemRW = 0;  
            end  
        endcase  
    end  
    always@(opcode or zero) begin  
        if(opcode == 6'b111000) // j  
            PCSrc = 2'b10;  
        else if(opcode[5:3] == 3'b110) begin  
            if(opcode[2:0] == 3'b000) begin  
                if(zero == 1)  
                    PCSrc = 2'b01;  
                else  
                    PCSrc = 2'b00;  
            end  
            else if(opcode[2:0] == 3'b001) begin  
                if(zero == 0)  
                    PCSrc = 2'b01;  
                else  
                    PCSrc = 2'b00;  
            end  
            else begin  
                if(zero == 0)  
                    PCSrc = 2'b01;  
                else  
                    PCSrc = 2'b00;  
            end  
        end  
        else begin  
            PCSrc = 2'b00;  
        end  
    end  
endmodule