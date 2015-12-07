module adder( output reg [31:0] addResult, 
			input signed [31:0] data_a, 
			input signed [31:0] data_b 
		);

always @ (data_a or data_b) begin
	addResult = data_a + data_b; // add two inputs that are 32 bits
end

endmodule
