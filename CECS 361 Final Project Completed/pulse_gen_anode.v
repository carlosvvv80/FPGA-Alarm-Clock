`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2020 03:45:55 PM
// Design Name: 
// Module Name: pulse_gen_anode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pulse_gen_anode(clk, rst, pulse); //pulse anode 
   input clk;
   input rst;
   output pulse;
   wire pulse;
   
   reg [17:0] count, ncount;
   
   
   assign pulse = (count == 18'd199999);
   // 18'd199999 == 2
   always@(posedge clk, posedge rst)
       if (rst) count <= 18'b0;
       else count <= ncount;
   always@(*)
       if (pulse) ncount = 18'b0;
       else ncount = count + 18'b1;
   

endmodule


