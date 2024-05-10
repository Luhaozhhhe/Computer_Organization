//*************************************************************************
//   > ???: multiply_display.v
//   > ??  ???????????FPGA???IO??????
//   > ??  : LOONGSON
//   > ??  : 2016-04-14
//*************************************************************************
module multiply_display(
    //???????
    input clk,
    input resetn,    //??"n"???????

    //????????????
    input input_sel, //0:?????1;1:?????2
    input sw_begin,
    
    //??????
    output led_end,

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
//-----{???????}begin
    wire        mult_begin;
    reg  [31:0] mult_op1; 
    reg  [31:0] mult_op2;  
    wire [63:0] product; 
    wire        mult_end;  
    assign mult_begin = sw_begin;
    assign led_end = mult_end;
    multiply multiply_module (
        .clk       (clk       ),
        .mult_begin(mult_begin),
        .mult_op1  (mult_op1  ), 
        .mult_op2  (mult_op2  ),
        .product   (product   ),
        .mult_end  (mult_end  )
    );
    reg [63:0] product_r;
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            product_r <= 64'd0;
        end
        else if (mult_end)
        begin
            product_r <= product;
        end
    end
//-----{???????}end

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
    //?input_sel?0??????????1
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            mult_op1 <= 32'd0;
        end
        else if (input_valid && !input_sel)
        begin
            mult_op1 <= input_value;
        end
    end
    
    //?input_sel?1??????????2
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            mult_op2 <= 32'd0;
        end
        else if (input_valid && input_sel)
        begin
            mult_op2 <= input_value;
        end
    end
//-----{????????}end

//-----{????????}begin
//??????????????
//??????44?????????44?32???
//44??????1????????1~44?
    always @(posedge clk)
    begin
        case(display_number)
            6'd17 :
            begin
                display_valid <= 1'b1;
                display_name  <= "M_OP1";
                display_value <= mult_op1;
            end
            6'd18 :
            begin
                display_valid <= 1'b1;
                display_name  <= "M_OP2";
                display_value <= mult_op2;
            end
            6'd19 :
            begin
                display_valid <= 1'b1;
                display_name  <= "PRO_H";
                display_value <= product_r[63:32];
            end
            6'd20 :
            begin
                display_valid <= 1'b1;
                display_name  <= "PRO_L";
                display_value <= product_r[31: 0];
            end
            default :
            begin
                display_valid <= 1'b0;
                display_name  <= 48'd0;
                display_value <= 32'd0;
            end
        endcase
    end
//-----{????????}end
//----------------------{???????}end---------------------//
endmodule
