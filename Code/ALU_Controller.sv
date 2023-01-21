module ALU_Controller(input [1:0] ALUop, input[5:0] func, output logic[2:0] ALU_operation);
  always @(ALUop, func) begin
    case(ALUop)
        2'b00: ALU_operation = 3'b010; // lw , sw
        2'b01: ALU_operation = 3'b110; // beq , bne
        2'b11: ALU_operation = 3'b111; // slti
        2'b10: begin // Rtype
          case(func)
            6'b100000: ALU_operation = 3'b010; // add
            6'b100010: ALU_operation = 3'b110; // sub
            6'b101010: ALU_operation = 3'b111; // slt
            default: ALU_operation = 3'b000;
          endcase
        end
        default: ALU_operation = 3'b000;
    endcase
  end
endmodule