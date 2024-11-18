module wrapper (
   input  logic CLOCK_27,
   input  logic [17:0] SW,
   input  logic [ 3:0] KEY,
   
   // output logic [31:0] pc_debug,
   // output logic        insn_vld,
   output logic [17:0] LEDR,
   output logic [ 7:0] LEDG, 
   output logic [ 6:0] HEX0,
   output logic [ 6:0] HEX1,
   output logic [ 6:0] HEX2,
   output logic [ 6:0] HEX3,
   output logic [ 6:0] HEX4,
   output logic [ 6:0] HEX5,
   output logic [ 6:0] HEX6,
   output logic [ 6:0] HEX7,
   output logic [ 7:0] LCD_DATA,
   output logic        LCD_RW, 
                       LCD_EN, 
                       LCD_RS, 
                       LCD_ON 
);

   logic [31:0]    io_lcd,
                     io_ledg,
                     io_ledr;
   
   
   assign LEDR[16:0] = io_ledr[16:0];
   assign LEDG = io_ledg[7:0];

   assign LCD_ON = 1'b1;
   assign LCD_EN = io_lcd[10];
   assign LCD_RS = io_lcd[9];
   assign LCD_RW = io_lcd[8];
   assign LCD_DATA = io_lcd[7:0];
   assign LEDR[17] = SW[17];

   singlecycle single_cycle (
      .clk      (CLOCK_27          ),
      .rst_n    (SW[17]            ),
      .io_sw    ({15'b0, SW[16:0]} ),
      .io_btn   (~KEY              ),
      .io_hex0  (HEX0              ),
      .io_hex1  (HEX1              ),
      .io_hex2  (HEX2              ),
      .io_hex3  (HEX3              ),
      .io_hex4  (HEX4              ),
      .io_hex5  (HEX5              ),
      .io_hex6  (HEX6              ),
      .io_hex7  (HEX7              ),
      .io_ledr  (io_ledr           ),
      .io_ledg  (io_ledg           ),
      .io_lcd   (io_lcd            ),
      .pc_debug (                  ),
      .insn_vld (                  )
   );

endmodule