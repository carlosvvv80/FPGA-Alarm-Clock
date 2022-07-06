`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2020 10:57:33 AM
// Design Name: 
// Module Name: AnodeShiftReg
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

//anodes are the spots on our seven segment display where values can be shown
//8 different locations
//Determines which of the anodes will be illuminated
//

module AnodeShiftRegister(clk, rst, counter, anode); //anode control

    input clk;
    input rst;
    input [2:0] counter; //input signal received From Counter, which determines which anode to illuminate
    output [7:0] anode; //register that keeps track of our 8 different anodes
    reg [7:0] anode;
    
    always@(posedge clk or posedge rst)
        if (rst) anode <= 8'b1111_1110; else //reset will cause only the least signifcant anode to be illuminated
        
        begin
            case(counter)  //anodes are low active which means when it is a 0, it will illuminate
            3'b000: anode = 8'b1111_1110; //first anode illuminates which is in sync with right seconds being displayed on it
            3'b001: anode = 8'b1111_1101; //second anode illuminates which is in sync with left seconds being displayed on it
            3'b010: anode = 8'b1111_1011; //third anode illuminates which is in sync with right minutes being displayed on it
            3'b011: anode = 8'b1111_0111; //fourth anode illuminate which is in sync with left minutes being displayed on it
            3'b100: anode = 8'b1110_1111; //fifth anode illuminates which is in sync with right hours being displayed on it
            3'b101: anode = 8'b1101_1111; //sixth anode illuminates which is in sync with left hours being displayed on it
            default: anode = 8'b1111_1110;
            endcase //two most significant anodes are not used, which is why they are ignored in the case statements
            
        end
    
endmodule
