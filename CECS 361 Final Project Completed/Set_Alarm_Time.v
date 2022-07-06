`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2020 09:18:00 PM
// Design Name: 
// Module Name: Set_Alarm_Time
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

//this module will allow us to set the time when the alarm will go off


module Set_Alarm_Time(
    input clk,
    input rst,
    input load_alarm, //input received from set alarm button in Clock Military
    input [23:0] clock_time, //input received from total time counter
    output reg [23:0] alarm_time //output signal that is sent to Activate Alarm
    );
    
    always@(posedge clk or posedge rst)
        if (rst)
            alarm_time <= 24'b0;
        else if (load_alarm)         //when we press the button on FPGA, whatever time it is currently,
            alarm_time <= clock_time;//will be the time the alarm will go off when reached
            

           
            
            
endmodule
