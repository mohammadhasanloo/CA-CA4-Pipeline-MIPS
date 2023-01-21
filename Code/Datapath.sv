module Datapath(input clk, rst, flush, Mem_Read_c, Mem_Write_c, Mem_to_Reg_c, Reg_Dst_c, Reg_Write_c, input[1:0] ALU_src_c, pc_src, input [2:0] ALU_operation_c, output equal, zero, output [5:0] function_ , opcode);
	// Control Signals
	logic forward, hazard, IFID_write, mem_to_reg_in, mem_read_out, mem_write_out, mem_to_reg_out, mem_read, mem_write, mem_to_reg, pc_write, reg_write, reg_dst, reg_write_out, reg_write_in;
	logic [1:0] alu_src, forwardA, forwardB, sel_src2;
	logic [2:0] alu_operation;
	// Wires
	logic [4:0] dst_1, dst_2, dstsel, regdst, Rs, Write_Reg, write1, write2;
	logic [5:0] OPC_out;
	logic [9:0] control, control_out;
	logic [31:0] address, addout, ALUResult, A, B, d1, d2, instruction, jpc, jumpdst, JumpAddress, memdata, ReadData1, ReadData2, ReadData, regdata, regin,
	Pcin, Pcout, pcadd, pc4, seout, shin, shout, WriteData, WriteMemData;

	assign sel_src2 = forward ? forwardB : alu_src;
	assign control = {Reg_Write_c,ALU_src_c,Mem_Read_c,Mem_Write_c, Mem_to_Reg_c,Reg_Dst_c,ALU_operation_c};
	assign function_ = regin[5:0];
	assign JumpAddress = {pc4[31:28], regin[25:0], 2'b0};
	assign opcode = regin[31:26];
	

	Adder add1({29'b0, 3'b100}, Pcout, pcadd);
	Adder add2(pc4, shout, addout);
	//ALU
	ALU alu_M(A, B, alu_operation, zero, ALUResult);
	//Data Memory & Instruction Memory & Register File
	DataMemory DM(clk, mem_read, mem_write, address, WriteMemData, ReadData);
	InstructionMemory IM(Pcout, instruction);
	RegisterFile RF(clk, reg_write, regin[25:21], regin[20:16] , Write_Reg, Write_Data, equal, ReadData1, ReadData2);
	// Execute/Memory Stage
	EX_MEM EXM(clk, zero, reg_write_out, mem_read_out, mem_write_out, mem_to_reg_out, dstsel, addout, ALUResult, d2, reg_write_in, mem_read, mem_write,
	mem_to_reg_in, regdst, jumpdst, address, WriteMemData);
	// Data Forwarding Unit
	ForwardingUnit fu(reg_write_in, reg_write, Rs, dst_1, regdst, Write_Reg, OPC_out, forward, forwardA, forwardB);
	// Hazard Detection Unit
	HazardUnit hu(mem_read_out, dst_1, regin[25:21], regin[20:16], regin[31:26], IFID_write, hazard, pc_write);
	// Instruction Decode/Execute Stage
	ID_EX ID_M(clk, control_out[9], control_out[6], control_out[5], control_out[4], control_out[3], control_out[8:7], control_out[2:0], regin[20:16], regin[15:11], regin[25:21], regin[31:26],
	pc4, ReadData1, ReadData2, seout, reg_dst, reg_write_out, mem_read_out, mem_write_out, mem_to_reg_out, alu_src, alu_operation, dst_1, dst_2, Rs, OPC_out, jpc, d1, d2, shin);
	// Instruction Fetch/Instruction Decode Stage
	IF_ID IF_M(clk, rst, IFID_write, flush , pcadd, instruction, regin, pc4);
	// Memory/WB Stage
	MEM_WB MWB(clk, reg_write_in, mem_to_reg_in, regdst, address, ReadData , reg_write, mem_to_reg, Write_Reg, memdata, regdata);
	// Mux
	Mux2to1_5bit M2_15(dst_1, dst_2, reg_dst, dstsel);
	Mux2to1_10bit m2_10(10'b0, control, hazard, control_out);
	Mux2to1_32bit m2_32(regdata, memdata, mem_to_reg, Write_Data);
	Mux3to1_32bit m3_32(d1, Write_Data, address, forwardA, A);
	Mux3to1_32bit m3_32_(pcadd, addout, JumpAddress, pc_src, Pcin);
	Mux4to1_32bit m4_32(d2, shin, Write_Data, address,sel_src2, B);
	//Program Counter
	PC PC_m(clk, rst, pc_write, Pcin, Pcout);
	// Shift Left Component
	ShiftLeft2 SL2(seout, shout);
	// Sign Extend
	SignExtend SE(regin[15:0], seout);
endmodule