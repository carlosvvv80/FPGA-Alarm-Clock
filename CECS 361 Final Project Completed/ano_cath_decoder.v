`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 09:51:33 AM
// Design Name: 
// Module Name: ano_cath_decoder
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

//decoder which takes the value from the mux that was selected, and converts it into a value that
//corresponds with which cathodes will be illuminated on the seven segment display
//there are 8 different cathodes, and they are low active, which means they will illuminated when equaling 0
// 0000 0000
//dpGFE DCBA (letters corresponding to cathode location)
module ano_cath_decoder(count, Cathode); 
    input [3:0] count;      //input that is received from the Mux
    output reg[7:0] Cathode; //output that will apply a certain value to the cathodes, making them light up to
                            //display the number we want
    
    always @(*)
          case(count)
             4'b0000: Cathode = 8'hC0; //1100 0000 0
             4'b0001: Cathode = 8'hF9; //1111 1001 1
             4'b0010: Cathode = 8'hA4; //1010 0100 2
             4'b0011: Cathode = 8'hB0; //1001 0000 3
             4'b0100: Cathode = 8'h99; //1001 1001 4
             4'b0101: Cathode = 8'h92; //1001 0010 5
             4'b0110: Cathode = 8'h82; //1000 0010 6
             4'b0111: Cathode = 8'hF8; //1111 1000 7
             4'b1000: Cathode = 8'h80; //1000 0000 8
             4'b1001: Cathode = 8'h90; //1001 0000 9
            
             default: Cathode = 8'hC0;
             endcase
            
endmodule
