`timescale 1 ns/100 ps  // timeunt = 1 ns; precision = 1/10 ns;

module cpu_tb;

// inputs
reg rst, clk; 
wire [31:0] instruct, data_out;

// outputs
wire mem_read, mem_write;
wire [31:0] instruct_address, data_address, data_in;

// memory 

Memory      memory_mod(instruct_address,
			  instruct,
			  data_address,
			  data_in,
			  mem_read,
			  mem_write,
			  data_out); 

// cpu
cpu         cpu_mod(instruct,
			  data_out,
			  clk, rst,
			  instruct_address,
			  data_address,
			  data_in,
			  mem_read,
			  mem_write);



// initialize clock for posedge
initial begin
	// initialize clock
	clk = 0;

	// initialize reset 
	rst = 1;

	// stop reset
	#100 rst = 0;
end

// clock
always #10 clk = ~clk;

endmodule
