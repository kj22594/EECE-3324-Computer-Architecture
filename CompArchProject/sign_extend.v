module sign_extend(x,z);
input [15:0] x; // non extended input
output [31:0] z; // output extended  
reg z;  

always @ (x) begin
 
	if(x[15] == 1) begin
		z = { 16'b1111111111111111, x };
 	end

	 else if(x[15] == 0) begin
 		z= { 16'b0000000000000000, x };
 	end

end

endmodule
