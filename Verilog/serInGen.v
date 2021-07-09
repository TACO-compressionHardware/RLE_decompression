module serInGen(input tclk, enb, output serin);
  reg temp;
  integer file;
  initial begin
    file = $fopen("SERIN.txt", "r");
  end
  always@(posedge tclk)begin
    // $display("%d\n", $ftell(file));
    if(enb) begin
      if (!$feof(file)) 
        $fscanf(file, "%1b", temp);
      else
        temp <= 1'bz;
    end
  end
  assign serin = temp;
endmodule

