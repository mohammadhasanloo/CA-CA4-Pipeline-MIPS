module InstructionMemory(input [31:0] address, output logic [31:0] instruction);
	logic [31:0] data[0:199];
	initial $readmemb("instruction_memory.mem", data);
	assign instruction = data[address[31:0]];
endmodule