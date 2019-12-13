`timescale 1ns / 1ps

module InsMem(
    input [31:0] PC,
    input InsMemRW,
    output [31:0] instruction
    );
    reg [7:0] InsMEM [127:0];
    
    initial begin
        $readmemb("F:/vivado/data/multiData.txt", InsMEM);
    end
	assign instruction = { InsMEM[PC], InsMEM[PC + 1], InsMEM[PC + 2], InsMEM[PC+ 3] };
	
endmodule