`timescale 1ns/1ps

module singlecycle_tb ();
   logic clk, rst_n, insn_vld;
   logic [ 6:0] io_hex0, io_hex1, io_hex2, io_hex3, io_hex4, io_hex5, io_hex6, io_hex7;
   logic [31:0] io_ledr, io_ledg, io_lcd, io_sw, io_btn, instr_test, pc_debug;

   initial begin 
      clk = 0;
      forever #1 clk = ~clk;
   end

   singlecycle dut (
      .clk      (clk)     ,
      .rst_n    (rst_n)   ,
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
      .io_sw    (io_sw)   ,
      .insn_vld (insn_vld),
      .instr_test (instr_test)
   );

   initial begin 
      #1 rst_n = 0;
      #1 rst_n = 1;
      #1 io_sw = 32'd123456;
      # 1000; 
      #1 io_sw = 32'd000000;
      #1000;
      $stop; 
   end

endmodule : singlecycle_tb