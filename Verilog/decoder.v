module decoder(input sclk, rst, stackEmpty, input [7:0]codeWord, output serOut, output reg read, bitValid);
  reg [1:0]ps, ns;
  reg load, cntenb, T;
  wire [7:0]word;
  wire Codezero;
  assign word = codeWord - 32;
  assign codeZero = ~(|word);
  wire zero, Q;
  
  downCounter I(sclk, rst, load, cntenb, word, , zero);
  TFF II(sclk, rst, T, Q);
  
  always @(posedge sclk)
    if (rst)
      ps <= 2'b00;
    else
      ps <= ns;
      
  always @(ps or stackEmpty or zero or codeZero)
  begin
    case (ps)
      2'b00:  ns = stackEmpty ? 2'b00 : 2'b01;
      2'b01:  ns = codeZero ? 2'b00 : 2'b10;
      2'b10:  ns = zero ? 2'b00 : 2'b10;
    endcase
  end  
  
  always @(ps)
  begin
    {load, cntenb, read, T, bitValid} = 5'b00000;
    case (ps)
      2'b01:  {load, T, read} = 3'b111;
      2'b10:  {cntenb, bitValid} = 2'b11;
    endcase
  end 
  assign serOut = ~Q;
endmodule

module downCounter(input clk, rst, lde, c_en, input[7:0] ld, output reg [7:0]count, output zero);
  always @ (posedge clk, posedge rst) begin
      if(rst)
        count <= 8'b11111111;
      else if(lde)
        count <= ld;
      else if(c_en)
        count <= count - 1;
  end
  assign zero = (count == 8'b00000001);
endmodule

module TFF(input clk, rst, t, output reg Q);
    always @ (posedge clk, posedge rst) begin
          if(rst)
              Q <= 1'b0;
          else if(t)
              Q <= ~Q;      
    end
endmodule