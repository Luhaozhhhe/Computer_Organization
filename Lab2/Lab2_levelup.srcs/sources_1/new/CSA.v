`timescale 1ns / 1ps

module CSA #(parameter N = 64)
    (
    input [N-1:0] A, // k�sm� �arpan 1
    input [N-1:0] B, // k�sm� �arpan 2 
    input [N-1:0] C, // k�sm� �arpan 3
    
    output [N-1:0] SUM,
    output [N-1:0] CARRY    
    );
    
    assign SUM = A ^ B ^ C;
    assign CARRY[0] = 0;
    assign CARRY[N-1:1] = (A&B) | (A&C) | (B&C);
        
endmodule