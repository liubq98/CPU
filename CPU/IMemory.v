`timescale 1ns / 1ps

module IMemory(  
    input [31:0] PC,
    input InsMemRW,
    output [31:0] instruction
    );
    reg [7:0] InsMEM [127:0];
    
    initial begin
        $readmemb("F:/vivado/data/test.coe", InsMEM, 0, 127);
    end
     assign instruction = { InsMEM[PC], InsMEM[PC + 1], InsMEM[PC + 2], InsMEM[PC+ 3] };
  
endmodule