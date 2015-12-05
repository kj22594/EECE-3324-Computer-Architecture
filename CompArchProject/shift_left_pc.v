module shift_left_pc(x,y,z);
input [25:0] x; // input to the shift left 2 for jumping
input [31:0] y; // input from the adder for pc + 4
output [31:0] z; // output of the shift left 2 for jumping
reg z;

	always @(x) begin
		z = { y[31:28], {x, 2'b00} };  // concatenation of first 4 bits of PC +4, with the left shift by 2 of the lowest 26 bits of instruction
	end

endmodule