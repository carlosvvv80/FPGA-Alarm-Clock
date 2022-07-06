`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2020 01:31:46 PM
// Design Name: 
// Module Name: second_counter_tb
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


module second_counter_tb(

    );
    reg clk;
    reg rst;
    reg pulse; //input received from clock divider that tells us to increment second counter
    wire [3:0] right_sec; //corresponds to least significant bits of our seconds
    wire [3:0] left_sec; //corresponds to most significant bits of our seconds
    wire change_minute; //output that sends a signal to our minute counter
    
    second_counter uut(.clk(clk), .rst(rst), .pulse(pulse), .right_sec(right_sec), .left_sec(left_sec), .change_minute(change_minute));
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 1;
        rst = 1;
        pulse = 0;
        #100;
        rst = 0;
        pulse = 1;
        #10000;
    end
endmodule
