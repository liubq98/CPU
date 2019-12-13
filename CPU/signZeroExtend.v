`timescale 1ns / 1ps

module signZeroExtend(
    input [15:0] immediate_16,
    input ExtSel,
    output reg[31:0] immediate_32
    );

   always@( immediate_16 or ExtSel ) begin
        if ( ExtSel == 0 )
            immediate_32 = { 16'h0000, immediate_16 };
        else if (immediate_16[15] == 1 )
            immediate_32 = { 16'hffff, immediate_16 };
        else
            immediate_32 = { 16'h0000, immediate_16 };
	end
endmodule