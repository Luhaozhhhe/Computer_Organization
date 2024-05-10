`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/14 12:40:06
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;

    // Inputs
    reg [31:0] operand1;
    reg [31:0] operand2;
    reg [31:0] operand3;
    reg [31:0] operand4;
    reg cin;
    reg cin1;
    

    // Outputs
    wire [31:0] result;
    wire cout;
    wire cout1;
    // Instantiate the Unit Under Test (UUT)
    adder32 uut (
        .operand1(operand1), 
        .operand2(operand2), 
        .operand3(operand3),
        .operand4(operand4),
        .cin(cin), 
        .cin1(cin1),
        .result(result), 
        .cout(cout),
        .cout1(cout1)
    );
    initial begin
        // Initialize Inputs
        operand1 = 0;
        operand2 = 0;
        operand3=0;
        operand4=0;
        cin = 0;
        cin1=0;
        // Wait 100 ns for global reset to finish
        #100;
        // Add stimulus here
    end
    always #10 operand1 = $random;  //$random?????????????32??
    always #10 operand2 = $random;  //#10 ????10?????(10ns)????10ns????????32??
    always #10 operand3=$random;
    always #10 operand4=$random;
    always #10 cin = {$random} % 2; //??????{$random}?????????2????0?1
    always #10 cin1={$random} %2;
endmodule
