`include "timescale.svh"

module inst_mem #(
  parameter int unsigned IMEM_W = 13
) (
  input  logic [IMEM_W-1:0] raddr ,
  output logic [31:0]       rdata
);


  logic [3:0][7:0] imem [2**(IMEM_W-2)-1:0];

  initial begin
    $readmemh("E:/Lecture/ComputerArchitecture/singlecycle_notussingsram/test/dump/sw_to_seg/hex2dec_nam.txt", imem);
  end
  
  always_comb begin : proc_data
    rdata = imem[raddr[IMEM_W-1:2]][3:0];
  end

endmodule : inst_mem