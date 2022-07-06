`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 04:07:20 PM
// Design Name: 
// Module Name: hour_counter
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


module hour_counter(clk, rst, pulse_up, pulse_down, hour_up, hour_down, right_hour, left_hour);
    input clk;
    input rst;
    
    input pulse_up; //input coming from minute counter telling hours to increment 
    input pulse_down; //input coming from minute counter telling hours to decrement
    input hour_up; //input coming from our hour up button in clock military to increment hour counter manually
    input hour_down;//input coming from our hour down button in clock military to decrement hour counter manually
    
    output reg [3:0] right_hour; //4 least significant bits of hour
    output reg [3:0] left_hour; //4 most significant bits of hour
    
     always@(posedge clk, posedge rst)
                   if (rst) begin
                       right_hour <= 4'b0;
                       left_hour <= 4'b0;
                   end
                   else if (pulse_down && right_hour == 4'b0 && left_hour == 4'b0) begin //if both right and left hour are 0, as well as
                       right_hour <= 4'd3;                                         //pulse_down being active, right hour becomes 3 and
                       left_hour <= 4'd2;                                          //left hour becomes 2. Ex 00 changes to 23. Basically means the time was midnight 00:00, and we changed to 23:59 which would be the time right before midnight
                   end 
                   else if (pulse_down && right_hour == 4'b0 && left_hour != 4'b0) begin //if pulse_down, and right hour is 0, but left hour is not 0,
                       right_hour <= 4'd9;                                         //right hour becomes 9, and left hour decrement by 1
                       left_hour <= left_hour - 4'd1;                              //Ex. hour 20 changes to hour 19. Basically means it was 20:00 and the time changed to 19:59
                   end
                   else if (pulse_down && right_hour != 4'b0 && left_hour != 4'b0) begin //if pulse down, but right and left hour do not equal 0,
                       right_hour <= right_hour - 4'd1;                            //right hour decrements by 1, while left hour stays the same
                       left_hour <= left_hour;                                     //Ex. hour 16 changes to hour 15. Basically means it was 16:00 and the time changes to 15:59
                   end
                   else if (hour_down && right_hour == 4'b0 && left_hour == 4'b0) begin //if hour down is active which means we manually decrement the hour using our button,
                       right_hour <= 4'd3;                                        // right and left min equal 0, then right hour becomes 3,
                       left_hour <= 4'd2;                                         // while left hour becomes 2. Ex. 00 changes to 23
                   end
                   else if (hour_down && right_hour == 4'b0 && left_hour != 4'b0) begin ////if hour down is active which means we manually decrement the hour using our button,
                       right_hour <= 4'd9;                                        //right hour is 0 but left hour is not 0, then we 
                       left_hour <= left_hour - 4'd1;                             //right hour becomes 9, and we decrement left hour by 1. Ex. 20 changes to 19
                   end
                   else if (hour_up) //if hour up is active which means we manually pressed the button, we increment right hour by 1
                       right_hour <= right_hour + 4'b1;
                   else if (hour_down)//if hour down is active which means we manually pressed the button, we decrement right hour by 1
                       right_hour <= right_hour - 4'b1;
                       
                   else if (left_hour == 4'd2 && right_hour == 4'd4) begin // if we reach the hour 24, both hours should revert back to 0
                       left_hour <= 4'b0;
                       right_hour <= 4'b0;
                   end
                   else if (left_hour != 4'd2 && right_hour == 4'd10) begin // if right hour reaches 10 but left hour is not 0,
                       left_hour <= left_hour + 4'b1;                       // right hour changes to 0, while left hour increments by 1
                       right_hour <= 4'b0;                                  // Ex. 09 changes to 10
                   end
                   else if (pulse_up) //pulse is received from our minute counter, causing our right hour to increment by 1
                       right_hour <= right_hour + 1'b1;
    
endmodule
