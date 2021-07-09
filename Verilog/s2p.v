module s2p(input tclk, rst, serIn, stackFull, output [7:0]codeWord, output valid);
  wire beflag, shift;
  s2pDP UUB1(tclk, rst, serIn, shift, codeWord, beflag);
  s2pCU UUB2(tclk, rst, beflag, stackFull, shift, valid);
endmodule

module s2pDP(input tclk, rst, serIn, shift, output [7:0]codeWord, output beflag);
  wire [7:0]outReg1;
  wire [7:0]outReg2;
  sreg_param #(8) UUG1(serIn, rst, shift, tclk, outReg1);
  sreg_param #(8) UUG2(serIn, rst, shift, tclk, outReg2);
  assign beflag = (~outReg1[7]) & (~outReg1[6]) & (~outReg1[5]) &outReg1[4] & outReg1[3] &(~outReg1[2]) & outReg1[1] & outReg1[0];
  assign codeWord = outReg2;
endmodule

module s2pCU(input tclk, rst, beflag, stackFull, output reg shift, output valid);
  reg cntenb8, cntenb16;
  reg [1:0]ps, ns;
  wire srst, co8, co16;
  counter #(3) UU1(tclk, rst, cntenb8, srst, , co8);
  counter #(4) UU2(tclk, rst, cntenb16, , , co16);
  always @(posedge tclk)
  if (rst)
    ps <= 2'b00;
  else
    ps <= ns;

  always @(ps or beflag or co16 or stackFull)
  begin
    case (ps)
      2'b00:  ns = beflag ? 2'b01 : 2'b00;
      2'b01:  ns = co16 ? 2'b10 : 2'b01;
      2'b10:  begin
                if(beflag)
                  ns = 2'b00;
             	  else if(stackFull)
                  ns = 2'b11;
             	  else
       	          ns = 2'b10;
            	 end
      2'b11:  ns = stackFull ? 2'b11 : 2'b10;
    endcase
  end

  always @(ps)
  begin
    {cntenb8, cntenb16, shift} = 3'b001;
    case (ps)
      2'b01:  cntenb16 = 1'b1;
      2'b10:  begin
                cntenb8 = 1'b1;
              end
      2'b11:  shift = 1'b0;
    endcase
  end
  assign srst = beflag;
  assign valid = beflag ? 1'b0 : co8;
endmodule

module counter #(parameter n) (input clk, rst, enb, srst, output reg [(n-1):0]count, output co);
  always@(posedge clk, posedge rst)begin
    if(rst) count <= 0;
    else if(srst) count <= 0;
    else if(enb) count <= count + 1;
    else count <= count;
  end
  assign co = &count;
endmodule

module sreg_param #(parameter n) (d_in, sclr, shr, clk, d_out);
  input d_in, sclr, shr, clk;
  output [(n-1):0] d_out;
  reg [(n-1):0] d_out;

  always @(posedge clk)
  begin
    if (sclr)
      d_out = 0;
    else if (shr)
      d_out = {d_out[(n-2):0], d_in};
  end
endmodule
