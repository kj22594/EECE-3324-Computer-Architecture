module sign_extend(x,z);
input [15:0] x; // non extended input
output [31:0] z; // output extended  
reg z;  

always @ (x) begin
 
 	z[15:0] = x;

	if(x[15] == 1) begin
		z[31:16] = 16'b1111111111111111;
 	end

	 else if(x[15] == 0) begin
 		z[31:16] = 16'b0000000000000000;
 	end

end

endmodule
