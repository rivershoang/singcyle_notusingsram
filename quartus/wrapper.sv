module wrapper (
   input  logic CLOCK_50,
   input  logic [17:0] SW,
   input  logic [ 3:0] KEY,
   
   output logic [31:0] pc_debug,
   output logic        insn_vld,
   output logic [17:0] LEDR,
   output logic [ 8:0] LEDG, 
   output logic [ 6:0] HEX0,
   output logic [ 6:0] HEX1,
   output logic [ 6:0] HEX2,
   output logic [ 6:0] HEX3,
   output logic [ 6:0] HEX4,
   output logic [ 6:0] HEX5,
   output logic [ 6:0] HEX6,
   output logic [ 6:0] HEX7,
   output logic [ 7:0] LCD_DATA,
   output logic        LCD_RW, LCD_EN, LCD_RS, LCDN, LCD_BLON
);

     wire [31:0] io_sw,io_btn ,io_hex0 ,io_hex1 ,io_hex2 ,io_hex3 ,io_hex4 ,io_hex5 ,io_hex6 ,io_hex7 ,io_ledr ,io_ledg ,io_lcd;

  assign io_sw     = {15'd0, SW[16:0]} ;
  assign io_btn    = {{28{1'b1}}, KEY[3:0]};
  assign HEX0      = io_hex0[6:0];
  assign HEX1      = io_hex1[6:0];
  assign HEX2      = io_hex2[6:0];
  assign HEX3      = io_hex3[6:0];
  assign HEX4      = io_hex4[6:0];
  assign HEX5      = io_hex5[6:0];
  assign HEX6      = io_hex6[6:0];
  assign HEX7      = io_hex7[6:0];
  assign LEDR      = io_ledr[17:0];
  assign LEDG      = io_ledg[8:0];
  assign io_lcd_w  = io_lcd[11:0];
  assign LCDN      = io_lcd[31];

  single_cycle single_cycle (
    .clk (CLOCK_50)     ,
    .rst (SW[17])       ,
    .io_sw  (io_sw )    ,
    .io_btn (io_btn)    ,
    .io_hex0 (io_hex0)  ,
    .io_hex1 (io_hex1)  ,
    .io_hex2 (io_hex2)  ,
    .io_hex3 (io_hex3)  ,
    .io_hex4 (io_hex4)  ,
    .io_hex5 (io_hex5)  ,
    .io_hex6 (io_hex6)  ,
    .io_hex7 (io_hex7)  ,
    .io_ledr (io_ledr)  ,
    .io_ledg (io_ledg)  ,
    .io_lcd  (io_lcd )  ,
    .pc_debug (pc_debug),
    .insn_vld (insn_vld)
  );

endmodule : wrapper 