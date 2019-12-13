`timescale 1ns / 1ps

module CPU_sim();
    reg clk;
    reg Reset;
    wire [31:0] instruction;
    wire [5:0] opCode;
    wire [31:0] Out1; 
    wire [31:0] Out2; 
    wire [31:0] curPC; 
    wire [31:0] Result;
    wire [31:0] next;
    wire [31:0] PC_out;
    
    main uut(
        .clk(clk), 
        .Reset(Reset), 
        .instruction(instruction),
        .opCode(opCode),  
        .Out1(Out1),
        .Out2(Out2),
        .curPC(curPC),
        .Result(Result),
        .next(next),
        .PC_out(PC_out)
        );
    
     
     initial begin
             Reset = 0;
             clk = 0;
             #10;
             clk = ~clk;
             #10;
             Reset = 1;
             forever #10 clk = ~clk;
     end
endmodule