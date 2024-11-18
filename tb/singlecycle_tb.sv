`timescale 1ns/1ns

module singlecycle_tb ();
   reg            clk, rst_n, insn_vld;
   reg   [31:0]   io_sw;
   wire  [ 6:0]   io_hex0, io_hex1, io_hex2, io_hex3, io_hex4, io_hex5, io_hex6, io_hex7;
   wire  [31:0]   io_ledr, io_ledg, io_lcd, io_btn, instr_test, pc_debug;

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

   always #1 clk = ~clk;

   initial begin 
      clk  = 0;
      rst_n = 0;
      #5 
      rst_n = 1;
      #1
      io_sw = 2;   
      #100000000; 
      $finish; 
   end

endmodule