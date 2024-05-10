module wallace_using_4x2compressor(p,a,b);
input [7:0]a,b;
output [15:0]p;

wire pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,pp9,pp10,pp11,pp12,pp13,pp14,pp15,pp16,pp17,pp18,pp19,pp20,
pp21,pp22,pp23,pp24,pp25,pp26,pp27,pp28,pp29,pp30,pp31,pp32,pp33,pp34,pp35,pp36,pp37,pp38,pp39,pp40,
pp41,pp42,pp43,pp44,pp45,pp46,pp47,pp48,pp49,pp50,pp51,pp52,pp53,pp54,pp55,pp56,pp57,pp58,pp59,pp60,
pp61,pp62,pp63;

wire s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,
s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,s38;

wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,
c21,c22,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32,c33,c34,c35,c36,c37,c38;

wire co1,co2,co3,co4,co5,co6,co7,co8,co9,co10,co11,co12,co13,co14,co15,co16,co17,co18;

// Partial product
assign pp0 = a[0] & b[0];
assign pp1 = a[1] & b[0];
assign pp2 = a[2] & b[0];
assign pp3 = a[3] & b[0];
assign pp4 = a[4] & b[0];
assign pp5 = a[5] & b[0];
assign pp6 = a[6] & b[0];
assign pp7 = a[7] & b[0];
assign pp8 = a[0] & b[1];
assign pp9 = a[1] & b[1];
assign pp10 = a[2] & b[1];
assign pp11 = a[3] & b[1];
assign pp12 = a[4] & b[1];
assign pp13 = a[5] & b[1];
assign pp14 = a[6] & b[1];
assign pp15 = a[7] & b[1];
assign pp16 = a[0] & b[2];
assign pp17= a[1] & b[2];
assign pp18= a[2] & b[2];
assign pp19= a[3] & b[2];
assign pp20= a[4] & b[2];
assign pp21= a[5] & b[2];
assign pp22= a[6] & b[2];
assign pp23= a[7] & b[2];
assign pp24= a[0] & b[3];
assign pp25= a[1] & b[3];
assign pp26= a[2] & b[3];
assign pp27= a[3] & b[3];
assign pp28= a[4] & b[3];
assign pp29= a[5] & b[3];
assign pp30= a[6] & b[3];
assign pp31= a[7] & b[3];
assign pp32= a[0] & b[4];
assign pp33= a[1] & b[4];
assign pp34= a[2] & b[4];
assign pp35= a[3] & b[4];
assign pp36= a[4] & b[4];
assign pp37= a[5] & b[4];
assign pp38= a[6] & b[4];
assign pp39= a[7] & b[4];
assign pp40= a[0] & b[5];
assign pp41= a[1] & b[5];
assign pp42= a[2] & b[5];
assign pp43= a[3] & b[5];
assign pp44= a[4] & b[5];
assign pp45= a[5] & b[5];
assign pp46= a[6] & b[5];
assign pp47= a[7] & b[5];
assign pp48= a[0] & b[6];
assign pp49= a[1] & b[6];
assign pp50= a[2] & b[6];
assign pp51= a[3] & b[6];
assign pp52= a[4] & b[6];
assign pp53= a[5] & b[6];
assign pp54= a[6] & b[6];
assign pp55= a[7] & b[6];
assign pp56= a[0] & b[7];
assign pp57= a[1] & b[7];
assign pp58= a[2] & b[7];
assign pp59= a[3] & b[7];
assign pp60= a[4] & b[7];
assign pp61= a[5] & b[7];
assign pp62= a[6] & b[7];
assign pp63= a[7] & b[7];

// STAGE 1
half_adder h1 (s1,c1,pp4,pp11);
compressor_4x2 t1 (s2,c2,co1,pp5,pp12,pp19,pp26,1'b0);
compressor_4x2 t2 (s3,c3,co2,pp6,pp13,pp20,pp27,co1);
half_adder h2 (s4,c4,pp34,pp41);
compressor_4x2 t3 (s5,c5,co3,pp7,pp14,pp21,pp28,co2);
compressor_4x2 t4 (s6,c6,co4,pp35,pp42,pp49,pp56,1'b0);
compressor_4x2 t5 (s7,c7,co5,pp15,pp22,pp29,pp36,co3);
compressor_4x2 t6 (s8,c8,co6,pp43,pp50,pp57,co4,1'b0);
compressor_4x2 t7 (s9,c9,co7,pp23,pp30,pp37,pp44,co5);
full_adder f1 (s10,c10,pp51,pp58,co6);
compressor_4x2 t8 (s11,c11,co8,pp31,pp38,pp45,pp52,co7);
full_adder f2 (s12,c12,pp39,pp46,pp53);

// STAGE 2
half_adder h3 (s13,c13,pp2,pp9);
compressor_4x2 t9 (s14,c14,co9,pp3,pp10,pp17,pp24,1'b0);
compressor_4x2 t10 (s15,c15,co10,pp18,pp25,pp32,s1,c14);
compressor_4x2 t11 (s16,c16,co11,pp33,pp40,c1,s2,c15);
compressor_4x2 t12 (s17,c17,co12,pp48,c2,s3,s4,c16);
compressor_4x2 t13 (s18,c18,co13,c3,c4,s5,s6,c17);
compressor_4x2 t14 (s19,c19,co14,c5,c6,s7,s8,c18);
compressor_4x2 t15 (s20,c20,co15,c7,c8,s9,s10,c19);
compressor_4x2 t16 (s21,c21,co16,pp59,c9,c10,s11,c20);
compressor_4x2 t17 (s22,c22,co17,pp60,c11,c21,s12,co8);
compressor_4x2 t18 (s23,c23,co18,pp47,pp54,pp61,c22,c12);
full_adder f3 (s24,c24,pp55,pp62,c23);

// STAGE 3
half_adder h4 (s25,c25,pp1,pp8);
full_adder f4 (s26,c26,pp16,s13,c25);
full_adder f5 (s27,c27,s14,c13,c26);
full_adder f6 (s28,c28,s15,co9,c27);
full_adder f7 (s29,c29,s16,co10,c28);
full_adder f8 (s30,c30,s17,co11,c29);
full_adder f9 (s31,c31,s18,co12,c30);
full_adder f10 (s32,c32,s19,co13,c31);
full_adder f11 (s33,c33,s20,co14,c32);
full_adder f12 (s34,c34,s21,co15,c33);
full_adder f13 (s35,c35,s22,co16,c34);
full_adder f14 (s36,c36,s23,co17,c35);
full_adder f15 (s37,c37,s24,co18,c36);
full_adder f16 (s38,c38,pp63,c24,c37);

// STAGE 4
assign p[0]=pp0;
assign p[1]=s25;
assign p[2]=s26;
assign p[3]=s27;
assign p[4]=s28;
assign p[5]=s29;
assign p[6]=s30;
assign p[7]=s31;
assign p[8]=s32;
assign p[9]=s33;
assign p[10]=s34;
assign p[11]=s35;
assign p[12]=s36;
assign p[13]=s37;
assign p[14]=s38;
assign p[15]=c38;

endmodule
