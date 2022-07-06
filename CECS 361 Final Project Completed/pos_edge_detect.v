`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 10:53:52 PM
// Design Name: 
// Module Name: pos_edge_detect
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

//ensures that only when the button is pressed (turns from 0 to 1) will it send its signal
//not when it goes from 1 to 0

module pos_edge_detect(
    input clk,
    input rst,
    input in, //input signal received from our ten bit shift register
    output ped_pulse //output signal that is high active when at the posedge of the clk
    );               //in is 1, while Q is the opposite or 0
    
    reg Q;
    
    always@(posedge clk, posedge rst) begin
        if (rst)
            Q <= 1'b0;
        else
            Q <= in; //Q copies the value of in
    end
    
    assign ped_pulse = in & ~Q; 
       
endmodule
