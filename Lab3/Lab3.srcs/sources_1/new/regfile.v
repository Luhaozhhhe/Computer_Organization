module regfile(
    input             clk,
    input      [1 :0] wen,
    input      [3 :0] raddr1,
    input      [3 :0] raddr2,
    input      [3 :0] waddr,
    input      [63:0] wdata,
    output reg [63:0] rdata1,
    output reg [63:0] rdata2,
    input      [3 :0] test_addr,
    output reg [63:0] test_data
    );
    reg [63:0] rf[15:0];
     
    // three ported register file
    // read two ports combinationally
    // write third port on rising edge of clock
    // register 0 hardwired to 0

    always @(posedge clk)
    begin
        if (wen == 2'd3) 
        begin
            rf[waddr][15:0] <= wdata[15:0];
        end
    end
     
    always @(posedge clk)
    begin
        if (wen == 2'd2) 
        begin
            rf[waddr][31:16] <= wdata[31:16];
        end
    end
    
    always @(posedge clk)
    begin
        if (wen == 2'd1) 
        begin
            rf[waddr][47:32] <= wdata[47:32];
        end
    end
    
    always @(posedge clk)
    begin
        if (wen == 2'd0) 
        begin
            rf[waddr][63:48] <= wdata[63:48];
        end
    end
    //¶Á¶Ë¿Ú1
    always @(*)
    begin
        case (raddr1)
            4'd1 : rdata1 <= rf[1 ];
            4'd2 : rdata1 <= rf[2 ];
            4'd3 : rdata1 <= rf[3 ];
            4'd4 : rdata1 <= rf[4 ];
            4'd5 : rdata1 <= rf[5 ];
            4'd6 : rdata1 <= rf[6 ];
            4'd7 : rdata1 <= rf[7 ];
            4'd8 : rdata1 <= rf[8 ];
            4'd9 : rdata1 <= rf[9 ];
            4'd10: rdata1 <= rf[10];
            4'd11: rdata1 <= rf[11];
            4'd12: rdata1 <= rf[12];
            4'd13: rdata1 <= rf[13];
            4'd14: rdata1 <= rf[14];
            4'd15: rdata1 <= rf[15];
            default : rdata1 <= 64'd0;
        endcase
    end
    //¶Á¶Ë¿Ú2
    always @(*)
    begin
        case (raddr2)
            4'd1 : rdata2 <= rf[1 ];
            4'd2 : rdata2 <= rf[2 ];
            4'd3 : rdata2 <= rf[3 ];
            4'd4 : rdata2 <= rf[4 ];
            4'd5 : rdata2 <= rf[5 ];
            4'd6 : rdata2 <= rf[6 ];
            4'd7 : rdata2 <= rf[7 ];
            4'd8 : rdata2 <= rf[8 ];
            4'd9 : rdata2 <= rf[9 ];
            4'd10: rdata2 <= rf[10];
            4'd11: rdata2 <= rf[11];
            4'd12: rdata2 <= rf[12];
            4'd13: rdata2 <= rf[13];
            4'd14: rdata2 <= rf[14];
            4'd15: rdata2 <= rf[15];
            default : rdata2 <= 64'd0;
        endcase
    end
     //µ÷ÊÔ¶Ë¿Ú£¬¶Á³ö¼Ä´æÆ÷ÖµÏÔÊ¾ÔÚ´¥ÃşÆÁÉÏ
    always @(*)
    begin
        case (test_addr)
            4'd1 : test_data <= rf[1 ];
            4'd2 : test_data <= rf[2 ];
            4'd3 : test_data <= rf[3 ];
            4'd4 : test_data <= rf[4 ];
            4'd5 : test_data <= rf[5 ];
            4'd6 : test_data <= rf[6 ];
            4'd7 : test_data <= rf[7 ];
            4'd8 : test_data <= rf[8 ];
            4'd9 : test_data <= rf[9 ];
            4'd10: test_data <= rf[10];
            4'd11: test_data <= rf[11];
            4'd12: test_data <= rf[12];
            4'd13: test_data <= rf[13];
            4'd14: test_data <= rf[14];
            4'd15: test_data <= rf[15];
            default : test_data <= 64'd0;
        endcase
    end
endmodule
