// Muxes
module Mux2to1_5bit(input[4:0] a, b,input select, output[4:0] out);
	assign out = select ? b : a;
endmodule

module Mux2to1_10bit(input [9:0] a, b, input select, output[9:0] out);
	assign out = select ? b : a;
endmodule

module Mux2to1_32bit(input [31:0] a, b, input select, output[31:0] out);
	assign out = select ? b : a;
endmodule

module Mux3to1_32bit(input [31:0] a, b, c, input[1:0] select, output[31:0] out);
	assign out = select[1] ? c : (select[0] ? b : a);
endmodule

module Mux4to1_32bit(input[31:0] a, b, c, d, input[1:0] select, output[31:0] out);
	assign out = select[1] ? (select[0] ? d : c) : (select[0] ? b : a);
endmodule