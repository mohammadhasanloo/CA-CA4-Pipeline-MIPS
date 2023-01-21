`timescale 1ns/1ns
module ForwardingUnit(input Execute_Memory_Reg_Write, Memory_WB_Reg_Write, input[4:0] IDExRs, IDExRt, exMemRd, memWBRd, input[5:0] OP_C, output logic forward, output logic [1:0] forwardA, forwardB);
	always @ (Execute_Memory_Reg_Write, Memory_WB_Reg_Write, IDExRs, IDExRt, exMemRd, memWBRd) begin
		forward = 1'b0;
		forwardA = 2'b00;
		forwardB = 2'b00;
		// Data Forwarding Conditions
		if(!(exMemRd == IDExRs && Execute_Memory_Reg_Write == 1 && exMemRd != 0) &&
			(memWBRd == IDExRs) && (Memory_WB_Reg_Write == 1) && (memWBRd != 0))
		begin forwardA = 2'b01; end
		
		else if ((exMemRd == IDExRs) && (Execute_Memory_Reg_Write == 1) && (exMemRd != 0))
		begin forwardA = 2'b10; end
		
		if(!(exMemRd == IDExRt && Execute_Memory_Reg_Write == 1 && exMemRd != 0 && OP_C == 6'b0) && 
			(memWBRd == IDExRt) && (Memory_WB_Reg_Write == 1) && (memWBRd != 0) && (OP_C == 6'b0)) 
		begin forwardB = 2'b10; forward = 1; end
		
		else if((exMemRd == IDExRt) && (Execute_Memory_Reg_Write == 1) && (exMemRd != 0) && (OP_C == 6'b0)) 
		begin forwardB = 2'b11; forward = 1; end
	end
endmodule