module RegisterFile(input clk, Reg_Write, input[4:0] Read_Reg1, Read_Reg2, Write_Reg, input[31:0] Write_Data, output equal, output logic [31:0] Read_Data1, Read_Data2);          
	logic [31:0] Registers [0:31];
	initial Registers[0] = 32'b0;

	wire [31:0] Test_Reg;
	wire [31:0] Test_Reg2;
	assign Test_Reg = Registers[1];
	assign Test_Reg2 = Registers[15];

	always@(negedge clk) begin
		if (Reg_Write) Registers[Write_Reg] <= Write_Data;
	end

	assign Read_Data1 = Registers[Read_Reg1];
	assign Read_Data2 = Registers[Read_Reg2];

	// Equal Component
	assign equal = (Read_Data1 == Read_Data2) ? 1 : 0;
endmodule  
