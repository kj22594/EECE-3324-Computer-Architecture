module cpu(instruct,clk,rst)

input [31:0] instruct;           // this will be the instruction that is given
input [31:0] data_out            // from the memory file, will go into mux at the end
input clk, rst;                  // needed for the program counter

output [31:0] instruct_address;
output [31:0] data_address;
output [31:0] data_in;
output mem_read;
output mem_write;

wire [31:0] pc_in;               // mux to pc
wire [31:0] pc_out;              // output of pc
wire reg_destination;            // control unit to mux that determines register destination
wire reg_write;                  // enable for register file
wire [4:0] write_reg;            // goes into write register of reg file
wire [31:0] sign_extend_out;     // output of sign extend (goes into mux & shift left 2)
wire [1:0] alu_op;               // control signal of alu control unit
wire [3:0] alu_ctrl_out;         // output of alu control
wire [31:0] alu_in_1, alu_in_2;  // inputs to the alu -> read data 1 & input from the mux
wire [31:0] pre_alu_in_2;        // goes with into the mux w sign extend & to write data -> read data 2
wire alu_src;                    // select signal of the mux w/ sign extend & read data 2
wire alu_zero_out;               // output of alu zero -> goes into AND gate
wire branch_signal;              // input of the AND gate
wire [31:0] alu_result_out;      // output of alu -> input to address of data mem & mux for write data (0 of mux) 
wire mem_to_reg;                 // select signal of mux after data mem
wire [31:0] write_data_in;       // goes to the write data input on the reg file
wire [31:0] shift_left_out;      // output of shift left that goes into the adder
wire [31:0] adder_out;           // goes into the first mux 
wire [31:0] pc_adder_out;        // goes into the first mux & the adder
wire [31:0] mux_out;             // output of the first mux that goes into the 0 of the second mux
wire jump_signal;                // select signal of second mux
wire [31:0] pc_shift_left_out;   // output of shift left for the pc -> goes into the 1 of the second mux

assign and_out = branch_signal & alu_zero_out; // used as select signal of first mux after adder