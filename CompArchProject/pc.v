module pc(x,clk,rst,z1,z2);
input [31:0] x;
input clk,rst;
output reg [31:0] z1, z2;

always @(posedge clk or posedge rst) begin
	
	if(rst) begin // reset to what the PC was at the beginning of the program
		z1 <= 12288;
		z2 <= 12288;
	end

	else begin
		z1 <= x;
		z2 <= x;
	end
end

endmodule
