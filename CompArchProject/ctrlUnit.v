module controlunit (input [5:0] opcode,
					output reg regdest, 
					output reg jump, 
					output reg branch, 
					output reg memread,
					output reg memtoreg, 
					output reg memwrite, 
					output reg alusrc, 
					output reg regwrite,
					output reg[1:0] aluop 
				);
// These cases and outputs are taken from figure 4.22, P&H                   
always @ (opcode) 
begin
    {regdest, alusrc, memtoreg, regwrite, memread, memwrite, branch, jump, aluop} = 10'b0000000000;
    case (opcode)
		6'b000000 : 
			begin // ALU r-type, others are 0 by default
				regdest <= 1;
				regwrite <= 1;
				aluop <= 2'b10;
			end
		6'b001000 : 
			begin // addi instruction
				alusrc <= 1;
				regwrite <= 1;
			end
		6'b100011:
			begin // lw
				alusrc <= 1;
				memtoreg <= 1;
				regwrite <= 1;
				memread <= 1;
			end
		6'b101011: 
			begin // sw
				alusrc <= 1;
				memwrite <= 1;       
			end
		6'b000100: 
			begin // beq, alu will do subtraction
				branch <= 1;
				aluop <= 2'b01;
			end
		6'b000010: 
			begin // j
				jump <= 1;
				// all else is don't-care
			end
    endcase
end

endmodule