`timescale 1ns/1ns
module RLEDecompressorTB();
  reg tclk = 0, sclk = 0, rst = 1;
  wire serIn, stackFull, bitValid, serOut;
  RLEDecompressor #(2) T1(tclk, sclk, rst, serIn, stackFull, serOut, bitValid);
  serInGen T2(tclk, ~stackFull, serIn);
  serOutRec T3(sclk, bitValid, serOut);
  always repeat(2000)#13 tclk = ~tclk;
  always repeat(2000)#10 sclk = ~sclk;
  initial #25000 $stop;
  initial begin
    #15 rst = 0;
  end
endmodule

