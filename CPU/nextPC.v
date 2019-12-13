`timescale 1ns / 1ps

module nextPC(
    input clk,
    input [31:0] PC,
    input [31:0] immediate,
    input [1:0] PCSrc,
    input [25:0] DataOut,
    output reg [31:0] next
    );
    
    reg [31:0] PC2;
   always @(posedge clk) begin
      if (PCSrc[1:0] == 2'b01) begin
          next = PC + 4 + immediate*4;  
      end
      else if(PCSrc[1:0] == 2'b00) begin
          next = PC + 4;
      end
      else if(PCSrc[1:0] == 2'b10) begin
          PC2 = PC + 4;
          next[31:0] = {PC2[31:28], DataOut[25:0], 2'b00};
      end
      else begin
           next = PC;
      end
   end
endmodule
