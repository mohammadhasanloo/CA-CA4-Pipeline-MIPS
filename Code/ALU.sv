`timescale 1ns/1ns
module ALU(input[31:0] inp1, inp2, input[2:0] ALU_operation, output logic zero, output logic [31:0] out);
    logic [31:0]sub;

    always @(inp1, inp2, ALU_operation) begin
      {out, zero} = 33'b0;
      case (ALU_operation)
          3'b010: out = inp1 + inp2;
          3'b110: out = inp1 + ~inp2 + 1; // Two's complement
          3'b111: out = (sub[31]) ? 32'd1 : 32'd0;
      // NOP : add R0,R0,R0
      default : out <= 32'b00000000000000000000000000000000;
    endcase
    if (out == 32'd0)
        zero = 1;
    end
endmodule 