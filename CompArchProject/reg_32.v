module reg_32(	input [31:0] in,
				input clk,
				input rst,
				input en,
				output reg [31:0] out
			);

always@(posedge clk or posedge rst)
begin
	if(rst)
		out <= 0;
	else if(en)
		out <= in;
end

endmodule
		