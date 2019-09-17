module HDMI_Top(
  input wire            sysclk,
  input wire            rst,
  output wire           hdmi_tx_clk_n,
  output wire           hdmi_tx_clk_p,
  output wire   [2:0]   hdmi_tx_d_n,
  output wire   [2:0]   hdmi_tx_d_p
);
  //using 640 x 480 size

  //Horizontal Timing
  parameter H_ACTIVE_PIXEL  =11'd  640;
  parameter H_FRONT_PORCH   =11'd   16;
  parameter H_SYNC_WIDTH    =11'd   96;
  parameter H_BACK_PORCH    =11'd   48;
  parameter H_TOTAL         =11'd  800;
  parameter H_WIDTH         =11'd   11;

  //Vertical Timing
  parameter V_ACTIVE_LINE   =11'd  480;
  parameter V_FRONT_PORCH   =11'd   10;
  parameter V_SYNC_WIDTH    =11'd    2;
  parameter V_BACK_PORCH    =11'd   33;
  parameter V_TOTAL         =11'd  525;
  parameter V_WIDTH         =11'd   10;



  wire  hsync;
  wire  vsync;
  wire  de;
  wire  sysrst;
  wire  pixelclk;
  wire  serialclk;

  //Using mmcm to make 40Mclk and 200Mclk

  //Using rgb2dvi IPcore
  rgb2dvi_0 #(
    .KGenerateSerialClk(0)
  )rgb2dvi_1(
    .TMDS_Clk_p (hdmi_tx_clk_p), 
    .TMDS_Clk_n (hdmi_tx_clk_n),
    .TMDS_Data_p(hdmi_tx_d_p), 
    .TMDS_Data_n(hdmi_tx_d_n), 
    .aRst(!sysrst),
    .vid_pData(24'hff0000),//
    .vid_pVDE(de),
    .vid_pHSync(hsync),
    .vid_pVSync(vsync),
    .PixelClk(pixelclk)
    .SerialClk(serialclk)
  );
  
  //Control timing
 HDMI_Timing #(
  .H_ACTIVE_PIXEL(H_ACTIVE_PIXEL),
  .H_FRONT_PORCH (H_FRONT_PORCH ),
  .H_SYNC_WIDTH  (H_SYNC_WIDTH  ),
  .H_BACK_PORCH  (H_BACK_PORCH  ),
  .H_TOTAL       (H_TOTAL       ),
  .H_WIDTH       (H_WIDTH       ),
                  
  .V_ACTIVE_LINE (V_ACTIVE_LINE),
  .V_FRONT_PORCH (V_FRONT_PORCH),
  .V_SYNC_WIDTH  (V_SYNC_WIDTH ),
  .V_BACK_PORCH  (V_BACK_PORCH ),
  .V_TOTAL       (V_TOTAL      ),
  .V_WIDTH       (V_WIDTH      )
 )HDMI_Timing_0 (
   .clk(pixelclk),
   .rst(!sysrst),
   .hsync(hsync),
   .vsync(vsync),
   .de(de)
 ); 
 
clk_wiz_0 instance_name
  (
   // Clock out ports
   .clk_out1(pixelclk),     // output clk_out1
   .clk_out2(serialclk),     // output clk_out2
   // Status and control signals
  // .resetn(rst), // input resetn
   .locked(sysrst),       // output locked
  // Clock in ports
   .clk_in1(sysclk)
  );      //

endmodule
