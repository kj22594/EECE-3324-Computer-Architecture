module sign_extend(x,z);
input [15:0] x; // non extended input
output reg [31:0] z; // output extended  

always @ (x) begin
 
	if(x[15] == 1) begin
		z = { 16'b1111111111111111, x };
 	end

	 else if(x[15] == 0) begin
 		z= { 16'b0000000000000000, x };
 	end

end

endmodule
