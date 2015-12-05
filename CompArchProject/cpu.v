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



pc                program_counter(pc_in,clk,rst,pc_out);
mux2_to_1_5bit    reg_file_mux(instruct[20:16],instruct[15:11],reg_destination,write_reg);
reg_file          register_file(reg_write,clk,
					instruct[25:21],
					instruct[20:16],
					write_reg,
					write_data_in,
					alu_in_1,
					alu_in_2);
sign_extend       se(instruct[15:0],sign_extend_out);
adder             pc_adder(pc_adder_out,pc_out,8'h00000004);
shift_left_pc     pc_shift_left(instruct[25:0],pc_adder_out,pc_shift_left_out);
alu_control       alu_ctrl(alu_op,instruct[5:0],alu_ctrl_out);
mux_2_to_1_32bit  alu_in_mux(pre_alu_in_2,sign_extend_out,alu_src,alu_in_2);
alu               ALU(alu_result_out,alu_zero_out,alu_ctrl_out,alu_in_1,alu_in_2);
mux_2_to_1_32bit  data_mem_out_mux(alu_result_out,data_out,mem_to_reg,write_data_in);
ctrlUnit          control_mod(instruct[31:26], 
					reg_destination, 
					jump_signal, 
					branch_signal, 
					mem_read, 
					mem_to_reg, 
					mem_write, 
					alu_src, 
					reg_write, 
					alu_op);							

shift_left        shift_left_mod(sign_extend_out, shift_left_out);	
adder             adder_mod(adder_out, pc_adder_out, shift_left_out);  
mux2_to_1_32bit   mux_mod_first(pc_adder_out, adder_out, and_out, mux_out);	
mux2_to_1_32bit   mux_mode_second(mux_out, pc_shift_left_out, jump_signal, pc_in); 



























