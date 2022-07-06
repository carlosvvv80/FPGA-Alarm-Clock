`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2020 10:46:19 PM
// Design Name: 
// Module Name: ten_bit_shift
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

//ten bit shift register that shifts its bits to the left, and replaces its
//least signficant bit with button press when load is 1
//When entire register is full 1's, this means that 10ms have passed, and
//it will send out its ten ms pulse signal to our positive edge detect circuit (PED)
//10ms is enough time for the "chatter" to go away
module ten_bit_shift(
    input clk,
    input rst,
    input load, //input signal received from button pulse (high active every 1ms)
    input button_press, //input signal received from button being pressed on FPGA
    output wire ten_ms_pulse //output signal that is sent to PED
    );
    
    reg [9:0] ten_ms; // 10 bit counter 
    
    assign ten_ms_pulse = ten_ms[9] & ten_ms[8] & ten_ms[7] & ten_ms[6] & ten_ms[5]
                        & ten_ms[4] & ten_ms[3] & ten_ms[2] & ten_ms[1] & ten_ms[0];
    // sends out a pulse when this register is entirely comprised of 1's from the button press, meaning 10ms have passed                    
    always@(posedge clk, posedge rst)
        if (rst)
            ten_ms <= 10'b0;
        else if (load) // shifts bits to the left and replaces least significant bit with value of button_press
            ten_ms <= {ten_ms[8:0], button_press};
endmodule
