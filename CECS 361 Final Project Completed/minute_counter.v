`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 03:55:00 PM
// Design Name: 
// Module Name: minute_counter
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


module minute_counter(clk, rst, pulse, minute_up, minute_down, right_min, left_min, change_hour_up, change_hour_down);

        input clk;
        input rst;
        input pulse; //input coming from second counter that tells us to increment our minute counter
        input minute_up; //input coming from our minute up button in clock military to increment minute counter manually
        input minute_down; //input coming from our minute down button in clock military to decrement minute counter manually
        output reg [3:0] right_min; //4 least significant bits of our minutes
        output reg [3:0] left_min; //4 most significant bits of our minutes
        output wire change_hour_up; // output that sends signal to hour counter to increment
        output wire change_hour_down; // output that sends signal to hour counter to decrement
   
        
        assign change_hour_up = (left_min == 4'd5 && right_min == 4'd10); // sends pulse when we reach 60 minutes
        assign change_hour_down = minute_down && right_min == 4'b0 && left_min == 4'b0; // sends pulse when both right and left minutes are 0, while minute down button has been pressedm
        
        always@(posedge clk, posedge rst)
                if (rst) begin
                    right_min <= 4'b0;
                    left_min <= 4'b0;
                end
                else if(minute_down && right_min == 4'b0 && left_min == 4'b0) begin //when both minutes are 0, and the minute down button is pressed
                    right_min <= 4'd9;                                              //the minutes will change to a value of 59
                    left_min <= 4'd5;
                end
                else if(minute_down && right_min == 4'b0 && left_min != 4'b0) begin//when the minute down button is pressed,
                    right_min <= 4'd9;                                        //if right min equals 0 but left min is not 0
                    left_min <= left_min - 4'd1;                              //right min becomes 9 while left min decrements by 1
                end                                                           //Ex. 40 changes to 39
                else if (minute_up) // minute up button is pressed, increments right minute by 1. Ex. 37 changes to 38
                    right_min <= right_min + 4'b1;
                else if (minute_down) //minute down button is pressed, decrements right minute by 1. Ex. 25 changes to 24
                    right_min <= right_min - 4'b1;
                else if (left_min == 4'd5 && right_min == 4'd10) begin //when left min equals 5, and right minute equals 10
                    left_min <= 4'b0;                                  //this means 60 minutes have passed and they should both turn
                    right_min <= 4'b0;                                 //back to 0
                end
                else if (left_min != 4'd5 && right_min == 4'd10) begin //when left minutes does not equal 5, but right minute equals 10,
                    left_min <= left_min + 4'b1;                       //left minute should increment by 1 while right minute turns to 0
                    right_min <= 4'b0;                                 //Ex. 19 changes to 20
                end
                else if (pulse) // pulse from second_counter tells us to increment right minute by 1
                    right_min <= right_min + 1'b1;
       
endmodule
