`timescale 1ns / 1ps

module PCj(
    input [25:0] immediate,
    input [3:0] PC4,
    output reg [31:0] pcj
    );
    always @(immediate or PC4) pcj = {PC4, immediate, 2'b00};
endmodule