module mux2_to_1_5bit(x,y,s,z); // initialize the mux module
input [4:0] x,y; // inputs to the mux
input s; // select signal
output reg [4:0] z; // output of the mux


always @(x or y or s) begin
  if(s == 1'b0) begin
    z = x;
  end

  else if(s == 1'b1) begin
    z = y;
  end

  else begin
    z = 5'bz; // if unknown or high impedance then set to high impedance
  end
end
endmodule
