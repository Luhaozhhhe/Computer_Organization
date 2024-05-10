module full_adder(output s,output cout,input a,input b,input cin);
wire z1,z2,z3;
xor(z1,a,b);
xor(s,z1,cin);
and(z2,z1,cin);
and(z3,a,b);
or(cout,z2,z3);
endmodule
