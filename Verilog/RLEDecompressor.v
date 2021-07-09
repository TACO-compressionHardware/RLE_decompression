module RLEDecompressor #(parameter MEM_ADR_LEN)(input tclk, sclk, rst, serIn, output stackFull, serOut, bitValid);
  wire [7:0]codeWord, parallel_out;
  wire valid, read, stackEmpty;
  s2p UUG1(tclk, rst, serIn, stackFull, codeWord, valid);
  FIFOStack #(MEM_ADR_LEN) UUG2(parallel_out, stackFull, stackEmpty, tclk, sclk, rst, valid, read, codeWord);
  decoder UUG3(sclk, rst, stackEmpty, parallel_out, serOut, read, bitValid);
endmodule
