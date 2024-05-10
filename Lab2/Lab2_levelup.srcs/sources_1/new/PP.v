`timescale 1ns / 1ps
  
    module PP
    (
    input [31:0] A,
    input [31:0] B,
	
    output [63:0]PP0,
    output [63:0]PP1,
    output [63:0]PP2, 
    output [63:0]PP3,
    output [63:0]PP4,
    output [63:0]PP5,
    output [63:0]PP6,
    output [63:0]PP7,
    output [63:0]PP8,
    output [63:0]PP9,
    output [63:0]PP10,
    output [63:0]PP11,
    output [63:0]PP12,
    output [63:0]PP13,
    output [63:0]PP14,
    output [63:0]PP15
    );
    
    wire [63:0]PP[31:0];
 
    genvar i;
    generate
        for(i = 0; i <= 31; i = i + 1)
        begin: PP_LOOP //PARTIAL PRODUCT
            assign PP[i][63:0] = {32'h00000,(A[i] * B)} << i;
        end
	endgenerate
	 	
	assign PP0 = PP[0][63:0];
    assign PP1 = PP[1][63:0];
    assign PP2 = PP[2][63:0];
    assign PP3 = PP[3][63:0];
    assign PP4 = PP[4][63:0];
    assign PP5 = PP[5][63:0];
    assign PP6 = PP[6][63:0];
    assign PP7 = PP[7][63:0];
    assign PP8 = PP[8][63:0];
    assign PP9 = PP[9][63:0];
    assign PP10 = PP[10][63:0];
    assign PP11 = PP[11][63:0];
    assign PP12 = PP[12][63:0];
    assign PP13 = PP[13][63:0];
    assign PP14 = PP[14][63:0];
    assign PP15 = PP[15][63:0];	
	assign PP16 = PP[16][63:0];
    assign PP17 = PP[17][63:0];
    assign PP18 = PP[18][63:0];
    assign PP19 = PP[19][63:0];
    assign PP20 = PP[20][63:0];
    assign PP21 = PP[21][63:0];
    assign PP22 = PP[22][63:0];
    assign PP23 = PP[23][63:0];
    assign PP24 = PP[24][63:0];
    assign PP25 = PP[25][63:0];
    assign PP26 = PP[26][63:0];
    assign PP27 = PP[27][63:0];
    assign PP28 = PP[28][63:0];
    assign PP29 = PP[29][63:0];
    assign PP30 = PP[30][63:0];
    assign PP31 = PP[31][63:0];	
	
		
endmodule



