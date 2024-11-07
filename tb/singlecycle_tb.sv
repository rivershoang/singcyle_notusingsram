`timescale 1ns/1ps

module singlecycle_tb ();
   logic clk, rst, pc_debug, insn_vld;
   logic [ 6:0] io_hex0, io_hex1, io_hex2, io_hex3, io_hex4, io_hex5, io_hex6, io_hex7;
   logic [31:0] io_ledr, io_ledg, io_lcd, io_sw, io_btn;

   initial begin 
      clk = 0;
      forever #1 clk = ~clk;
   end

   singlecycle dut (
      .clk      (clk)     ,
      .rst      (rst)     ,
      .pc_debug (pc_debug),
      .io_ledg  (io_ledg) ,
      .io_lcd   (io_lcd)  ,
      .io_btn   (io_btn)  ,
      .io_ledr  (io_ledr) ,
      .io_hex0  (io_hex0) ,
      .io_hex1  (io_hex1) ,
      .io_hex2  (io_hex2) ,
      .io_hex3  (io_hex3) ,
      .io_hex4  (io_hex4) ,
      .io_hex5  (io_hex5) , 
      .io_hex6  (io_hex6) ,
      .io_hex7  (io_hex7) ,
      .insn_vld (insn_vld)
   );

   initial begin 
      #1 rst = 1;
      #1 rst = 0;
      #100;
      $finish; 
   end

endmodule : singlecycle_tb