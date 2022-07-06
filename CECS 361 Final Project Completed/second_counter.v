`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 01:11:11 PM
// Design Name: 
// Module Name: second_counter
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

// keeps track of our total seconds and determines when our minutes will change

module second_counter(clk, rst, pulse, right_sec, left_sec, change_minute);
    input clk;
    input rst;
    input pulse; //input received from clock divider that tells us to increment second counter
    output reg [3:0] right_sec; //corresponds to least significant bits of our seconds
    output reg [3:0] left_sec; //corresponds to most significant bits of our seconds
    output wire change_minute; //output that sends a signal to our minute counter
    
    assign change_minute = (left_sec == 4'd5 && right_sec == 4'd10); // seconds has reached 60, meaning a minute has passed
                                                                     // so we send a pulse every 60 seconds to our minute counter
    
    always@(posedge clk, posedge rst)
        if (rst) begin
            right_sec <= 4'b0;
            left_sec <= 4'b0;
        end
        else if (left_sec == 4'd5 && right_sec == 4'd10) begin //our most significant second has reached 5 which means 50 seconds have passed
            left_sec <= 4'b0;                                  //as well as our least significant second being 10, meaning 60 seconds have passed in total
            right_sec <= 4'b0;
        end
        else if (left_sec != 4'd5 && right_sec == 4'd10) begin //least signifiant second has reahed 10, but most significant isn't 5 yet
            left_sec <= left_sec + 4'b1;
            right_sec <= 4'b0;
        end
        else if (pulse) // pulse fr0m clock divider tells us to increment by one second
            right_sec <= right_sec + 1'b1;
endmodule
