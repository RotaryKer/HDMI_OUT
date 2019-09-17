`timescale 1ns / 1ps
module sim_HDMI();
  parameter   STEP = 5;
  parameter   n = 665000;

  reg                   clk;
  reg                   rst;
  wire  hsync;
  wire  vsync;
  wire  de;

 HDMI_Top HDMI_Top (
   .sysclk(clk),
   .rst(rst),
   .hsync(hsync),
   .vsync(vsync),
   .de(de)
 ); 

  initial begin
    clk = 1'b0;
  forever 
    #(STEP/2)clk = ~clk;
  end

  initial begin
    rst = 1'b1;
    #(STEP)rst = ~rst;
    #(STEP)rst = ~rst;
  end

  initial begin
    #(STEP*n) $finish();
  end

  initial begin
    $dumpfile("HDMI_Top.vcd");
    $dumpvars(0, HDMI_Top);
    //$monitor("%d %d %d %d",i,dout_1,dout_2,dout_3);
  end
  //initial begin
  //  $shm_open("result.shm");
  //  $shm_probe(sim_pbsbf4,"ACM");
  //end


endmodule
