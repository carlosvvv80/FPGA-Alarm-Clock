`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 02:52:38 PM
// Design Name: 
// Module Name: Activate_Alarm
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

//Activates the alarm 

module Activate_Alarm(
    input clk,
    input rst,
    input start, //input received from start switch in Clock Military
    input [23:0] alarm_time, //input received from set alarm time
    input [23:0] current_time, //input received from total time counter
    output wire play //output that sends a signal to alarm_song, telling it to play the song 
    );
    
    reg load; //register that will be used to set play to a value of 1 or 0
    
    assign play = load;
    
    
    always@(posedge clk or posedge rst)
        if (rst)
            load <= 1'b0;
            
        else if (start && (alarm_time == current_time)) //if start is active which means the clock has started, 
            load <= 1'b1;                              //and our alarm time that we set earlier equals the current time
endmodule                                              //then load becomes 1
