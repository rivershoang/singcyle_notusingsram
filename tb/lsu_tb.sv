`timescale 1ns/1ps

module lsu_tb ();
   logic clk, rst_n, wr_en;
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
      .rst_n     (rst_n)         ,
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
      rst_n = 0;
      #1 
      rst_n = 1; 
      ld_sel = 3'b010;

   // hex0, hex1, hex2, hex3
   for (integer i = 0; i < 50; i = i + 1) begin
      write_data(16'h7020); 
      data_check (16'h7020,{1'b0, io_hex3, 1'b0, io_hex2, 1'b0, io_hex1, 1'b0, io_hex0});
      $display ("HEX0,1,2,3 = %h",{1'b0, io_hex3, 1'b0, io_hex2, 1'b0, io_hex1, 1'b0, io_hex0});
   end
  
   // hex7 hex6 hex5 hex4 
   for (integer i = 0; i < 50; i = i + 1) begin
      write_data(16'h7024); 
      data_check (16'h7024,{1'b0, io_hex7, 1'b0, io_hex6, 1'b0, io_hex5, 1'b0, io_hex4});
      $display ("HEX7,6,5,4 = %h",{1'b0, io_hex7, 1'b0, io_hex6, 1'b0, io_hex5, 1'b0, io_hex4});
   end

   // ledg 
   for (integer i =0; i < 50; i = i +1) begin
      write_data(16'h7010); 
      data_check (16'h7010,io_ledg);
      $display ("LEDG = %h",io_ledg);
   end
   // ledr 
   for (integer i =0; i < 50; i = i +1) begin
      write_data(16'h7000); 
      data_check (16'h7000,io_ledr);
      $display ("LEDR = %h",io_ledr);
   end
   
   // lcd 
   for (integer i = 0; i < 50; i = i +1) begin
      write_data(16'h7030); 
      data_check (16'h7030,io_lcd);
      $display ("LCD = %h",io_lcd);
   end
   // DMEM
   for (int i = 0; i <= 13'h7FF; i = i + 4) begin
      write_data(i);
      @(posedge clk);
      data_check(i, w_data); 
      $display ("DMEM[%h] = %h", i, w_data);
    end

   // Finish the simulation
   #5 $finish;
  end
  
  endmodule
   
   