module FIFOStack #(parameter adr_len)(data_out, fifo_full, fifo_empty, wclk, rclk, rst, wr, rd, data_in);  
  input wr, rd, wclk, rclk, rst;  
  input[7:0] data_in;  
  output[7:0] data_out;  
  output fifo_full, fifo_empty;  
  wire[(adr_len - 1):0] wptr, rptr;  
  wire fifo_we, fifo_rd; 
  write_pointer #(adr_len) top1(wptr, fifo_we, wr, fifo_full, wclk, rst);  
  read_pointer #(adr_len) top2(rptr, fifo_rd, rd, fifo_empty, rclk, rst);  
  memory_array #(adr_len) top3(data_out, data_in, wclk, fifo_we, fifo_rd, wptr, rptr);  
  status_signal #(adr_len) top4(fifo_full, fifo_empty, wptr, rptr);  
 endmodule  

 module memory_array #(parameter adr_len)(data_out, data_in, wclk, fifo_we, fifo_rd, wptr, rptr);  
  input[7:0] data_in;  
  input wclk, fifo_we, fifo_rd;  
  input[(adr_len - 1):0] wptr,rptr;  
  output[7:0] data_out;  
  reg[7:0] data_out2[((2**adr_len) - 1):0];   
  always @(posedge wclk)  
  begin  
   if(fifo_we)   
      data_out2[wptr[(adr_len - 1):0]] <= data_in ; 
  end   
  assign  data_out = data_out2[rptr[(adr_len - 1):0]];
 endmodule  

 module read_pointer #(parameter adr_len)(rptr, fifo_rd, rd, fifo_empty, rclk, rst);  
  input rd, fifo_empty, rclk, rst;  
  output reg[(adr_len - 1):0] rptr;  
  output fifo_rd;
  assign fifo_rd = (~fifo_empty) & rd;  
  always @(posedge rclk or posedge rst)  
  begin  
   if(rst) rptr <= 0;  
   else if(fifo_rd)  
    rptr <= rptr + 1;  
   else  
    rptr <= rptr;  
  end  
 endmodule  

 module status_signal #(parameter adr_len)(fifo_full, fifo_empty, wptr, rptr);   
  input[(adr_len - 1):0] wptr, rptr;  
  output fifo_full, fifo_empty;  
  reg[(adr_len - 1):0]one = 1;
  assign fifo_full = ((wptr + one) == rptr);  
  assign fifo_empty = (wptr == rptr);    
 endmodule  

 module write_pointer #(parameter adr_len)(wptr, fifo_we, wr, fifo_full, wclk, rst);  
  input wr, fifo_full, wclk, rst;  
  output reg[(adr_len - 1):0] wptr; 
  output fifo_we;   
  assign fifo_we = (~fifo_full) & wr;  
  always @(posedge wclk or posedge rst)  
  begin  
   if(rst) wptr <= 0;  
   else if(fifo_we)  
    wptr <= wptr + 1;  
   else  
    wptr <= wptr;  
  end  
 endmodule  