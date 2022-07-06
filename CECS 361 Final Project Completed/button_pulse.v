`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 10:40:05 PM
// Design Name: 
// Module Name: button_pulse
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

//this module sends out a pulse every 1 millisecond
//this is to get rid of the chatter that is present when working
//with mechanical switches

module button_pulse( 
    input clk,
    input rst,
    output wire pulse
    );
    
    reg [16:0] count;
    
    assign pulse = (count == 17'd99999); // 1ms pulse
    //17'd99999
    always@(posedge clk, posedge rst) begin
        if (rst)
            count <= 17'b0;
        else if (pulse)
            count <= 17'b0;
        else 
            count <= count + 17'b1;
   
        end
endmodule
