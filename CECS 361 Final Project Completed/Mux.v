`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2020 11:08:30 AM
// Design Name: 
// Module Name: Mux_Switches
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

//controls which data coming from total time counter will be sent to our decoder to be displayed on the board


module Mux( //BCD control
    input [23:0] count,
    input [2:0] select, //input driven by Counter
    output reg [3:0] switch //output that is sent to decoder
    );
    
always@(*)
    case(select)
        3'b000: switch = count[3:0]; //corresponds with right seconds
        3'b001: switch = count[7:4]; //corresponds with left seconds
        3'b010: switch = count[11:8]; //corresponds with right minutes
        3'b011: switch = count[15:12]; //corresponds with left minutes
        3'b100: switch = count[19:16]; //corresponds with right hours
        3'b101: switch = count[23:20]; //corresponds with left hours
        default: switch = 4'b0;
     endcase
endmodule
