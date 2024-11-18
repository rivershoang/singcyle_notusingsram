`timescale 1ns/1ns
module wrapper_tb ();
   logic CLOCK_27;
   logic [17:0] SW;
   logic [16:0] SW_DISP;
   logic [ 3:0] KEY;
   
   //  logic [31:0] pc_debug;
   //  logic        insn_vld;
   logic [17:0] LEDR;
   logic [ 7:0] LEDG; 
   logic [ 6:0] HEX0;
   logic [ 6:0] HEX1;
   logic [ 6:0] HEX2;
   logic [ 6:0] HEX3;
   logic [ 6:0] HEX4;
   logic [ 6:0] HEX5;
   logic [ 6:0] HEX6;
   logic [ 6:0] HEX7;
   logic [ 7:0] LCD_DATA;
   logic        LCD_RW;
   logic        LCD_EN; 
   logic        LCD_RS; 
   logic        LCD_ON;
   
   assign SW_DISP = SW[16:0];
   
   initial begin
      CLOCK_27 = 0;
      forever #1 CLOCK_27 = ~CLOCK_27; 
   end


   wrapper wrapper_dut (
      .CLOCK_27   (CLOCK_27),
      .SW         (SW),
      .KEY        (KEY),
      .HEX0       (HEX0),
      .HEX1       (HEX1),
      .HEX2       (HEX2),
      .HEX3       (HEX3),
      .HEX4       (HEX4),
      .HEX5       (HEX5),
      .HEX6       (HEX6),
      .HEX7       (HEX7),
      .LEDG       (LEDG),
      .LEDR       (LEDR),
      .LCD_DATA   (LCD_DATA),
      .LCD_RW     (LCD_RW),
      .LCD_EN     (LCD_EN),
      .LCD_RS     (LCD_RS),
      .LCD_ON     (LCD_ON)
   );

   initial begin 
      SW[17] = 0;
      #5 
      SW[17] = 1;
      #1
      SW[16:0] = 64;
      #1000;
      SW[16:0] = 1000;
      #1000; 
      SW[16:0] = 2047;
      
      // Chạy mô phỏng trong 1 phút (60 giây)
      #1000000; // 1 phút xung nhịp 50 MHz (thời gian trong nanosecond)
      $stop; 
   end

endmodule : wrapper_tb
