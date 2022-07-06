`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 03:42:05 PM
// Design Name: 
// Module Name: Clock_Divider
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


module Clock_Divider(clk, rst, start, clk_divider);

    
        input clk;
        input rst;
        input start; //input that is recived from our start switch
        output wire clk_divider; //output signal that increment our second counter when it is high active
        
        
        reg [26:0] count; //counter that has enough bits to hold a large value such as 100,000,000 
        
        assign clk_divider = (count == 27'd100000000); // sends out pulse every one second
        //100mhz clock takes 10ns for one clock cycle
        //1 = 10ns, 10 = 100ns, 100 = 1000ns/1us, 1000 = 10us, 10,000 = 100us 
        //100,000 = 1000us/1ms, 1,000,000 = 10ms, 10,000,000 = 100ms, 100,000,000 = 1000ms/1second
        // 100000 == 1ms, 1000ms = 1sec, 100000 x 1000 = 100,000,000
        
                
                
                    
                always@(posedge clk, posedge rst) begin
                    if (rst) begin
                        count <= 27'b0;
                        
                    end
                    else if (count >= 27'd100000000) //count reaches number that corresponds to 1 second 
                                                    //and should revert back to 0 to start counting again
                        count <= 27'b0;
                    else if (start) // start switch determines if we are allowed to increment or not
                        count <= count + 27'b1;
                    
                end
               
endmodule
