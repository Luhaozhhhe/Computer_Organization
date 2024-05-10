`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/14 13:04:08
// Design Name: 
// Module Name: adder_display
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


module adder_display(
    //???????
     input clk,
    input resetn,    //??"n"???????

    //???????????????cin
    input input_sel, //0:?????1(add_operand1);1:?????2(add_operand2)
    input input_sel1,
    input sw_cin,
    input sw_cin1,

    //led??????cout
    output led_cout,
    output led_cout1,
    
    //?????????????
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );

//-----{??????}begin
    reg  [31:0] adder_operand1;
    reg  [31:0] adder_operand2;
    reg  [31:0] adder_operand3;
    reg  [31:0] adder_operand4;
    wire        adder_cin;
    wire        addr_cin1;
    wire [31:0] adder_result  ;
    wire        adder_cout;
    wire        adder_cout1;
    adder32 adder_module(
        .operand1(adder_operand1),
        .operand2(adder_operand2),
        .operand3(adder_operand3),
        .operand4(adder_operand4),
        .cin     (adder_cin     ),
        .cin1     (adder_cin1    ),
        .result  (adder_result  ),
        .cout    (adder_cout    ),
        .cout1   (adder_cout1   )
    );
    assign adder_cin = sw_cin;
    assign adder_cin1=sw_cin1;
    assign led_cout  = adder_cout;
    assign led_cout1 =adder_cout1;
//-----{??????}end

//---------------------{???????}begin--------------------//
//-----{??????}begin
//????????
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),

        //????????
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd?????????????
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 
//-----{??????}end

//-----{????????}begin
//????????????????
//?????????????????always?
    //?input_sel?00??????????1??operand1
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand1 <= 32'd0;
        end
        else if (input_valid && !input_sel&&!input_sel1)
        begin
            adder_operand1 <= input_value;
        end
    end
    
    //?input_sel?01??????????2??operand2
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand2 <= 32'd0;
        end
        else if (input_valid && !input_sel&&input_sel1)
        begin
            adder_operand2 <= input_value;
        end
    end
//-----{????????}end
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand3 <= 32'd0;
        end
        else if (input_valid &&input_sel&&!input_sel1)
        begin
            adder_operand3 <= input_value;
        end
    end
        always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand4 <= 32'd0;
        end
        else if (input_valid && input_sel&&input_sel1)
        begin
            adder_operand4 <= input_value;
        end
    end
//-----{????????}begin
//??????????????
//??????44?????????44?32???
//44??????1????????1~44?
    always @(posedge clk)
    begin
        case(display_number)
            6'd1 :
            begin
                display_valid <= 1'b1;
                display_name  <= "ADD_1";
                display_value <= adder_operand1;
            end
            6'd2 :
            begin
                display_valid <= 1'b1;
                display_name  <= "ADD_2";
                display_value <= adder_operand2;
            end
            6'd3 :
            begin
                display_valid <= 1'b1;
                display_name  <= "ADD_3";
                display_value <= adder_operand3;
            end
            6'd4 :
            begin
                display_valid <= 1'b1;
                display_name  <= "ADD_4";
                display_value <= adder_operand4;
            end
            6'd5 :
            begin
                display_valid <= 1'b1;
                display_name  <= "RESULT";
                display_value <= adder_result;
            end
            default :
            begin
                display_valid <= 1'b0;
                display_name  <= 40'd0;
                display_value <= 32'd0;
            end
        endcase
    end
//-----{????????}end
//----------------------{???????}end---------------------//
endmodule

