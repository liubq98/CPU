`timescale 1ns / 1ps

module main(
     input clk, 
     input Reset,
     output [31:0] instruction,  
     output [5:0] opCode,
     output [31:0] Out1, 
     output [31:0] Out2, 
     output [31:0] curPC, 
     output [31:0] Result,
     output [31:0] next,
     output reg [31:0] PC_out
     );  
     
     wire [2:0] ALUOp;
     wire [31:0] ExtOut, DMOut;  
     wire [15:0] immediate;  
     wire [4:0] rs, rt, rd, sa; 
     wire [25:0] addr;
     wire [1:0] PCSrc; 
     wire zero, PCWre, ALUSrcA, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, RD, WR, ExtSel, RegOut;  
     
     initial begin
             PC_out = 32'h00000000;
     end
     
     PC pc(clk, Reset, PCWre, PC_out, curPC);  
       
     IMemory ins(curPC, InsMemRW, instruction);
     
     assign opCode = instruction[31:26];
     assign rs = instruction[25:21];
     assign rt = instruction[20:16];
     assign rd = instruction[15:11];
     assign sa = instruction[10:6];
     assign addr = instruction[25:0];
     assign immediate = instruction[15:0];
     
     controlUnit control(opCode, zero, PCWre, ALUSrcA, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, RD, WR, RegOut, ExtSel, PCSrc, ALUOp); 
     
     RegFile registerfile(clk, RegWre, RegOut, rs, rt, rd, DMOut, Out1, Out2);   
        
     signZeroExtend ext(immediate, ExtSel, ExtOut); 
     
     ALU alu(Out1, Out2, ExtOut, sa, ALUSrcA, ALUSrcB, ALUOp, zero, Result);  
     
     DataMemory datamemory(clk, Result, Out2, RD, WR, ALUM2Reg, DMOut);
     
     nextPC nextpc(clk, curPC, ExtOut, PCSrc, addr, next);
     always@(*) begin
         PC_out = next;
     end
endmodule