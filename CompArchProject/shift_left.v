module shift_left(x,z);
input [31:0] x; // input to the shift left 2 
output reg [31:0] z; // output of the shift left 2

always @(x) begin
	z = x * 4; // shift left 2
end

endmodule