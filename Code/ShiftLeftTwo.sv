module ShiftLeft2(input [31:0] inp, output [31:0] out);
  assign out = {inp[29:0] , 2'b00};
endmodule