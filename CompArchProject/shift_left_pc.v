module shift_left_pc(x,y,z);
input [25:0] x; // input to the shift left 2 for jumping
input [31:0] y // input from the adder for pc + 4
output [31:0] z; // output of the shift left 2 for jumping
reg z;

	always @(x) begin
		z[31:28] = y[31:28];
		z[27:2] = x;
		z[1:0] = 2'b00;
	end

endmodule