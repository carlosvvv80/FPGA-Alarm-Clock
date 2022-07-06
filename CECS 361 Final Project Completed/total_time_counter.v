`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2020 12:46:58 AM
// Design Name: 
// Module Name: total_time_counter
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

//24 bit counter that recieves the values from counters for the seconds, minutes, and hours
//formats them in the order we want them to show up on our seven segment display

module total_time_counter(
    input clk,
    input rst,
    input [3:0] right_sec, //input coming from second counter
    input [3:0] left_sec, // input coming from second counter
    input [3:0] right_min, // input coming from minute counter
    input [3:0] left_min, // input coming from minute counter
    input [3:0] right_hour, // input coming from hour counter
    input [3:0] left_hour, // input coming from hour counter
    
    output reg [23:0]count // output that is determined by the values coming from the counters
    );
    
    always@(posedge clk, posedge rst) 
        if (rst)
            count <= 24'b0;
        else 
        count <= {left_hour , right_hour, left_min, // this copies the values of the inputs and formats the seconds, minutes, and hours in the order it would 
                  right_min, left_sec, right_sec};  // show on the seven segment display
                                                    // If the bits copied in were 0001 0011 0100 1000 0000 0011
endmodule                                           // then our clock would show  hours 13, minutes 48, seconds 03
