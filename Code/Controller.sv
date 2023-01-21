module Controller(input clk,input equal, input[5:0] opcode, output logic flush, Mem_Read, Mem_Write, Mem_to_Reg, Reg_Dst, Reg_Write, output logic [1:0] ALU_op , ALU_src, branch, Pc_src);
	initial Pc_src = 2'b00;

	parameter [5:0] R_TYPE = 6'b000000;
	parameter [5:0] ADD_IMEDIATE = 6'b000001; // addi
	parameter [5:0] SLT_IMEDIATE = 6'b000010; // slti
	parameter [5:0] LOAD_WORD = 6'b000011; // lw
	parameter [5:0] SAVE_WORD = 6'b000100; // sw
	parameter [5:0] BRANCH_EQUAL = 6'b000101; // beq
	parameter [5:0] JUMP = 6'b000110; // j
	parameter [5:0] JUMP_REG = 6'b000111; // jr
	parameter [5:0] JUMP_AND_LINK = 6'b001000; // jal

	always @(*) begin
		{ALU_op,ALU_src,branch} = 6'b0;
		{flush,Mem_Read,Mem_Write,Mem_to_Reg,Reg_Dst,Reg_Write,Pc_src} = 7'b0;
		case(opcode)
			R_TYPE: begin
				ALU_op = 2'b10; Reg_Dst = 1'b1; Reg_Write = 1'b1;
			end
			ADD_IMEDIATE: begin
				ALU_src = 2'b01; Reg_Write = 1'b1;
			end
			SLT_IMEDIATE: begin
				ALU_src = 2'b01; ALU_op = 2'b11; Reg_Write = 1'b1;
			end
			LOAD_WORD: begin
				ALU_src = 2'b01; Mem_Read = 1; Mem_to_Reg = 1; Reg_Write = 1'b1;
			end
			SAVE_WORD: begin
				ALU_src = 2'b01;  Mem_Write = 1;
			end
			JUMP: begin
				flush = 1'b1; Pc_src = 2'b10;
			end
			JUMP_AND_LINK: begin 
				Mem_to_Reg = 1; Reg_Dst = 1; Pc_src = 2'b10;
			end
			JUMP_REG: begin
				Pc_src = 2'b11;
			end
			BRANCH_EQUAL: begin
				ALU_op = 2'b01; branch = 2'b01; 
				if (equal) begin 
					flush = 1'b1; Pc_src = 2'b01; 
				end 
			end
		endcase
	end
endmodule