`timescale 1ns/1ps

module lsu_tb ();
   logic clk, rst, wr_en;
   logic [15:0] addr;
   logic [31:0] w_data, r_data, io_ledr, io_ledg, io_lcd, io_sw, io_btn;
   logic [ 3:0] bmask;
   logic [ 2:0] ld_sel;
   logic [ 6:0] io_hex0, io_hex1, io_hex2, io_hex3, io_hex4, io_hex5, io_hex6, io_hex7;

   initial begin 
      clk = 0;
      forever #1 clk = ~clk;
   end

   lsu lsu_dut (
      .clk       (clk)           ,
      .rst       (rst)           ,
      .addr      (addr)          ,
      .w_data    (w_data)        ,
      .wr_en     (wr_en)         ,
      .bmask     (bmask)         ,
      .ld_sel    (ld_sel)        ,
      .r_data    (r_data)        ,
      .io_ledr   (io_ledr)       ,
      .io_ledg   (io_ledg)       ,
      .io_hex0   (io_hex0)       ,
      .io_hex1   (io_hex1)       ,
      .io_hex2   (io_hex2)       ,
      .io_hex3   (io_hex3)       ,
      .io_hex4   (io_hex4)       ,
      .io_hex5   (io_hex5)       , 
      .io_hex6   (io_hex6)       ,
      .io_hex7   (io_hex7)       ,
      .io_lcd    (io_lcd)        ,
      .io_sw     (io_sw)         ,
      .io_btn    (io_btn)        
   );

   integer random_addr, random_data;
   // Write data 
   task write_data (input [15:0] addre);
      addr = addre;
      random_data = $random();
      w_data = random_data;
      @(posedge clk);
      wr_en = 1;
      bmask = 4'b1111;
      @(posedge clk);
      wr_en = 0;
      @(posedge clk);
      addre = 0;

      $display ("%h: Store %h", addr, random_data);
   endtask 

// Check data 
   task data_check (input [15:0] addre, input [31:0] data);
      addr = addre;
      @(posedge clk);
      assert (r_data == data) $display("%h: Read data = %h --> PASSED", addr, r_data); 
      else $error("%h: Read data = %h --> FAILED", addr, r_data);
      @(posedge clk);
      addre = 0;
   endtask

//Check data output peripharal and input 
   task data_peri (input [31:0] data1, input [31:0] data2);
      assert ( data1 == data2) $display("Data: %h    PASSED", data2);
      else $error ("Data: %h    FAILED", data2);
   endtask 


   initial begin
      rst = 1;
      #1 
      rst = 0; 
      ld_sel = 3'b010;

    // hex0, hex1, hex2, hex3
   for (integer i = 0; i < 10; i = i + 1) begin
      write_data(16'h7020); 
      data_check (16'h7020,{1'b0, io_hex3, 1'b0, io_hex2, 1'b0, io_hex1, 1'b0, io_hex0});
      $display ("HEX0 = %h",{1'b0, io_hex3, 1'b0, io_hex2, 1'b0, io_hex1, 1'b0, io_hex0});
   end
  
   /*
   //hex1
   for (integer i =0; i < 10; i = i +1) begin
      write_data(12'h810); 
      data_check (12'h810,io_hex1);
      $display ("HEX1 = %h",io_hex1);
   end
      
   //hex2
   for (integer i =0; i < 10; i = i +1) begin
      write_data(12'h820);
      data_check (12'h820,io_hex2);
      $display ("HEX2 = %h",io_hex2);
   end
   
   //hex3 
   for (integer i =0; i < 10; i = i +1) begin
      write_data(12'h830); 
      data_check (12'h830,io_hex3);
      $display ("HEX3 = %h",io_hex3);
   end
   
   //hex4 
   for (integer i =0; i < 10; i = i +1) begin
      write_data(12'h840); 
      data_check (12'h840,io_hex4);
      $display ("HEX4 = %h",io_hex4);
   end
   
   //hex5
   for (integer i =0; i < 10; i = i +1) begin
      write_data(12'h850); 
      data_check (12'h850,io_hex5);
      $display ("HEX5 = %h",io_hex5);
      end
      
   // hex6 
   for (integer i =0; i < 10; i = i +1) begin
      write_data(12'h860); 
      data_check (12'h860,io_hex6);
      $display ("HEX6 = %h",io_hex6);
   end
   
   */

   // hex7 hex6 hex5 hex4 
   for (integer i = 0; i < 10; i = i + 1) begin
      write_data(16'h7024); 
      data_check (16'h7024,{1'b0, io_hex7, 1'b0, io_hex6, 1'b0, io_hex5, 1'b0, io_hex4});
      $display ("HEX7 = %h",{1'b0, io_hex7, 1'b0, io_hex6, 1'b0, io_hex5, 1'b0, io_hex4});
   end

   
   // ledg 
   for (integer i =0; i < 10; i = i +1) begin
      write_data(16'h7010); 
      data_check (16'h7010,io_ledg);
      $display ("LEDG = %h",io_ledg);
   end
   // ledr 
   for (integer i =0; i < 10; i = i +1) begin
      write_data(16'h7000); 
      data_check (16'h7000,io_ledr);
      $display ("LEDR = %h",io_ledr);
   end
   
   // lcd 
   for (integer i =0; i < 10; i = i +1) begin
      write_data(16'h7030); 
      data_check (16'h7030,io_lcd);
      $display ("LCD = %h",io_lcd);
   end
      //
  
      #5 $finish;
  end
  
  endmodule
   
   