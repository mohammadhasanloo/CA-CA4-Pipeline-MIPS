module PC(input clk, rst, pc_write, input [31:0] inp, output logic[31:0] out);
	initial out = 32'b0;
	always @(posedge clk, posedge rst) begin
		if (rst) out <= 32'b0;
		else if (pc_write == 1) out <= inp;
	end
endmodule
