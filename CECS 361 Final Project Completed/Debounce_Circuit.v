`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 11:24:48 PM
// Design Name: 
// Module Name: Debounce_Circuit
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

//Connects the three modules together to create our debounce circuit
//Since debounce circuit is going to be used multiple times,
//instantiating it here will make it easier to use in other modules

module Debounce_Circuit(
    input clk,
    input rst,
    input button, //button being pressed on FPGA
    output doit   //signal that button has been pressed is sent
    );
    
    wire one_ms_pulse; 
    wire pulse_to_ped;
    
    button_pulse press (.clk(clk), .rst(rst), .pulse(one_ms_pulse));
    ten_bit_shift shift(.clk(clk), .rst(rst), .load(one_ms_pulse), .button_press(button), .ten_ms_pulse(pulse_to_ped));
    pos_edge_detect pos(.clk(clk), .rst(rst), .in(pulse_to_ped), .ped_pulse(doit));
    
endmodule
