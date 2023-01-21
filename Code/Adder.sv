`timescale 1ns/1ns
// Output : a+b
module Adder(input[31:0] a, b, output[31:0] out);
	assign out = a + b;
endmodule