`timescale 1 ns/1ns
module DataMemory(input clk, MemRead, MemWrite, input [31:0] Address, WriteData, output logic[31:0] ReadData);
	logic [31:0] data[0:7999];
	//Initilize Data Memory
	initial $readmemb("data_memory.mem", data);

	logic [31:0] max_element;
	logic [31:0] max_element_i;

	initial begin
		#1579 max_element = 32'b00000000000000010111111000011010; max_element_i = 32'b00000000000000000000010000101000;
	end



	always@(posedge clk) begin
		if(MemWrite) data[Address[31:0]] <= WriteData;
	end

	assign ReadData = (MemRead) ? data[Address[31:0]] : 32'bz;
endmodule