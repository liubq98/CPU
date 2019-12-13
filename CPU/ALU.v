`timescale 1ns / 1ps

module ALU(
    input [31:0] ReadData1,
    input [31:0]  ReadData2,
    input [31:0]  inExt,
    input [4:0] sa, 
     input ALUSrcA, 
     input ALUSrcB, 
     input [2:0] ALUOp,  
     output reg zero,
     output reg [31:0] result
     );
     
     wire [31:0] B;
     wire [31:0] A;
     wire [31:0] saa;
     assign saa[31:5] = {27'b000000000000000000000000000, sa[4:0]};
     assign A = ALUSrcA? saa : ReadData1;  
     assign B = ALUSrcB? inExt : ReadData2;  
       
     always @(ALUOp or sa)  
         begin  
              case(ALUOp)  
                    // A + B  
                     3'b000: begin  
                         result = A + B;  
                          zero = (result == 0)? 1 : 0;  
                     end  
                     // A - B  
                     3'b001: begin  
                         result = A - B;  
                          zero = (result == 0)? 1 : 0;  
                     end  
                     // B << A  
                     3'b010: begin  
                         result = B << sa;  
                          zero = (result == 0)? 1 : 0;  
                     end  
                     // A ¡Å B  
                     3'b011: begin  
                         result = A | B;  
                          zero = (result == 0)? 1 : 0;  
                     end  
                     // A ¡Ä B  
                     3'b100: begin  
                         result = A & B;  
                          zero = (result == 0)? 1 : 0;  
                     end  
                     //  
                     3'b101: begin  
                         result = (A == B) ? 1 : 0; 
                          zero = (result == 0)? 1 : 0;  
                     end  
                     // A ? B  
                     3'b110: begin // ´ø·ûºÅ±È½Ï  
                         if (A<B &&(( A[31] == 0 && B[31]==0) ||  
                         (A[31] == 1 && B[31]==1))) result = 1;  
                         else if (A[31] == 0 && B[31]==1) result = 0;  
                         else if ( A[31] == 1 && B[31]==0) result = 1;  
                         else result = 0;
                         zero = (result == 0)? 1 : 0;
                     end  
                     // A ¡Ñ B  
                     3'b111: begin  
                         result = A ^ B;  
                          zero = (result == 0)? 1 : 0;  
                     end  
              endcase  
          end  
endmodule