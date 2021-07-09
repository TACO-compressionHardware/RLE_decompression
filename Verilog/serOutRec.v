module serOutRec(input sclk, val, serOut);
  integer file;
  initial begin
    file = $fopen("SEROUT.txt", "w");
  end
  always@(posedge sclk)begin
    // $display("%d\n", $ftell(file));
    if(val)
        $fwrite(file,"%b", serOut);
  end
endmodule


