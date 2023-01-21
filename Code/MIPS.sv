// Top Module
module mips(input clk, rst);
	//Signals
	logic equal, flush, MemRead, MemWrite, Mem_to_Reg, Reg_Write, Reg_Dst ,zero;
	logic [1:0] ALU_src, ALU_op, branch, pc_src;
	logic [2:0] ALU_operation;
	logic [5:0] func , operation_code;
	//Controller
	ALU_Controller ALU_C(ALU_op, func, ALU_operation);
	Controller CU(clk,equal, operation_code, flush, MemRead, MemWrite, Mem_to_Reg, Reg_Dst, Reg_Write, ALU_op, ALU_src, branch, pc_src);
	//Datapath wiring
	Datapath DP(clk, rst, flush, MemRead, MemWrite, Mem_to_Reg, Reg_Dst, Reg_Write, ALU_src, pc_src, ALU_operation, equal, zero, func, operation_code);
endmodule
