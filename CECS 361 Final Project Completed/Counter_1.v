`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2020 11:05:49 AM
// Design Name: 
// Module Name: Mux_Counter
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

//This module controls the select signal of Mux,
//and also controls which anode is illuminated at the same time in AnodeShiftRegister
//This is done so they stay in sync and the correct value is displayed on the correct anode
module Counter( //refresh counter
    input clk,
    input rst,
    input tick, //input signal received from pulse gen anode
    output reg [2:0] count //output which drives mux and anodeshiftregister
    
    );
    
always@(posedge clk or posedge rst)
    if (rst) count <= 3'b0;
    else if (count >= 3'b110) //since there are only 6 choices the mux and anodeshift register should select from
        count <= 3'b0;        //this counter should reach 5 and revert back to 0. (0, 1, 2, 3, 4, 5)
    else if (tick) count <= count + 3'b1; //increments counter 
    
endmodule
