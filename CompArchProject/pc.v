module pc(x,clk,rst,z);
input [31:0] x;
input clk,rst;
output reg [31:0] z;

initial begin
	z = 12288;
end

always @(posedge clk or posedge rst) begin
	
	if(rst) begin // reset to what the PC was at the beginning of the program
		z = 12288;
	end

	else begin
		z = x;
	end
end

endmodule
